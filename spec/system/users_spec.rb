# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'サインアップ' do
    let(:user) { build(:user) }

    context '正常系' do
      it 'サインアップできること' do
        visit new_user_registration_path

        fill_in '名前', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in '電話番号', with: user.phone_number
        fill_in '生年月日', with: user.birth_date
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード確認用', with: user.password_confirmation
        click_button '登録する'

        # メール送信を確認
        expect(ActionMailer::Base.deliveries.size).to eq(1)

        # フラッシュメッセージを確認
        expect(page).to have_content('本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。')

        # ログインボタンが表示されていることを確認
        expect(page).to have_button('ログイン')
      end
    end

    context '異常系' do
      it 'サインアップできないこと' do
        visit new_user_registration_path

        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: user.email
        fill_in '電話番号', with: user.phone_number
        fill_in '生年月日', with: user.birth_date
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード確認用', with: user.password_confirmation
        click_button '登録する'

        # フラッシュメッセージを確認
        expect(page).to have_content('エラーが発生したため ユーザー は保存されませんでした。')

        # 認証メールが送信されていないことを確認
        expect(ActionMailer::Base.deliveries.size).to eq(0)
      end
    end
  end

  describe 'ログイン' do
    let(:user) { create(:user) }

    context '正常系' do
      it 'ログインできること' do
        visit new_user_session_path

        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'

        # フラッシュメッセージを確認
        expect(page).to have_content('ログインしました。')

        # ログインユーザー名が表示されていることを確認
        expect(page).to have_content user.name

        # ログアウトボタンが表示されていることを確認
        expect(page).to have_link 'ログアウト'
      end
    end

    context '異常系' do
      it 'ログインできないこと' do
        visit new_user_session_path

        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        click_button 'ログイン'

        # フラッシュメッセージを確認
        expect(page).to have_content('Eメールまたはパスワードが違います。')

        # ログインボタンが表示されていることを確認
        expect(page).to have_button('ログイン')
      end
    end
  end
end
