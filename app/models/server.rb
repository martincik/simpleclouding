class Server < ActiveRecord::Base
  
  belongs_to :cloud

  validates_presence_of :name
  
  before_save :launch_instance
  
  def launch_instance
    ec2 = RightAws::Ec2.new('AKIAIDFDWUQAAFHYSS5Q', '9UvTkXgfb8osmh4Q/7jM96gOPkhi7Z3l9pxulFPK')     
    instance = ec2.launch_instances('ami-11ca2d78', 
      :group_ids => 'simpleclouding_test',
      :user_data => name,
      :addressing_type => "public",
      :key_name => "simpleclouding_test",
      :availability_zone => "us-east-1c")
      
    self.reservation_id = instance.first[:aws_reservation_id]
  end
end
