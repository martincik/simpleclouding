class CreateAwsSecurityGroups < ActiveRecord::Migration
  def self.up
    create_table :aws_security_groups do |t|
      t.string :name
      t.text   :description
      t.string :owner
      
      t.integer :cloud_id, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :aws_seurity_groups
  end
end
