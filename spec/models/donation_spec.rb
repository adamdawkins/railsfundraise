require 'rails_helper'

RSpec.describe Donation, type: :model do
  it { is_expected.to belong_to(:campaign) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:campaign_id) }

  describe "initials" do
    it "returns the initials of the name" do
      subject.name = 'Jonathan Bowen'
      expect(subject.initials).to eq 'JB'
    end
  end
end
