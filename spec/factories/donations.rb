FactoryBot.define do
  factory :donation do
    amount { 1.5 }
    name { "MyString" }
    comment { "MyString" }
    is_anonymous { false }
  end
end
