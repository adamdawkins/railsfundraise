FactoryBot.define do
  factory :user do
    full_name { "MyString" }
    password { "not blank" }
    email { "MyString" }
  end
end
