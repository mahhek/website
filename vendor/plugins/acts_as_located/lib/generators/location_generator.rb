require 'rails/generators/migration'

class LocationGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @acts_as_located_source_root ||= File.expand_path('../templates', __FILE__)
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime('%Y%m%d%H%M%S')
  end

  def create_model_file
    migration_template 'create_locations.rb', 'db/migrate/create_locations.rb'
  end
end