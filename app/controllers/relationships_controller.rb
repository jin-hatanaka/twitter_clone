# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    # current_userに紐付いたRelationshipクラスの新しいインスタンスを作成。
    # つまり、relationship.following_id = current_user.idが済んだ状態で生成されている。
    # buildはnewと同じ意味で、アソシエーションしながらインスタンスをnewする時に形式的に使われる。
    follow = current_user.relationships.build(follower_id: params[:user_id])
    follow.save!
    user = User.find(params[:user_id])
    user.create_notification_follow!(current_user)
    # 直前のページにリダイレクトする。
    redirect_to request.referer, notice: "#{follow.follower.name}さんをフォローしました"
  end

  def destroy
    follow = current_user.relationships.find_by(follower_id: params[:user_id])
    follow.destroy!
    redirect_to request.referer, notice: "#{follow.follower.name}さんのフォローを解除しました"
  end
end
