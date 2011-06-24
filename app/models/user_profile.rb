class UserProfile < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :picture, :styles => { :'300' => "300x300#", :'150' => '150x150#', :'100' => "100x100#", :'70' => "70x70#", :'50' => "50x50#", :'30' => "30x30#" }, :default_url => '/images/profile/missing_:style.png'
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true

  validates :country, :presence => true
  validates :band_name, :presence => true
  validates :organization, :presence => true
  
    acts_as_located

  def name
      n = (user.first_name + ' ' + user.last_name).strip
      n.length()?n:'n/a'
    end
  end
