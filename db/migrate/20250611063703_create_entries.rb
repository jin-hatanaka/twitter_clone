# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end

    add_index :entries, %i[user_id room_id], unique: true
  end
end
