# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090927112725) do

  create_table "aws_key_pairs", :force => true do |t|
    t.string   "fingerprint"
    t.string   "key_name"
    t.string   "material"
    t.integer  "cloud_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aws_security_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "owner"
    t.integer  "cloud_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clouds", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "access_key"
    t.string   "secret_access_key"
    t.string   "type"
    t.string   "identity_url",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "cloud_id",          :null => false
    t.text     "server_attributes"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
