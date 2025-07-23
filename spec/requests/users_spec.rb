# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'サインアップ' do
    let(:user) { create(:user) }
    let(:user_params) { attributes_for(:user) } # ハッシュとして使えるパラメータuser_paramsを生成しておく
    let(:invalid_user_params) { attributes_for(:user, name: '') }

    context 'when input is valid' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to have_http_status(:see_other)
      end

      it 'createが成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by(1)
      end

      it '認証メールが送信されること' do
        post user_registration_path, params: { user: user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
    end

    context 'when input is invalid' do
      it 'リクエストが失敗すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.not_to change(User, :count)
      end
    end
  end

  describe 'ログイン' do
    let(:user) { create(:user) }
    let(:user_params) { { email: user.email, password: user.password } }
    let(:invalid_user_params) { { email: user.email, password: '' } }

    context 'when input is valid' do
      it 'リクエストが成功すること' do
        post user_session_path, params: { user: user_params }
        expect(response).to have_http_status(:see_other)
      end

      it 'ログイン後に root_path にリダイレクトされること' do
        post user_session_path, params: { user: user_params }
        expect(response).to redirect_to(root_path)
      end

      it 'ログイン状態になること' do
        post user_session_path, params: { user: user_params }
        # controller は、現在テスト対象となっているコントローラーのインスタンスを指す
        # ここでの controller は Users::SessionsController のインスタンス
        expect(controller.current_user).to eq(user)
      end
    end

    context 'when input is invalid' do
      it 'リクエストが失敗すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'ログイン状態にならないこと' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(controller.current_user).to be nil
      end
    end
  end
end
