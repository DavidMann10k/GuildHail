class Invitation < ActiveRecord::Base
  attr_accessible :message, :sender_user_id, :recipient_user_id, :alliance_id
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_user_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_user_id"
  belongs_to :alliance
  
  scope :sent_by, lambda { |user| where("sender_user_id = ?", user)}
  scope :recieved_by, lambda { |user| where("recipient_user_id = ?", user)}
end