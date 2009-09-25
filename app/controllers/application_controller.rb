# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery
  filter_parameter_logging :secret_access_key
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  # This is for navigation purpose
  attr_reader :tab_name, :subtab_name
  
  def login_required
    authorized? || access_denied
  end
  
  def authorized?
    if RAILS_ENV['cucumber'] || RAILS_ENV['test']
      session[:identity_url] = 'test'
      return true
    else
      !session[:identity_url].nil?
    end
  end

  def access_denied
    respond_to do |format|
      format.html do
        redirect_to openid_login_path
      end
    end
  end
  
  protected
  
    # Automatically respond with 404 for ActiveRecord::RecordNotFound
    def record_not_found
      render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
    end
end
