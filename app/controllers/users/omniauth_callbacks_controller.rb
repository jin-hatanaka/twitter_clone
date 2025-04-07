# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # これは Token による CSRF 対策を放棄するということ
    # omniauth-rails_csrf_protection Gemで CSRF 対策をしているから問題ない
    skip_before_action :verify_authenticity_token, only: :github

    def github
      # ユーザー情報を取得
      # request.env["omniauth.auth"]にGitHubから送られてきたデータが入っている
      @user = User.from_omniauth(request.env['omniauth.auth'])

      # @userがデータベースに保存されているかどうか
      if @user.persisted?
        # 既存のユーザーがデータベースに保存されている場合、そのユーザーをサインイン状態にしておく
        sign_in_and_redirect @user, event: :authentication
        # サインインが成功した場合、成功メッセージを設定する
        set_flash_message(:notice, :success, kind: 'github') if is_navigational_format?
      else # 保存されていない場合
        # 一時的にセッションに認証情報を保存する
        session['devise.github_data'] = request.env['omniauth.auth'].except(:extra)
        # 登録ページにリダイレクト
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
