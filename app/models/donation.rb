class Donation < ApplicationRecord
  belongs_to :campaign

  validates_presence_of :amount
  validates_presence_of :campaign_id
end
