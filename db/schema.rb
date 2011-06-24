# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110623210710) do

  create_table "audio_attachments", :force => true do |t|
    t.integer  "user_id"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.boolean  "enable",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses_users", :id => false, :force => true do |t|
    t.integer "business_id"
    t.integer "user_id"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.boolean  "enable",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_users", :id => false, :force => true do |t|
    t.integer "genre_id"
    t.integer "user_id"
  end

  create_table "instruments", :force => true do |t|
    t.string   "name"
    t.boolean  "enable",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instruments_users", :id => false, :force => true do |t|
    t.integer "instrument_id"
    t.integer "user_id"
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.string   "country_code"
    t.string   "county"
    t.string   "region"
    t.string   "city"
    t.string   "zipcode"
    t.string   "street"
    t.decimal  "latitude",       :precision => 15, :scale => 10
    t.decimal  "longitude",      :precision => 15, :scale => 10
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "user_profiles", :force => true do |t|
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_slug"
    t.string   "band_name"
    t.string   "organization"
    t.string   "country"
    t.string   "postal_code"
    t.string   "phone"
    t.text     "about_us"
    t.string   "referred_by"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "maiden_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
