class Message < ActiveRecord::Base
  attr_accessible :content, :messagable_id, :messagable_type
  belongs_to :messagable, :polymorphic => true
  belongs_to :user
  
  scope :for_user, lambda { |user| where(:messagable => user ) }
end
