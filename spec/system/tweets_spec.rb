# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :system do
  let(:user) { create(:user) }
  let(:tweet) { build(:tweet) }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  context 'when input is valid' do
    it 'ツイートフォームが表示されていること' do
      visit root_path

      expect(page).to have_selector('form')
    end

    it '正常にツイートできること' do
      visit root_path
      post(content: tweet.content)
      expect(page).to have_content('ポストしました')
    end

    it 'ツイートが一覧に表示されること' do
      create(:tweet, content: '既存のツイート', user:)

      visit root_path

      expect(page).to have_content('既存のツイート')
    end
  end

  context 'when input is invalid' do
    it '空の内容ではツイートできないこと' do
      visit root_path
      post(content: '')
      expect(page).to have_content('140文字以内でポストしてください')
    end

    it '140文字を超える内容ではツイートできないこと' do
      visit root_path
      post(content: 'あ' * 141)
      expect(page).to have_content('140文字以内でポストしてください')
    end
  end

  def post(content:)
    within('#recommend-tab-pane') do
      fill_in 'tweet[content]', with: content
      click_button 'ポストする'
    end
  end
end
