class UsersHaveAndBelongToManyRoles < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
    
    user = User.new(:email => "admin@musociety.com", :password => "admin123", :first_name => "admin", :last_name => "admin" )
    user.roles << Role.find_by_name("Admin")
    user.save!
    user = User.new(:email => "staff@musociety.com", :password => "admin123", :first_name => "admin", :last_name => "admin" )
    user.roles << Role.find_by_name("Staff")
    user.save!

  end

  def self.down
    drop_table :roles_users
  end
end
