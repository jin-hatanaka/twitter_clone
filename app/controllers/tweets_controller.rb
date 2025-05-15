# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    # デフォルトでおすすめタブが見えるようにする
    redirect_to root_path(tab: 'recommend') if params[:tab].nil?
    @tweets = Tweet.all.order(created_at: 'DESC').page(params[:recommend]).per(5)
                   .with_attached_images.includes(user: { icon_image_attachment: :blob })
    @following_user_tweets = @tweets.where(user_id: current_user.following_user_ids).page(params[:follow]).per(5)
  end

  def show; end

  def new
    @tweet = Tweet.new
  end

  def edit; end
end
