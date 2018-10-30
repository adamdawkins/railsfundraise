FactoryBot.define do
  factory :campaign do
    user
    title { "MyString" }
    description { "MyString" }
    target_date { "2018-10-30" }
    target { 1.5 }
    slug { "string" }
  end
end
