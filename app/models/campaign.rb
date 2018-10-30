class Campaign < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :donations

  validates_presence_of :title

  def raised
    0
  end

  def progress
    0
  end
end
