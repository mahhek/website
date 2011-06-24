class AudioAttachment < ActiveRecord::Base
#  has_attached_file :content_type => [ 'application/mp3', 'audio/mpeg' ], :size => 0..20.megabytes, :processor   => :none
#  validates_as_attachment
   has_attached_file :audio  ,
                    :url => "/assets/:class/:id/:attachment/:style.:extension",
                    :path => ":rails_root/public/assets/:class/:id/:attachment/:style.:extension"

  belongs_to :user


	def self.total_file_size (user)
		AudioAttachment.calculate(:sum, :size, :conditions => ['user_id = ?', user.id])
	end
end
