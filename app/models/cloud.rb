class Cloud < ActiveRecord::Base

  # Origin is just helper attribute for forms
  attr_accessor :origin
  ORIGINS = [
    'Amazon Cloud', 'My Cloud'
  ]
  ORIGIN = {
    'AMAZON'  => ORIGINS[0],
    'MYCLOUD' => ORIGINS[1]
  }

  validates_presence_of :name

  def support_access_key?
    raise RuntimeError.new('Not implemented in abstract class!')
  end
  
end
