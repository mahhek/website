class UserHasAndBelongsToManyGenres < ActiveRecord::Migration
  def self.up
    create_table :genres_users, :id => false do |t|
      t.references :genre, :user
    end
  end

  def self.down
    drop_table :genres_users
  end
end
