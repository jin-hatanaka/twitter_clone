# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images

  # tweetに結びついているいいね(like)の中で今いいねしようとしているuser_idが存在するか
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def retweeted_by?(user)
    retweets.exists?(user_id: user.id)
  end
end
