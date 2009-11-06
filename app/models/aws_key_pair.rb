class AwsKeyPair < ActiveRecord::Base

  belongs_to :cloud

  validates_presence_of :key_name

  def name
    key_name
  end

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
    key_pair = cloud.ec2.create_key_pair(key_name)
    self.fingerprint = key_pair[:aws_fingerprint]
    self.material = key_pair[:aws_material]
    true
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
    cloud.ec2.delete_key_pair(key_name)
  end

  def self.all_for_cloud(cloud)
    cloud.ec2.describe_key_pairs.map do |key_pair|
      AwsKeyPair.new(
        :fingerprint => key_pair[:aws_fingerprint],
        :key_name => key_pair[:aws_key_name]
      )
    end
  end

end
