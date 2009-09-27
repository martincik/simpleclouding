class Aws::KeyPairsController < Aws::AwsController

  def index
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_key_pairs = AwsKeyPair.all_for_cloud(@cloud)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def new
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_key_pair = AwsKeyPair.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @key_pair }
    end
  end
  
  def create
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_key_pair = AwsKeyPair.new(params[:key_pair])
    @aws_key_pair.cloud = @cloud
    
    respond_to do |format|
      if @aws_key_pair.save
        session[:aws_key_pairs] ||= {}
        session[:aws_key_pairs][@aws_key_pair.fingerprint] = {}
        session[:aws_key_pairs][@aws_key_pair.fingerprint][:key_name] = @aws_key_pair.key_name
        session[:aws_key_pairs][@aws_key_pair.fingerprint][:material] = @aws_key_pair.material
        
        flash[:notice] = 'Security Group successfully created.'
        format.html { redirect_to(cloud_aws_key_pairs_url(@cloud)) }
        format.xml  { render :xml => @aws_key_pair, :status => :created, :location => @aws_key_pair }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @key_pair.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @cloud = CloudAmazon.find(params[:cloud_id])
    if session[:aws_key_pairs].blank? # Make sure the session exists
      redirect_to(cloud_aws_key_pairs_url(@cloud)) and return
    end
    
    material = session[:aws_key_pairs][params[:fingerprint]][:material]
    key_name = session[:aws_key_pairs][params[:fingerprint]][:key_name]
    session[:aws_key_pairs][params[:fingerprint]] = nil # Just one download!
    
    respond_to do |format|
      format.any {
        send_data(material, :filename => "#{key_name}.pem", :type => "plain/text")
      }
    end
  end
  
  def destroy
    @cloud = CloudAmazon.find(params[:cloud_id])
    @aws_key_pair = AwsKeyPair.new(:key_name => params[:key_name])
    @aws_key_pair.cloud = @cloud
    
    @aws_key_pair.destroy
    
    respond_to do |format|
      format.html { redirect_to(cloud_aws_key_pairs_url(@cloud)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
    def setup_awstab
      @awstab_name = 'key_pairs'
    end

end