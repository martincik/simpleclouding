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

  def cloud_options_as_locals
    { 
      :security_groups => security_groups_as_select_options,
      :key_pairs => key_pairs_as_select_options
    }
  end
  
  def security_groups_as_select_options
    AwsSecurityGroup.all_for_cloud(self).inject({}) {|sg_map, sg| sg_map[sg.name] = sg.name; sg_map }
  end
  
  def key_pairs_as_select_options
    AwsKeyPair.all_for_cloud(self).inject({}) {|kp_map, kp| kp_map[kp.name] = kp.name; kp_map }
  end
  
end