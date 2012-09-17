class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.message :string
      t.alliance_id :integer
      t.sender_user_id :integer
      t.recipient_user_id :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
