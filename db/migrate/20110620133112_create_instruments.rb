class CreateInstruments < ActiveRecord::Migration
  def self.up
    create_table :instruments do |t|
      t.string :name
      t.boolean :enable, :default => true

      t.timestamps
    end
    Instrument.new(:name => "All").save
    Instrument.new(:name => "Accordian").save
    Instrument.new(:name => "Bass Guitar").save
    Instrument.new(:name => "Cello").save
    Instrument.new(:name => "Clarinet").save
    Instrument.new(:name => "Double Bass").save
    Instrument.new(:name => "Drums").save
    Instrument.new(:name => "Electronic").save
    Instrument.new(:name => "Flute").save
    Instrument.new(:name => "Guitar").save
    Instrument.new(:name => "Harmonica").save
    Instrument.new(:name => "Oboe").save
    Instrument.new(:name => "Piano").save
    Instrument.new(:name => "Saxophone").save
    Instrument.new(:name => "Trombone").save
    Instrument.new(:name => "Trumpet").save
    Instrument.new(:name => "Tuba").save
    Instrument.new(:name => "Voila").save
    Instrument.new(:name => "Violin").save
    Instrument.new(:name => "Voice - Alto").save
    Instrument.new(:name => "Voice - Baritone").save
    Instrument.new(:name => "Voice - Bass").save
    Instrument.new(:name => "Voice - Soprano").save
    Instrument.new(:name => "Voice - Tenor").save

  end

  def self.down
    drop_table :instruments
  end
end
