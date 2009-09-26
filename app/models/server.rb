class Server < ActiveRecord::Base
  
  belongs_to :cloud

  validates_presence_of :name
end
