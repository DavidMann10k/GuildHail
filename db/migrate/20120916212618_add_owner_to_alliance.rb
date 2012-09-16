class AddOwnerToAlliance < ActiveRecord::Migration
  def change
    add_column :alliances, :user_id, :integer
  end
end
