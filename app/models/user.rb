# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github]

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :icon_image
  has_one_attached :header_image

  # フォローする側からのhas_many
  has_many :relationships, foreign_key: :following_id, dependent: :destroy, inverse_of: :following
  # 一覧画面で使用する（あるユーザーがフォローしている人全員をとってる->つまり、あるユーザーがフォローされている人をとってくる）
  has_many :followings, through: :relationships, source: :follower

  # フォローされる側からのhas_many
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy,
                                      inverse_of: :follower
  # 一覧画面で使用する（あるユーザーのフォロワー全員をとってくる->つまり、あるユーザーをフォローしている人をとってくる）
  has_many :followers, through: :reverse_of_relationships, source: :following

  # ユーザーがいいねしたツイートをとってくる
  has_many :like_tweets, through: :likes, source: :tweet

  # ユーザーがリツイートしたツイートをとってくる
  has_many :retweet_tweets, through: :retweets, source: :tweet

  # ユーザーがコメントしたツイートをとってくる
  has_many :comment_tweets, through: :comments, source: :tweet

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

  # フォローしているユーザーのid一覧
  def following_user_ids
    followings.map(&:id)
  end
end
