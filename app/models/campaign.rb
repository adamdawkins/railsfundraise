class Campaign < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :donations

  validates_presence_of :title

  def self.new_landing_campaign(type, user)
    puts "new_landing_campaign"
    puts type
    case type 
    when "teachers"
      puts "teachers"
      Campaign.new(
        user: user,
        title: "#{user.full_name}'s Christmas Giving",
        campaign_type: 'OCCASION',
        target_date: Date.new(2018, 12, 25),
        description: "

It is estimated that more than 40 million people worldwide are in slavery - 136,000 in the UK alone.  Victims like Maria, a school child from Romania.  Taken from a friend's house, sold for a few thousand pounds, brought to the UK and abused by countless men.

It is a crime with huge profits and low detection rates; victims abused and forced to work in hand car washes, nail bars, agriculture and - like Maria - brothels.

I don't need more chocolates, please give to these people instead."
      )
    else
      Campaign.new(
        user: user,
        campaign_type: 'CHALLENGE',
        title: "#{user.first_name}'s Run For Freedom",
        target: 1000.0,
        target_date: Date.new(2019, 03, 22),
        description: "On the 22nd March 2019, I will be running through the night to bring freedom to those living in modern slavery.

It is estimated that more than 40 million people worldwide are in slavery - 136,000 in the UK alone.  Victims like Maria, a school child from Romania.  Taken from a friend's house, sold for a few thousand pounds, brought to the UK and abused by countless men.

It is a crime with huge profits and low detection rates; victims abused and forced to work in hand car washes, nail bars, agriculture and - like Maria - brothels.

I refuse to stand by and do nothing.  Hence taking part in the all night run and immersive experience in Brighton.  Everything you give will help the work of Justice and Care, a charity supporting the victims of slavery and track down the criminal networks responsible.  Your contribution will help make a difference in their work in the UK and Europe and spur me on!"
      )
    end

  end

  def raised
    0
  end

  def progress
    0
  end
end