class Message < ActiveRecord::Base
  attr_accessible :content, :messagable_id, :messagable_type
  belongs_to :messagable, :polymorphic => true
  belongs_to :user
    
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
  def self.to(u)
    where("messagable_id = ? AND messagable_type = ?", u.id, u.class.to_s)
  end
  def self.from_to(from, to)
    where("user_id = ? AND messagable_id = ? AND messagable_type = ?", from.id, to.id, to.class.to_s)
  end
end
