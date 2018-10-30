class Donation < ApplicationRecord
  belongs_to :campaign

  validates_presence_of :amount
  validates_presence_of :campaign_id

  def initials
    self.name.split.map(&:first).join.upcase
  end
end
