class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :businesses
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :instruments
  has_one :user_profile
  has_many :audio_attachments
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  acts_as_network :friends, :through => :invites, :foreign_key => 'user_id',
    :association_foreign_key => 'user_id_target', :conditions => ["is_accepted = ?",true]

	def self.search_for name
    words = name.split(' ')
    # must be a more elegant way
    if words.size == 1
      self.find :all, :conditions => ['first_name like :term or last_name like :term or email like :term', {:term => "%#{name}%"}], :order => :last_name
    elsif words.size == 2
      self.find :all, :conditions => ['first_name like :first_name and last_name like :last_name', {:first_name => "%#{words.first}%", :last_name => "%#{words.last}%"}], :order => :last_name
    else
      clauses = []
      params = {}
      words.each_with_index do | word, index |
        term = "%#{word}%"
        sym = "term_#{index}".to_sym
        clauses << "first_name like :#{sym} or last_name like :#{sym} or email like :#{sym}"
        params[sym] = term
      end

      conditions = clauses.join(' and ')

      self.find(:all, :conditions => [conditions, params], :order => :last_name).uniq
    end
	end

  def can_invite?
    invites_out.where(["DATE(created_at) = Date(?)", Time.now]).count < 10
  end

  def fullname
    n = (self.first_name + ' ' + self.last_name).strip
    n.length() ? n :'n/a'
  end
  
  def musician?
    self.role?("Musician")
  end

  def not_musician?
    !(self.role?("Musician"))
  end

  def school?
    self.role?("School")
  end

  def business?
    self.role?("Business")
  end

  def not_business?
    !(self.role?("Business"))
  end

  def venue?
    self.role?("Venue")
  end


  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
