class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :memberships
  has_many :alliances, :through => :memberships
  
  has_many :assignments
  has_many :roles, :through => :assignments
  
  ROLES = %w[admin mod banned]
  
  def role?(role)
    roles.include? role.to_s
  end
end
