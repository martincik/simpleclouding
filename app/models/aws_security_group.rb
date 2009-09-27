class AwsSecurityGroup < ActiveRecord::Base
  
  belongs_to :cloud
  
  validates_presence_of :name
  
  def save
    begin
      save! 
    rescue Exception => e
      errors.add_to_base(e.message)
      return false
    end
  end
  
  def save!
    return false unless valid?
    cloud.ec2.create_security_group(name, description)  
  end
  
  def destroy
    begin
      destroy!
    rescue Exception => e
      errors.add_to_base(e.message)
      return false
    end
  end
  
  def destroy!
    cloud.ec2.delete_security_group(name)
  end
  
  def self.all_for_cloud(cloud)
    cloud.ec2.describe_security_groups.map do |security_group|
      AwsSecurityGroup.new(
        :name => security_group[:aws_group_name],
        :owner => security_group[:aws_owner],
        :description => security_group[:aws_description]
      )
    end
  end
  
  def self.find_by_group_name_for_cloud(cloud, name)
    security_group = cloud.ec2.describe_security_groups([name]).first

    AwsSecurityGroup.new(
      :name => security_group[:aws_group_name],
      :owner => security_group[:aws_owner],
      :description => security_group[:aws_description]
    )    
  end
  
end
