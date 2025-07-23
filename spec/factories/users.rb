# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'testuser' }
    email { 'test@example.com' }
    phone_number { '000-0000-0000' }
    birth_date { '2025-01-01' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current } # ← これで「メール確認済みユーザー」

    after(:build) do |user|
      user.icon_image.attach(io: File.open(Rails.root.join('app/assets/images/icon1.png')),
                             filename: 'icon1.png')
    end
  end
end
