# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :uid,      null: false, default: ''
      t.string :provider, null: false, default: ''
    end

    add_index :users, %i[uid provider], unique: true
  end
end
