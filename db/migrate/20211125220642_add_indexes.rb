class AddIndexes < ActiveRecord::Migration[5.1]
  def up
    add_index :applications, :token, unique: true
    add_index :chats, [:application_id, :seq_num], unique: true
    add_index :messages, [:chat_id, :seq_num], unique: true
  end

  def down
    remove_index :tables, :applications, :token
    remove_index :chats, [:application_id, :seq_num], unique: true
    remove_index :messages, [:chat_id, :seq_num], unique: true
  end
end
