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

ActiveRecord::Schema.define(:version => 20090220091907) do

  create_table "accounts", :force => true do |t|
    t.string   "subdomain"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aws_elastic_ips", :force => true do |t|
    t.string   "address"
    t.string   "instance_id"
    t.integer  "cloud_id",    :null => false
    t.integer  "account_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aws_instances", :force => true do |t|
    t.string   "image_id"
    t.string   "reason"
    t.string   "state_code"
    t.string   "owner"
    t.string   "instance_id"
    t.string   "reservation_id"
    t.string   "state"
    t.string   "dns_name"
    t.string   "ssh_key_name"
    t.string   "groups"
    t.string   "private_dns_name"
    t.string   "instance_type"
    t.string   "launch_time"
    t.string   "availability_zone"
    t.string   "kernel_id"
    t.string   "ramdisk_id"
    t.integer  "cloud_id",          :null => false
    t.integer  "account_id",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aws_key_pairs", :force => true do |t|
    t.string   "fingerprint"
    t.string   "key_name"
    t.string   "material"
    t.integer  "cloud_id",    :null => false
    t.integer  "account_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aws_security_group_ingresses", :force => true do |t|
    t.string   "source_group_name"
    t.string   "source_group_owner"
    t.integer  "cloud_id",              :null => false
    t.integer  "aws_security_group_id", :null => false
    t.integer  "account_id",            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aws_security_group_ip_ingresses", :force => true do |t|
    t.integer  "to_port"
    t.integer  "from_port"
    t.string   "protocol"
    t.string   "cidr_ip"
    t.integer  "cloud_id",              :null => false
    t.integer  "aws_security_group_id", :null => false
    t.integer  "account_id",            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aws_security_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "owner"
    t.integer  "cloud_id",    :null => false
    t.integer  "account_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clouds", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "access_key"
    t.string   "secret_access_key"
    t.string   "type"
    t.integer  "account_id",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clusters", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "account_id",  :null => false
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "account_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "account_id",  :null => false
    t.integer  "project_id"
    t.integer  "cluster_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "identity_url"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",                                               :null => false
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
