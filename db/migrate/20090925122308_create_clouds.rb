class CreateClouds < ActiveRecord::Migration
  def self.up
    create_table :clouds do |t|
      t.string  :name
      t.text    :description
      
      t.string  :access_key, :secret_access_key # For Amazon Cloud for now
      
      t.string :type # My own cloud, Amazon Cloud
      t.string :identity_url, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :clouds
  end
end
