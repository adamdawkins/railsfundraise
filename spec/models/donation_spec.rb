require 'rails_helper'

RSpec.describe Donation, type: :model do
  it { is_expected.to belong_to(:campaign) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:campaign_id) }

  describe "initials" do
    it "returns the initials of the name" do
      subject.first_name = 'Jonathan'
      subject.last_name = 'Bowen'
      expect(subject.initials).to eq 'JB'
    end
  end

  describe "after_commit" do
    before do
      allow(DonationsRelayJob).to receive(:perform_later)
    end
    it "calls DonationsRelayJob.perform after commit" do
      subject.run_callbacks(:commit)

      expect(DonationsRelayJob).to have_received(:perform_later).with(subject)
    end
  end
end
