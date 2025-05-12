# frozen_string_literal: true

class ProfilesController < ApplicationController
  def index
    # デフォルトでツイートタブが見えるようにする
    redirect_to profiles_path(tab: 'tweet') if params[:tab].nil?
    @tweets = current_user.tweets.order(created_at: 'DESC').page(params[:tweet]).per(2)
    @like_tweets = current_user.like_tweets.order(created_at: 'DESC').page(params[:like]).per(2)
    @retweet_tweets = current_user.retweet_tweets.order(created_at: 'DESC').page(params[:retweet]).per(2)
    @comment_tweets = current_user.comment_tweets.order(created_at: 'DESC').page(params[:comment]).per(2)
  end

  def edit; end
end
