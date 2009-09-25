class CloudLinode < Cloud
  
  validates_presence_of :access_key

  validate :validates_keys_existence
  def validates_keys_existence
    begin
      @linode = Linode.new(:api_key => access_key)
      @linode.test.echo(:ping => "pong")
    rescue Exception => e
      errors.add_to_base(e.message)
      return false
    end
    
    true
  end

  def support_access_key?
    true
  end  
end