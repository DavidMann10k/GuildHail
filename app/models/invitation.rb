class Invitation < ActiveRecord::Base
  attr_accessible :message, :sender_user_id, :recipient_user_id, :alliance_id
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_user_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_user_id"
  belongs_to :alliance
  
  scope :sent_by, lambda { |user| where("sender_user_id = ?", user)}
  scope :recieved_by, lambda { |user| where("recipient_user_id = ?", user)}
  
  def self.exists_for?(user, alliance)
    Invitation.recieved_by(user).map(&:alliance).include?(alliance)
  end
  
  def readable_by?(user)
    return true if recipient == user
    return true if sender == user
    return true if user.owns?(alliance)
    return false
  end
end