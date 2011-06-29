class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_target, :class_name => 'User', :foreign_key => 'user_id_target'
  validates :user, :presence => true
  validates :user_target, :presence => true


  #    scope :today, lambda { where(["DATE(created_at) = Date(?)", Time.now]) }
  def before_create()
		self.code = UUIDTools::UUID.timestamp_create().to_s
	end

  def self.today
    where(["DATE(created_at) = Date(?)", Time.now])
  end



  validates_uniqueness_of :user_id, :scope => :user_id_target
  validates_uniqueness_of :user_id_target, :scope => :user_id

  validate :cannot_invite_self

  def cannot_invite_self
    errors.add(:base, "You cannot be a friend of your own") if user_id == user_id_target
  end
end
