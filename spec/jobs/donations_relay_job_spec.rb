require 'rails_helper'

RSpec.describe DonationsRelayJob, type: :job do
  describe "#perform" do
    let(:donation) { FactoryBot.create(:donation) }

    before do
      allow(DonationsChannel).to receive(:broadcast_to)
      allow(DonationsController).to receive(:render).and_return(:some_html)
    end

    it "broadcasts to DonationsChannel with the campaign html" do
      subject.perform(donation)
      expect(DonationsChannel).to have_received(:broadcast_to).with(donation.campaign, donation: :some_html)
    end
  end

end
