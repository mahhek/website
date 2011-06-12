class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    Role.create(:name => "Admin")
    Role.create(:name => "Staff")
    Role.create(:name => "Coach")
    Role.create(:name => "Composer")
    Role.create(:name => "Business")
    Role.create(:name => "Venue")
    Role.create(:name => "School")   

  end

  def self.down
    drop_table :roles
  end
end
