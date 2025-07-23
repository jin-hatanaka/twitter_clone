# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many_attached :images

  validates :content, length: { maximum: 140 }, presence: true

  # ユーザーがツイートをいいねしたかどうかを判定するメソッド。
  # tweetに結びついているいいね(like)の中で今いいねしようとしているuser_idが存在するか判定している。
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def retweeted_by?(user)
    retweets.exists?(user_id: user.id)
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  def check_notification(current_user, action)
    # いいね or リツイートされているか検索
    temp = current_user.active_notifications.where(visited_id: user_id, tweet_id: id, action:)
    temp.present?
  end

  def create_notification!(current_user, action, comment_id: nil)
    # いいね or リツイートされている場合は処理を終了
    return if check_notification(current_user, action) && %w[like retweet].include?(action)

    notification = current_user.active_notifications.new(
      visited_id: user_id,
      tweet_id: id,
      comment_id:,
      action:,
      # 自分の投稿に対するいいね、リツイート、コメントの場合は通知済みとする
      checked: current_user.id == user_id
    )
    notification.save if notification.valid?
    NotificationMailer.send_notification(notification).deliver_now
  end
end
