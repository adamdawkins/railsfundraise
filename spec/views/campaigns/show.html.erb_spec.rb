require 'rails_helper'

describe 'campaigns/show.html.erb' do
  describe "with a challenge campaign" do
    let(:campaign) { FactoryBot.build_stubbed(:campaign, campaign_type: 'CHALLENGE', target: 100) }

    before do
      allow(campaign).to receive(:raised).and_return(50)

      assign(:campaign, campaign)

      render
    end

    it "shows the total raised" do
      expect(rendered).to have_content "£50"
      expect(rendered).to have_content "raised"
    end
    it "shows the target" do
      expect(rendered).to have_content "£100"
    end

    it "shows the progress" do
      expect(rendered).to have_content "50%"
    end
  end

  describe "with an occasion campaign" do
    let(:campaign) { FactoryBot.build_stubbed(:campaign, campaign_type: 'OCCASION') }

    before do
      assign(:campaign, campaign)

      render
    end
    it "does not show a target, progress or amount raised" do
      expect(rendered).to_not have_content "raised"
    end
  end
  describe "with no donations" do
    it "shows a message encouraging donation" do
      assign(:campaign, FactoryBot.build_stubbed(:campaign))

      render

      expect(rendered).to have_content("Be the first to donate")
    end
  end
  describe "with donations" do
    it "displays the donations" do
      campaign = FactoryBot.create(:campaign)
      donations = FactoryBot.create_list(:donation, 3, campaign: campaign)

      assign(:campaign, campaign)

      render

      donations.each do |donation|
        expect(rendered).to have_content(donation.amount)
      end
    end
  end

  describe "managing your campaign" do
    describe "as the fundraiser" do
      let(:current_user) { FactoryBot.create(:user) }
      before do
        campaign = FactoryBot.create(:campaign, user: current_user)
        allow(view).to receive(:user_signed_in?).and_return(true)
        allow(view).to receive(:current_user).and_return(current_user)
        assign(:campaign, campaign)
      end

      it "shows an Edit Your Campaign link" do
        render

        expect(rendered).to have_content("Edit your campaign")
      end
    end

    describe "as a different fundraiser" do
      let(:current_user) { FactoryBot.create(:user) }
      before do
        allow(view).to receive(:user_signed_in?).and_return(true)
        allow(view).to receive(:current_user).and_return(current_user)
        campaign = FactoryBot.create(:campaign)
        assign(:campaign, campaign)
      end

      it "doesn't show an Edit Your Campaign link" do
        render

        expect(rendered).to_not have_content("Edit your campaign")
      end
    end

    describe "as a guest" do
      let(:current_user) { nil }
      before do
        campaign = FactoryBot.create(:campaign)
        assign(:campaign, campaign)
      end

      it "doesn't show an Edit Your Campaign link" do
        render

        expect(rendered).to_not have_content("Edit your campaign")
      end
    end
  end
end
