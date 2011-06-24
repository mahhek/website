class UserHasAndBelongsToManyBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses_users, :id => false do |t|
      t.references :business, :user
    end
  end

  def self.down
    drop_table :businesses_users
  end
end
