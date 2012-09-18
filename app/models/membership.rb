class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :alliance
  
  scope :for_user, lambda { |user| where("user_id = ?", user)}
end
