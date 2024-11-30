FactoryBot.define do
  factory :site do
    url { "MyString" }
    frequency { 1 }
    is_active { false }
    last_pinged_at { "2024-11-30 14:43:01" }
    user { nil }
  end
end
