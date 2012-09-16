class CreateAlliances < ActiveRecord::Migration
  def self.up
    create_table :alliances do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :alliances
  end
end
