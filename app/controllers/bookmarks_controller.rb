# frozen_string_literal: true

class BookmarksController < ApplicationController
  def index
    @bookmark_tweets = current_user.bookmark_tweets.order('bookmarks.created_at DESC')
  end

  def create
    bookmark = current_user.bookmarks.build(tweet_id: params[:tweet_id])
    bookmark.save!
    redirect_to request.referer, notice: 'ブックマークに追加しました'
  end

  def destroy
    bookmark = current_user.bookmarks.find_by(tweet_id: params[:tweet_id])
    bookmark.destroy!
    redirect_to request.referer, notice: 'ブックマークから削除しました'
  end
end
