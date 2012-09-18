class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :time_zone
  
  has_many :memberships
  has_many :alliances, :through => :memberships
  
  has_many :owned_alliances, :class_name => "Alliance"
  
  has_many :assignments
  has_many :roles, :through => :assignments
  
  has_many :sent_invitations, :class_name => "Invitation"
  has_many :recieved_invitations, :class_name => "Invitation"

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  user_regex = /^\w+$/
  
  validates :name, :presence => true,
                   :format   => { :with => user_regex, :message => "Only letters, numbers and underscores allowed." },
                   :length   => { :maximum => 50 },
                   :uniqueness => { :case_sensitive => false }
           
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  validates :time_zone, :presence   => true

  scope :by_name, order('name ASC')
  scope :by_date, order('created_on ASC')
  
  ROLES = %w[admin mod banned]
  
  def role?(role)
    roles.all.map(&:name).include? role.to_s
  end
  
  def owns?(alliance)
    user == alliance.owner
  end
end
