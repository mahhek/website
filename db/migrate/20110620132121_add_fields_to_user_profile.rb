class AddFieldsToUserProfile < ActiveRecord::Migration
  def self.up
    add_column :user_profiles, :band_name, :string
    add_column :user_profiles, :organization, :string
    add_column :user_profiles, :country, :string
    add_column :user_profiles, :postal_code, :string
    add_column :user_profiles, :phone, :string
    add_column :user_profiles, :about_us, :text
    add_column :user_profiles, :referred_by, :string
  end

  def self.down
  end
end
