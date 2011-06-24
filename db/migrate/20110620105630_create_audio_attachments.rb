class CreateAudioAttachments < ActiveRecord::Migration
  def self.up
    create_table :audio_attachments do |t|
      t.belongs_to :user
      t.string :audio_file_name
      t.string :audio_content_type
      t.integer :audio_file_size
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :audio_attachments
  end
end
