require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  describe "GET show" do
    let(:campaign) { FactoryBot.create(:campaign) }

    before do
      allow(Campaign).to receive_message_chain(:friendly, :find).and_return(campaign)
    end

    it "renders the show template" do
      get :show, params: { id: 1 }
      
      assert_template 'campaigns/show'
    end

    it "assigns @campaign to the campaign id provided" do
      get :show, params: { id: 1 }
      expect(assigns(:campaign)).to be_a Campaign
    end
  end
end
