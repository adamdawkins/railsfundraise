require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  describe "GET index" do
    let(:campaigns) { 2.times.collect { FactoryBot.build(:campaign) } }

    before do
      allow(Campaign).to receive(:all).and_return campaigns
    end

    it "renders the index template" do
      get :index
      assert_template 'campaigns/index'
    end

    it "assigns @campaigns to all campaigns" do
      get :index
      expect(assigns(:campaigns)).to eq campaigns
    end
  end

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


  describe "GET edit" do
    describe "logged in as owner of the campaign" do
      let(:user) { FactoryBot.create(:user) }
      let(:campaign) { FactoryBot.create(:campaign, user: user) }
      before do
        allow(Campaign).to receive_message_chain(:friendly, :find).and_return(campaign)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it "sets campaign to the campaign id provided" do
        get :edit, params: { id: 'slug' }

        expect(assigns(:campaign)).to be_a Campaign
      end

      it "renders the edit template" do
        get :edit, params: { id: 'slug' }

        assert_template 'campaigns/edit'
      end
    end

    describe "when not logged in" do
      let(:campaign) { FactoryBot.create(:campaign) }
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: :user)
        allow(controller).to receive(:current_user).and_return(nil)
        get :edit, params: { id: 'slug' }
      end

      it "should redirect me to the sign-in page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "logged in as someone not the owner of the campaign" do
      let(:user) { FactoryBot.create(:user) }
      let(:campaign) { FactoryBot.create(:campaign) }
      before do
        allow(Campaign).to receive_message_chain(:friendly, :find).and_return(campaign)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it "redirects to the campaign page" do
        get :edit, params: { id: 'slug' }

        expect(response).to redirect_to(campaign_path(campaign))
      end
    end
  end


  describe "PATCH update" do
    let(:campaign_params) { { title: "An Editted Title" } }
    let(:campaign) { FactoryBot.create(:campaign) }


    describe "when not logged in" do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: :user)
        allow(controller).to receive(:current_user).and_return(nil)
      end

      it "should redirect me to the sign-in page" do
        patch :update, params: { id: 'slug', campaign: campaign_params }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "as the owner of the campaign" do
      let(:user) { FactoryBot.create(:user) }
      let(:campaign) { FactoryBot.create(:campaign, user: user) }

      before do
        allow(Campaign).to receive_message_chain(:friendly, :find).and_return(campaign)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        allow(campaign).to receive(:update).and_return(true)

        patch :update, params: { id: 'slug', campaign: campaign_params }
      end

      it "sets campaign to the campaign id provided" do
        expect(assigns(:campaign)).to be_a Campaign
      end

      it "calls update on the campaign with the campaign params" do
        expect(campaign).to have_received(:update).with(hash_including campaign_params)
      end

      describe "after successful update" do
        before do
          allow(campaign).to receive(:update).and_return(true)
          patch :update, params: { id: 'slug', campaign: campaign_params }
        end

        it "sets the flash" do
          expect(flash[:notice]).to_not be_nil
        end

        it "redirects to the campaign" do
          expect(response).to redirect_to campaign_path(campaign)
        end
      end

      describe "after failed update" do
        before do
          allow(campaign).to receive(:update).and_return(false)

          patch :update, params: { id: 'slug', campaign: campaign_params }
        end

        it "sets the flash alert" do
          expect(flash[:alert]).to_not be_nil
        end

        it "renders the edit page" do
          assert_template "campaigns/edit"
        end
      end
    end

    describe "logged in as someone not the owner of the campaign" do
      let(:user) { FactoryBot.create(:user) }
      let(:campaign) { FactoryBot.create(:campaign) }

      before do
        allow(Campaign).to receive_message_chain(:friendly, :find).and_return(campaign)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        allow(campaign).to receive(:update).and_return(false)

        patch :update, params: { id: 'slug', campaign: campaign_params }
      end

      it("does not call @campaign.update") do
        expect(campaign).to_not have_received(:update)
      end

      it "redirects to the campaign" do
        expect(response).to redirect_to campaign_path(campaign)
      end
    end
  end
end
