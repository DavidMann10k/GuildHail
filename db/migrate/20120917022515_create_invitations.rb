class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :message
      t.integer :sender_user_id
      t.integer :recipient_user_id
      t.integer :alliance_id
      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
