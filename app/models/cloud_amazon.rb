class CloudAmazon < Cloud
  
  validates_presence_of :access_key
  validates_presence_of :secret_access_key

  validate :validates_keys_existence
  def validates_keys_existence
    begin
      @ec2 = RightAws::Ec2.new(access_key, secret_access_key)
      @ec2.describe_key_pairs
    rescue RightAws::AwsError => e
      errors.add_to_base(e.message)
      return false
    end
    
    true
  end

  def support_access_key?
    true
  end
  
  def ec2
    RightAws::Ec2.new(access_key, secret_access_key)
  end  
  
end