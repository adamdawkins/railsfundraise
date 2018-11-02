FactoryBot.define do
  factory :donation do
    amount { 1.5 }
    first_name { "MyString" }
    last_name { "MyString" }
    comment { "MyString" }
    is_anonymous { false }
  end
end
