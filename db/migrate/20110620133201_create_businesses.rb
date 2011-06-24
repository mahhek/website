class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string :name
      t.boolean :enable, :default => true

      t.timestamps
    end
    Business.new(:name => "Stores").save
    Business.new(:name => "Management").save
    Business.new(:name => "Producers").save
    Business.new(:name => "Distributors").save
    Business.new(:name => "Radio Stations").save
    Business.new(:name => "Disc Manufacturing").save
    Business.new(:name => "Publishing").save
    Business.new(:name => "Publicity & Promotion").save
    Business.new(:name => "Legal").save
  end

  def self.down
    drop_table :businesses
  end
end
