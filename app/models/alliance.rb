class Alliance < ActiveRecord::Base
  attr_accessible :name
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  
  has_many :messages, :as => :messagable
  
  alliance_regex = /^\w+$/
  
  validates :name, :presence => true,
                   :format   => { :with => alliance_regex, :message => "Only letters, numbers and underscores allowed." },
                   :length   => { :maximum => 50 },
                   :uniqueness => { :case_sensitive => false }
                   
  validates :user_id, :presence => true
  
  def owned_by?(user)
    user == owner
  end
  
  def has_member?(user)
    users.includes?(user)
  end
end