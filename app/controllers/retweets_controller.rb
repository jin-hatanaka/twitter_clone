# frozen_string_literal: true

class RetweetsController < ApplicationController
  def create
    @retweet = current_user.retweets.build(tweet_id: params[:tweet_id])
    @retweet.save!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @retweet = current_user.retweets.find_by(tweet_id: params[:tweet_id])
    @retweet.destroy!
    redirect_back(fallback_location: root_path)
  end
end
