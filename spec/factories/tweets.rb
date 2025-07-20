FactoryBot.define do
  factory :tweet do
    content { 'テスト投稿' }
    association :user
  end
end