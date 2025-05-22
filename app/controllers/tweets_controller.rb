# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to root_path(tab: 'recommend') if params[:tab].nil? # デフォルトでおすすめタブが見えるようにする
    @tweets = Tweet.all.order(created_at: 'DESC').page(params[:recommend]).per(5)
                   .with_attached_images.includes(user: { icon_image_attachment: :blob })
    @following_user_tweets = @tweets.where(user_id: current_user.following_user_ids).page(params[:follow]).per(5)
    @tweet = Tweet.new # 新規ポスト用の空のインスタンス
  end

  def show; end

  def new; end

  def edit; end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to request.referer, notice: 'ポストしました。'
    else
      redirect_to request.referer, alert: '140文字以内でポストしてください。'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, images: [])
  end
end
