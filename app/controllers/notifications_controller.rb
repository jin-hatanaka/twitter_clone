# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications # ログインユーザーが受け取る側の通知データを取得
                                 .where.not(visitor_id: current_user.id) # 自分の投稿に対する通知は表示しない

    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
