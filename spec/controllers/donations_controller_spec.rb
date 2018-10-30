require 'rails_helper'

RSpec.describe DonationsController, type: :controller do
  describe "POST /:campaign_id/donations" do
    let(:campaign) { FactoryBot.create(:campaign) }
    let(:donation_params) { { amount: 10.0, name: "Adam Dawkins", comment: "Good luck!" } }

    before do
      allow(Campaign).to receive_message_chain(:friendly, :find).and_return(campaign)
    end

    it ("creates a donation on the campaign") do
      expect do
        post :create, params: { campaign_id: campaign.id, donation: donation_params }
      end.to change(campaign.donations, 'size').from(0).to(1)
    end

    it("redirects to the campaign page") do
      post :create, params: { campaign_id: campaign.id, donation: donation_params }
      
      expect(response).to redirect_to(campaign_path(campaign))
    end

  end

end
