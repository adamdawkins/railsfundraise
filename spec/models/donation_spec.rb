require 'rails_helper'

RSpec.describe Donation, type: :model do
  it { is_expected.to belong_to(:campaign) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:campaign_id) }
end
