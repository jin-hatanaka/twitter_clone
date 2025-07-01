# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rails.logger.debug '==================== user create ===================='
user1 = User.new(
  email: 'user1@gmail.com',
  password: '000000',
  name: 'ユーザー1',
  phone_number: '111-1111-1111',
  birth_date: '2025-01-01',
  uid: SecureRandom.uuid,
  self_introduction: "中華料理が好きです。\n特にラーメンと餃子が好きです。",
  place: '大阪',
  website: 'https://github.com/jin-hatanaka'
)
user1.icon_image.attach(io: File.open(Rails.root.join('app/assets/images/icon1.png')),
                        filename: 'icon1.png')
user1.header_image.attach(io: File.open(Rails.root.join('app/assets/images/header1.png')),
                          filename: 'header1.png')
user1.skip_confirmation! # create,save,updateの前に呼び出す必要がある
user1.save!

user2 = User.new(
  email: 'user2@gmail.com',
  password: '000000',
  name: 'ユーザー2',
  phone_number: '222-2222-2222',
  birth_date: '2025-01-01',
  uid: SecureRandom.uuid
)
user2.icon_image.attach(io: File.open(Rails.root.join('app/assets/images/icon2.png')),
                        filename: 'icon2.png')
user2.skip_confirmation!
user2.save!

user3 = User.new(
  email: 'user3@gmail.com',
  password: '000000',
  name: 'ユーザー3',
  phone_number: '333-3333-3333',
  birth_date: '2025-01-01',
  uid: SecureRandom.uuid
)
user3.icon_image.attach(io: File.open(Rails.root.join('app/assets/images/icon2.png')),
                        filename: 'icon2.png')
user3.skip_confirmation!
user3.save!

Rails.logger.debug '==================== tweet create ===================='
tweet1 = user3.tweets.create!(
  content: 'ユーザー3の初めての投稿です。'
)

user2.tweets.create!(
  content: 'ユーザー2の初めての投稿です。'
)

user2.tweets.create!(
  content: '今日はサッカーをします。'
)

user1.tweets.create!(
  content: 'ユーザー1の初めての投稿です。'
)

user3.tweets.create!(
  content: '今日はいい天気です。'
)

user3.tweets.create!(
  content: '桜が綺麗でした。'
)

tweet7 = user1.tweets.create!(
  content: 'おいしい苺大福です。'
)
tweet7.images.attach(io: File.open(Rails.root.join('app/assets/images/strawberry_daifuku.png')),
                     filename: 'strawberry_daifuku.png')

tweet8 = user2.tweets.create!(
  content: 'サッカーシューズを買いました。'
)

tweet9 = user1.tweets.create!(
  content: 'いちごが食べたい。'
)

Rails.logger.debug '==================== follow relationship create ===================='
follow1 = user1.relationships.build(follower_id: user2.id)
follow1.save

follow2 = user1.relationships.build(follower_id: user3.id)
follow2.save

follow3 = user2.relationships.build(follower_id: user1.id)
follow3.save

follow4 = user3.relationships.build(follower_id: user1.id)
follow4.save

follow5 = user3.relationships.build(follower_id: user2.id)
follow5.save

Rails.logger.debug '==================== like relationship create ===================='
like1 = user1.likes.build(tweet_id: tweet1.id)
like1.save!

like2 = user1.likes.build(tweet_id: tweet8.id)
like2.save!

like3 = user2.likes.build(tweet_id: tweet9.id)
like3.save!

like4 = user3.likes.build(tweet_id: tweet8.id)
like4.save!

Rails.logger.debug '==================== retweet relationship create ===================='
retweet1 = user1.retweets.build(tweet_id: tweet8.id)
retweet1.save!

retweet2 = user2.retweets.build(tweet_id: tweet7.id)
retweet2.save!

retweet3 = user3.retweets.build(tweet_id: tweet8.id)
retweet3.save!

Rails.logger.debug '==================== comment relationship create ===================='
comment1 = tweet8.comments.build(
  content: 'かっこいいサッカーシューズですね。'
)
comment1.user = user1
comment1.save!

comment2 = tweet7.comments.build(
  content: 'おいしそうな苺大福ですね。'
)
comment2.user = user2
comment2.save!

comment3 = tweet9.comments.build(
  content: 'あまおうが食べたいですね。'
)
comment3.user = user3
comment3.save!

Rails.logger.debug '====================  notification create ===================='
notification1 = user1.active_notifications.new(
  visited_id: user2.id,
  tweet_id: tweet8.id,
  comment_id: nil,
  action: 'like'
)
notification1.save!

notification2 = user1.active_notifications.new(
  visited_id: user3.id,
  tweet_id: tweet1.id,
  comment_id: nil,
  action: 'like'
)
notification2.save!

notification3 = user3.active_notifications.new(
  visited_id: user1.id,
  tweet_id: nil,
  comment_id: nil,
  action: 'follow'
)
notification3.save!
