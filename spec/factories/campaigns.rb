FactoryBot.define do
  factory :campaign do
    type { "" }
    user
    title { "MyString" }
    description { "MyString" }
    target_date { "2018-10-30" }
    target { 1.5 }
  end
end
