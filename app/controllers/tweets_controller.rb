# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :reset_previous_url, only: [:index]
  after_action :set_previous_url, only: [:index]

  def index
    # デフォルトでおすすめタブが見えるようにする
    redirect_to root_path(tab: 'recommend') if params[:tab].nil?
    @tweets = Tweet.all.order(created_at: 'DESC').page(params[:recommend]).per(5)
                   .with_attached_images.includes(user: { icon_image_attachment: :blob })
    @following_user_tweets = @tweets.where(user_id: current_user.following_user_ids).page(params[:follow]).per(5)
    # 新規ポスト用の空のインスタンス
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.order(created_at: 'DESC')
    @comment = current_user.comments.new
  end

  def new; end

  def edit; end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to request.referer, notice: 'ポストしました'
    else
      redirect_to request.referer, alert: '140文字以内でポストしてください'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, images: [])
  end
end
