class CreateAwsKeyPairs < ActiveRecord::Migration
  def self.up
    create_table :aws_key_pairs do |t|
      t.string :fingerprint, :key_name, :material
      
      t.integer :cloud_id, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :aws_key_pairs
  end
end
