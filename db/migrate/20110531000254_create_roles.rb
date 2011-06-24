class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    Role.new(:name => "Admin").save
    Role.new(:name => "Staff").save
    Role.new(:name => "Musician").save
    Role.new(:name => "Business").save
    Role.new(:name => "Venue").save
    Role.new(:name => "School").save

  end

  def self.down
    drop_table :roles
  end
end
