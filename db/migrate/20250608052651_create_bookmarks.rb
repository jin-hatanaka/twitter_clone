# frozen_string_literal: true

class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps
    end

    add_index :bookmarks, %i[user_id tweet_id], unique: true
  end
end
