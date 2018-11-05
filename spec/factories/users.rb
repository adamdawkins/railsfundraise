FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    password { "not blank" }
    email { Faker::Internet.email }
  end
end
