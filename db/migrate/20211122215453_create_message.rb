class CreateMessage < ActiveRecord::Migration[5.1]
  def up
    create_table :messages do |t|
      t.references :chat
      t.text :description
      t.integer :seq_num

      t.timestamps
    end
  end

  def down
    drop_table :messages
  end
end
