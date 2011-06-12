class AddUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    Role.create(:name => "Admin")
    Role.create(:name => "Staff")
    Role.create(:name => "Coach")
    Role.create(:name => "Composer")
    Role.create(:name => "Business")
    Role.create(:name => "Venue")
    Role.create(:name => "School")

    user = User.new(:email => "admin@website.com", :password => "admin123", :first_name => "admin", :last_name => "admin" )
    user.roles << Role.find_by_name("Admin")
    user.save!
  end

  def self.down
    remove_column :users, :username
  end
end
