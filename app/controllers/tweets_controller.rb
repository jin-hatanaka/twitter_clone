# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.all.order(created_at: 'DESC').page(params[:recommend]).per(5).with_attached_images.includes(user: { icon_image_attachment: :blob })
    @user = current_user
    @my_following_users_tweets = @user.following_user_tweets
    @my_following_users_tweets = Kaminari.paginate_array(@my_following_users_tweets).page(params[:follow]).per(5)
  end

  def show; end

  def new
    @tweet = Tweet.new
  end

  def edit; end
end
