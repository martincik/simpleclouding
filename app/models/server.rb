class Server < ActiveRecord::Base
  
  serialize :server_attributes
  
  belongs_to :cloud

  validates_presence_of :name
  
  before_save :launch_instance
  before_destroy :terminate_instance
  
  def launch_instance
    ec2 = RightAws::Ec2.new(cloud.access_key, cloud.secret_access_key)     
    instances = ec2.launch_instances('ami-11ca2d78', 
      :group_ids => 'simpleclouding_test',
      :user_data => name,
      :addressing_type => "public",
      :key_name => "simpleclouding_test",
      :availability_zone => "us-east-1c")
      
    self.server_attributes = instances.first
  end
  
  def terminate_instance
    ec2 = RightAws::Ec2.new(cloud.access_key, cloud.secret_access_key)     
    ec2.terminate_instances([server_attributes[:aws_instance_id]])
  end
  
end
