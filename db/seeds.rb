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
  uid: SecureRandom.uuid
)
user1.icon_image.attach(io: File.open(Rails.root.join('app/assets/images/icon1.png')),
                        filename: 'icon1.png')
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
user3.tweets.create!(
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

user2.tweets.create!(
  content: 'サッカーシューズを買いました。'
)

user1.tweets.create!(
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
