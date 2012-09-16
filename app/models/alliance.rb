class Alliance < ActiveRecord::Base
  attr_accessible :name
  has_many :memberships
  has_many :users, :through => :memberships
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  
  alliance_regex = /^\w+$/
  
  validates :name, :presence => true,
                   :format   => { :with => alliance_regex, :message => "Only letters, numbers and underscores allowed." },
                   :length   => { :maximum => 50 },
                   :uniqueness => { :case_sensitive => false }
                   
  validates :user_id, :presence => true
end