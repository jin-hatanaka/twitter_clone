# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    # @tweetに関連づけられたCommentクラスの新しいインスタンスを作成
    @comment = @tweet.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to request.referer, notice: 'コメントをしました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:content, images: [])
  end
end
