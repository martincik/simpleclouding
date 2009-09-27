class Aws::SecurityGroupsController < Aws::AwsController

  def index
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_security_groups = AwsSecurityGroup.all_for_cloud(@cloud)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def new
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_security_group = AwsSecurityGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @security_group }
    end
  end
  
  def create
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_security_group = AwsSecurityGroup.new(params[:security_group])
    @aws_security_group.cloud = @cloud
    
    respond_to do |format|
      if @aws_security_group.save
        flash[:notice] = 'Security Group successfully created.'
        format.html { redirect_to(cloud_aws_security_groups_url(@cloud)) }
        format.xml  { render :xml => @aws_security_group, :status => :created, :location => @aws_security_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @security_group.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_security_group = AwsSecurityGroup.find_by_group_name_for_cloud(@cloud, params[:name])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aws_security_group }
    end
  end
  
  def destroy
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_security_group = AwsSecurityGroup.new(:name => params[:name])
    @aws_security_group.cloud = @cloud
    
    @aws_security_group.destroy
    
    respond_to do |format|
      format.html { redirect_to(cloud_aws_security_groups_url(@cloud)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
    def setup_awstab
      @awstab_name = 'security_groups'
    end

end