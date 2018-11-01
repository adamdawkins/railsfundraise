FactoryBot.define do
  factory :user do
    full_name { "MyString" }
    password { "not blank" }
    sequence(:email) { |n| "email#{n}@example.com" }
  end
end
