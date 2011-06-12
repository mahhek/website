class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :address
      t.string :country_code
      t.string :county
      t.string :region
      t.string :city
      t.string :zipcode
      t.string :street
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10

      # reference the polymorphic model locatable
      t.references :locatable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
