# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github]

  with_options presence: true do
    validates :email
    validates :phone_number
    validates :birth_date
  end

  validates :uid, uniqueness: { scope: :provider }

  # 渡された認証情報をもとに、ユーザーを検索または作成するメソッド
  # authの中身はGitHubから送られてくる大きなハッシュ。この中に名前やメアドなどの情報が入っている。
  # providerカラムとuidカラムが送られてきたデータと一致するユーザーを探す。
  # もしユーザーが見つからない場合は新規作成する。
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = "#{auth.uid}@gmail.com"
      # ランダムに20文字の文字列を作成する
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.phone_number = "000-#{auth.uid}"
      user.birth_date = '2025-01-01'
      # メール認証をスキップする
      user.skip_confirmation!
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
