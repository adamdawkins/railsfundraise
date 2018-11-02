class Donation < ApplicationRecord
  belongs_to :campaign
  after_commit { DonationsRelayJob.perform_later(self) }

  validates_presence_of :amount
  validates_presence_of :campaign_id

  def initials
    [first_name, last_name].map(&:first).join.upcase
  end
end
