# frozen_string_literal: true

class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :self_introduction, :text
    add_column :users, :place, :string
    add_column :users, :website, :text
  end
end
