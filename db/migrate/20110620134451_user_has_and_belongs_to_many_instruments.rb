class UserHasAndBelongsToManyInstruments < ActiveRecord::Migration
  def self.up
    create_table :instruments_users, :id => false do |t|
      t.references :instrument, :user
    end
  end

  def self.down
    drop_table :instruments_users
  end
end
