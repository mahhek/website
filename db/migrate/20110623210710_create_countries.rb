class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    open("http://openconcept.ca/sites/openconcept.ca/files/country_code_drupal_0.txt") do |countries|
      countries.read.each_line do |country|
        abbreviation, name = country.chomp.split("|")
        Country.create!(:name => name, :code => abbreviation)
      end
    end
  end

  def self.down
    drop_table :countries
  end
end
