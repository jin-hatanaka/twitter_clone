# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :notifications, dependent: :destroy
  has_many_attached :images
end
