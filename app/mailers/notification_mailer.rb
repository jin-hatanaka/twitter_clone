# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def send_notification(notification)
    @notification = notification
    email = @notification.visited.email
    subjects = {
      'follow' => 'フォローされました',
      'like' => 'いいねがありました',
      'retweet' => 'リポストされました',
      'comment' => 'コメントがありました'
    }
    mail(to: email, subject: subjects[@notification.action])
  end
end
