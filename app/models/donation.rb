class Donation < ApplicationRecord
  belongs_to :campaign

  validates_presence_of :amount
  validates_presence_of :campaign_id

  after_create { DonationsRelayJob.perform_now(self) }

  def initials
    if is_anonymous?
      "??"
    else
      [first_name, last_name].map(&:first).join.upcase
    end
  end
end
