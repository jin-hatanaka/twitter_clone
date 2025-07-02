# frozen_string_literal: true

module NotificationsHelper
  def notification_icon(action)
    case action
    when 'follow'
      content_tag(:i, '', class: 'bi bi-person-fill')
    when 'like'
      content_tag(:i, '', class: 'bi bi-heart-fill')
    when 'retweet'
      content_tag(:i, '', class: 'bi bi-arrow-repeat')
    when 'comment'
      content_tag(:i, '', class: 'bi bi-chat-fill')
    end
  end

  def notification_content(action)
    contents = {
      'follow' => 'さんにフォローされました',
      'like' => 'さんがあなたのポストをいいねしました',
      'retweet' => 'さんがあなたのポストをリポストしました',
      'comment' => 'さんがあなたのポストにコメントしました'
    }

    contents[action]
  end
end
