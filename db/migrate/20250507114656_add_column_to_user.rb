# frozen_string_literal: true

class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.text :self_introduction
      t.string :place
      t.text :website
    end
  end
end
