# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(tweet_id: params[:tweet_id])
    @like.save!
    tweet = Tweet.find(params[:tweet_id])
    tweet.create_notification!(current_user, 'like')
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.find_by(tweet_id: params[:tweet_id])
    @like.destroy!
    redirect_back(fallback_location: root_path)
  end
end
