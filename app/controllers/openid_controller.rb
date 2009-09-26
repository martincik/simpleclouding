require 'openid'
require 'openid/store/filesystem'

class OpenidController < ApplicationController
  layout 'login'
  
  def new
  end

  def create
    begin
      identifier = params[:openid_identifier]
      if identifier.nil?
        flash[:error] = "Enter an OpenID identifier"
        redirect_to :action => 'new' and return
      end
      oidreq = consumer.begin(identifier)
    rescue OpenID::OpenIDError => e
      flash[:error] = "Discovery failed for #{identifier}: #{e}"
      redirect_to :action => 'new' and return
    end
    
    return_to = url_for :action => 'complete', :only_path => false
    realm = url_for :action => 'index', :only_path => false
    
    if oidreq.send_redirect?(realm, return_to, params[:immediate])
      redirect_to oidreq.redirect_url(realm, return_to, params[:immediate])
    else
      render :text => oidreq.html_markup(realm, return_to, params[:immediate], {'id' => 'openid_form'})
    end
  end

  def complete
    current_url = url_for(:action => 'complete', :only_path => false)
    parameters = params.reject{|k,v|request.path_parameters[k]}
    oidresp = consumer.complete(parameters, current_url)
    
    case oidresp.status
    when OpenID::Consumer::FAILURE
      if oidresp.display_identifier
        flash[:error] = ("Verification of #{oidresp.display_identifier}"\
                         " failed: #{oidresp.message}")
      else
      end
        flash[:error] = "Verification failed: #{oidresp.message}"
    when OpenID::Consumer::SUCCESS
      flash[:success] = ("Verification of #{oidresp.display_identifier}"\
                         " succeeded.")
      session[:identity_url] = oidresp.identity_url
    when OpenID::Consumer::SETUP_NEEDED
      flash[:alert] = "Immediate request failed - Setup Needed"
    when OpenID::Consumer::CANCEL
      flash[:alert] = "OpenID transaction cancelled."
    else
    end
    
    redirect_to home_url
  end

  protected

    def consumer
      @openid_consumer ||= OpenID::Consumer.new(session,
        OpenID::Store::Filesystem.new("#{RAILS_ROOT}/tmp/openid"))
    end

end
