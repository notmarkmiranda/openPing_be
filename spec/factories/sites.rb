FactoryBot.define do
  factory :site do
    url { Faker::Internet.url }
    frequency { 30 }
    is_active { true }
    last_pinged_at { "2024-11-30 14:43:01" }
    user
  end
end
