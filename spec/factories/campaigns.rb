FactoryBot.define do
  factory :campaign do
    before(:create){|campaign| campaign.define_singleton_method(:send_to_mailchimp){}}
    user
    title { Faker::Book.title }
    description { "MyString" }
    target_date { "2018-10-30" }
    target { 1.5 }
    slug { "string" }
    campaign_type { "CHALLENGE" }


    trait :teacher do
      title { "#{Faker::Name.name}'s Christmas Giving" }
      campaign_type { "OCCASION" }
      target { nil }
      target_date { Date.new(2018, 12, 25) }
      description {
        <<-TEACHER
      It is estimated that more than 40 million people worldwide are in slavery - 136,000 in the UK alone.  Victims like Maria, a school child from Romania.  Taken from a friend's house, sold for a few thousand pounds, brought to the UK and abused by countless men.

  It is a crime with huge profits and low detection rates; victims abused and forced to work in hand car washes, nail bars, agriculture and - like Maria - brothels.

  I don't need more chocolates, please give to these people instead.
        TEACHER
      }
    end

  end
end
