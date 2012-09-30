class Message < ActiveRecord::Base
  attr_accessible :content, :messagable_id, :messagable_type
  belongs_to :messagable, :polymorphic => true
  belongs_to :user
  
  scope :for, lambda { |messagable| where("messagable_id = ?, messagable_type = ? ", messagable.id, messagable.class) }
  
  def readable_by?(ruser)
    return true if messagable == ruser
    return true if user == ruser
    return true if ruser.member_of?(messagable)
    return false
  end
  
  def recipient
    return messagable
  end
  
  def sender
    return user
  end
  
  def self.from(u)
    where("user_id = ?", u.id)
  end
end
