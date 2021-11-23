class CreateChat < ActiveRecord::Migration[5.1]
  def up
    create_table :chats do |t|
      t.references :application
      t.integer :seq_num
      t.integer :messages_count, default: 0
      t.timestamps
    end
  end

  def down
    drop_table :chats
  end
end
