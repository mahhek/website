class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|      
      t.string   :picture_file_name
      t.string   :picture_content_type
      t.integer  :picture_file_size
      t.datetime :picture_updated_at

      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
