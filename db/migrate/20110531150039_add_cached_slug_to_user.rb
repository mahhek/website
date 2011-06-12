class AddCachedSlugToUser < ActiveRecord::Migration
  def self.up
    add_column :user_profiles, :cached_slug, :string
  end

  def self.down
    remove_column :user_profiles, :cached_slug
  end
end
