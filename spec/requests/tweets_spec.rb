# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  let(:user) { create(:user) }
  let(:tweet) { build(:tweet) }
  let(:tweet_params) { attributes_for(:tweet) }
  let(:invalid_tweet_params) { attributes_for(:tweet, content: "") }

  before do
    sign_in user
  end

  context '正常系' do
    it 'リクエストが成功すること' do
      post tweets_path, params: { tweet: tweet_params }, headers: { 'HTTP_REFERER' => root_path }
      expect(response).to have_http_status(302)
    end

    it 'createが成功すること' do
      expect do
        post tweets_path, params: { tweet: tweet_params }, headers: { 'HTTP_REFERER' => root_path }
      end.to change(Tweet, :count).by(1)
    end
    
    it 'create後に root_path にリダイレクトされること' do
      post tweets_path, params: { tweet: tweet_params }, headers: { 'HTTP_REFERER' => root_path }
      expect(response).to redirect_to(root_path)
    end
  end

  context '異常系' do
    it 'リクエストが失敗すること' do
      post tweets_path, params: { tweet: invalid_tweet_params }, headers: { 'HTTP_REFERER' => root_path }
      expect(response).to have_http_status(302)
    end

    it 'createが失敗すること' do
      expect do
        post tweets_path, params: { tweet: invalid_tweet_params }, headers: { 'HTTP_REFERER' => root_path }
      end.not_to change(Tweet, :count)
    end
  end
end
