class CloudsController < ApplicationController
  
  before_filter :login_required
  before_filter :setup_tabs

  def index
    @clouds = Cloud.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clouds }
    end
  end

  def show
    @cloud = Cloud.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cloud }
    end
  end

  def new
    @cloud = Cloud.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cloud }
    end
  end

  def edit
    @cloud = Cloud.find(params[:id])
  end

  def create
    @cloud = CloudFactory.new_from_origin(params[:cloud].merge(:identity_url => session[:identity_url]))
    
    respond_to do |format|
      if @cloud.save
        flash[:notice] = 'Cloud successfully created.'
        format.html { redirect_to(cloud_url(@cloud)) }
        format.xml  { render :xml => @cloud, :status => :created, :location => @cloud }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cloud.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @cloud = Cloud.find(params[:id])

    respond_to do |format|
      if @cloud.update_attributes(params[:cloud])
        flash[:notice] = 'Cloud successfully updated.'
        format.html { redirect_to(cloud_url(@cloud)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cloud.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @cloud = Cloud.find(params[:id])
    @cloud.destroy

    respond_to do |format|
      format.html { redirect_to(clouds_url) }
      format.xml  { head :ok }
    end
  end

  protected
  
    def setup_tabs
      @tab_name = 'manage'
      @subtab_name = 'clouds'
    end

end