class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.column :user_id, :integer, :null => false
      t.column :user_id_target, :integer, :null => false
      t.column :code, :string
      t.column :message, :text
      t.column :is_accepted, :boolean, :default => false
      t.column :accepted_at, :timestamp

      t.timestamps
    end
    add_index :invites, :user_id
    add_index :invites, :user_id_target
    add_index :invites, :code

  end

  def self.down
    remove_index :invites, :user_id
    remove_index :invites, :user_id_target
    remove_index :invites, :code
    drop_table :invites
  end
end
