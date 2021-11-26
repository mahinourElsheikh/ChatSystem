class CreateApplication < ActiveRecord::Migration[5.1]
  def up
    create_table :applications do |t|
      t.string  :token
      t.string  :name
      t.integer :chats_count, default: 0

      t.timestamps
    end
  end

  def down
    drop_table :applications
  end
end
