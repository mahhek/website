class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    Role.save(:name => "Admin")
    Role.save(:name => "Staff")
    Role.save(:name => "Coach")
    Role.save(:name => "Composer")
    Role.save(:name => "Business")
    Role.save(:name => "Venue")
    Role.save(:name => "School")

  end

  def self.down
    drop_table :roles
  end
end
