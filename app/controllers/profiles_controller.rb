# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_tweet_tab, only: [:index]
  before_action :set_user, only: %i[edit update]
  before_action :reset_previous_url, only: [:index]
  after_action :set_previous_url, only: [:index]

  def index
    @tweets = current_user.tweets.order(created_at: 'DESC').page(params[:tweet]).per(2)
    @like_tweets = current_user.like_tweets.order('likes.created_at DESC').page(params[:like]).per(2)
    @retweet_tweets = current_user.retweet_tweets.order('retweets.created_at DESC').page(params[:retweet]).per(2)
    @comment_tweets = current_user.comment_tweets.order('comments.created_at DESC').page(params[:comment]).per(2)
  end

  def edit; end

  def update
    @user.update!(user_params)
    redirect_to profiles_path, notice: 'プロフィールを更新しました'
  end

  private

  # デフォルトでツイートタブが見えるようにする
  def set_tweet_tab
    redirect_to profiles_path(tab: 'tweet') if params[:tab].nil?
  end

  def user_params
    params.require(:user).permit(:name, :header_image, :icon_image, :self_introduction, :place, :website, :birth_date)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
