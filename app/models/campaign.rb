def next_birthday(date)
  if date > Time.now
    date
  else
    date.next_year
  end
end

class Campaign < ApplicationRecord
  include Rails.application.routes.url_helpers
  extend FriendlyId

  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :donations

  validates_presence_of :title

  after_create :send_to_mailchimp

  def self.new_landing_campaign(type, user, birthday = nil)
    if type == "birthday"
      Campaign.birthday_campaign(user, birthday)
    elsif type == "teachers"
      Campaign.teacher_campaign user
    else
      Campaign.run_for_freedom_campaign user
    end
  end

  def raised
    donations.sum(&:amount)
  end

  def progress
    (raised / target) * 100
  end


  private
    def send_to_mailchimp
      Mailchimp.update_member(self.user.email, ENV['MAILCHIMP_API_KEY'], ENV['MAILCHIMP_LIST_ID'],
        FNAME: self.user.first_name,
        LNAME: self.user.last_name,
        R4FREE19: "Yes",
        RFFURL: campaign_url(self)
      )
    end

    def self.teacher_campaign(user)
      Campaign.new(
        user: user,
        title: "#{user.full_name}'s Christmas Giving",
        campaign_type: 'OCCASION',
        target_date: Date.new(2018, 12, 25),
        description: Campaign.teacher_description
      )
    end

    def self.birthday_campaign(user, birthday)
      target_birthday = next_birthday(
        Date.new(Time.now.year, birthday[:month].to_i, birthday[:day].to_i)
      )

      Campaign.new(
        user: user,
        title: "#{user.first_name}'s Birthday For Freedom",
        campaign_type: "OCCASION",
        target_date: target_birthday.to_datetime,
        description: Campaign.birthday_description
      )
    end

    def self.run_for_freedom_campaign(user)
      Campaign.new(
        user: user,
        campaign_type: 'CHALLENGE',
        title: "#{user.first_name}'s Run For Freedom",
        target: 1000.0,
        target_date: Date.new(2019, 03, 22),
        description: Campaign.run_for_freedom_description
      )
    end


    def self.run_for_freedom_description
      <<-RUN_FOR_FREEDOM
          On the 22nd March 2019, I will be running through the night to bring freedom to those living in modern slavery.

          It is estimated that more than 40 million people worldwide are in slavery - 136,000 in the UK alone.  Victims like Maria, a school child from Romania.  Taken from a friend's house, sold for a few thousand pounds, brought to the UK and abused by countless men.

          It is a crime with huge profits and low detection rates; victims abused and forced to work in hand car washes, nail bars, agriculture and - like Maria - brothels.

          I refuse to stand by and do nothing.  Hence taking part in the all night run and immersive experience in Brighton.  Everything you give will help the work of Justice and Care, a charity supporting the victims of slavery and track down the criminal networks responsible.  Your contribution will help make a difference in their work in the UK and Europe and spur me on!
      RUN_FOR_FREEDOM
    end
    def self.teacher_description
      <<-TEACHER
      It is estimated that more than 40 million people worldwide are in slavery - 136,000 in the UK alone.  Victims like Maria, a school child from Romania.  Taken from a friend's house, sold for a few thousand pounds, brought to the UK and abused by countless men.

  It is a crime with huge profits and low detection rates; victims abused and forced to work in hand car washes, nail bars, agriculture and - like Maria - brothels.

  I don't need more chocolates, please give to these people instead.
      TEACHER
    end
    def self.birthday_description
      <<-BIRTHDAY
      When you’re a child abused in a brothel or working 18 hours days in a blisteringly hot factory, you don’t get to celebrate your birthday. That’s why this year as my big day approaches, rather than ask for gifts I’m asking for help to bring freedom to those affected.

Your gift will help Justice and Care track down victims and those responsible. Anything you can give will make a difference.
      BIRTHDAY
    end
end
