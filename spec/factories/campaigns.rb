FactoryBot.define do
  factory :campaign do
    user
    title { Faker::Book.title }
    description { "MyString" }
    target_date { "2018-10-30" }
    target { 1.5 }
    slug { "string" }
    campaign_type { "CHALLENGE" }
  end
end
