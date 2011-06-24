class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string :name
      t.boolean :enable, :default => true

      t.timestamps
    end
    Genre.new(:name => "All").save
    Genre.new(:name => "Alternative").save
    Genre.new(:name => "Classical").save
    Genre.new(:name => "Contemporary").save
    Genre.new(:name => "Electronic& DJ").save
    Genre.new(:name => "Ethnic").save
    Genre.new(:name => "Hip Hop, R&B").save
    Genre.new(:name => "Jazz").save
    Genre.new(:name => "Rock").save
  end

  def self.down
    drop_table :genres
  end
end
