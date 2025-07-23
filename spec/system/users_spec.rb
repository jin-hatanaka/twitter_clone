# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'サインアップ' do
    let(:user) { build(:user) }

    context 'when input is valid' do
      before do
        visit new_user_registration_path

        fill_in '名前', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in '電話番号', with: user.phone_number
        fill_in '生年月日', with: user.birth_date
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード確認用', with: user.password_confirmation
        click_button '登録する'
      end

      it '認証メールが送信されていること' do
        expect(ActionMailer::Base.deliveries.size).to eq(1)
      end

      it 'フラッシュメッセージが表示されていること' do
        expect(page).to have_content('本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。')
      end

      it 'ログインボタンが表示されていること' do
        expect(page).to have_button('ログイン')
      end
    end

    context 'when input is invalid' do
      before do
        visit new_user_registration_path

        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: user.email
        fill_in '電話番号', with: user.phone_number
        fill_in '生年月日', with: user.birth_date
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード確認用', with: user.password_confirmation
        click_button '登録する'
      end

      it 'フラッシュメッセージが表示されていること' do
        expect(page).to have_content('エラーが発生したため ユーザー は保存されませんでした。')
      end

      it '認証メールが送信されていないこと' do
        expect(ActionMailer::Base.deliveries.size).to eq(0)
      end
    end
  end

  describe 'ログイン' do
    let(:user) { create(:user) }

    context 'when input is valid' do
      before do
        visit new_user_session_path

        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      it 'フラッシュメッセージが表示されていること' do
        expect(page).to have_content('ログインしました。')
      end

      it 'ログインユーザー名が表示されていること' do
        expect(page).to have_content user.name
      end

      it 'ログアウトボタンが表示されていること' do
        expect(page).to have_link 'ログアウト'
      end
    end

    context 'when input is invalid' do
      before do
        visit new_user_session_path

        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
      end

      it 'フラッシュメッセージが表示されていること' do
        expect(page).to have_content('Eメールまたはパスワードが違います。')
      end

      it 'ログインボタンが表示されていること' do
        expect(page).to have_button('ログイン')
      end
    end
  end
end
