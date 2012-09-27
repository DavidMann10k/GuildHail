class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer   :user_id
      t.text      :content
      t.integer   :messagable_id
      t.string    :messagable_type
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
