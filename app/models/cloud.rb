class Cloud < ActiveRecord::Base
  
  has_many :servers
  
  # Origin is just helper attribute for forms
  attr_accessor :origin
  ORIGINS = [
    'Amazon EC2 (aws.amazon.com)', 'Linode (linode.com)'
  ]
  ORIGIN = {
    'AMAZON'  => ORIGINS[0],
    'LINODE' => ORIGINS[1]
  }

  validates_presence_of :name

  def support_access_key?
    raise RuntimeError.new('Not implemented in abstract class!')
  end
  
  def self.all_clouds_for_select_with_blank
    all.inject({'' => 0}) {|cloud_map, cloud| cloud_map[cloud.name] = cloud.id; cloud_map }  
  end
 
end
