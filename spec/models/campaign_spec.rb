require 'rails_helper'
require_relative "../../lib/mailchimp"

RSpec.describe Campaign, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:donations) }
  it { is_expected.to validate_presence_of(:title) }

  describe "new_landing_campaign" do
    before do
      allow_any_instance_of(Campaign).to receive(:send_to_mailchimp).and_return true
    end

    let (:user) { FactoryBot.create(:user) }
    describe "type is 'run_for_freedom'" do
      it "returns a campaign with run for freedom information" do
        campaign = Campaign.new_landing_campaign('run_for_freedom', user)
        expect(campaign.title).to match /Run For Freedom/
        expect(campaign.campaign_type).to eq 'CHALLENGE'
        expect(campaign.target).to eq 1000
        expect(campaign.target_date).to eq Date.new(2019, 3, 22)
      end
    end

    describe "type is 'teachers'" do
      it "returns a campaign with teacher christmas information" do
        campaign = Campaign.new_landing_campaign('teachers', user)
        expect(campaign.title).to match /Christmas Giving/
        expect(campaign.campaign_type).to eq 'OCCASION'
        expect(campaign.target).to be_nil
        expect(campaign.target_date).to eq Date.new(2018, 12, 25)
      end
    end

    describe "type is 'birthday'" do
      it "returns a campaign with birthday information" do
        campaign = Campaign.new_landing_campaign('birthday', user, month: 11, day: 9)

        expect(campaign.title).to match /Birthday/
        expect(campaign.campaign_type).to eq 'OCCASION'
        expect(campaign.target).to be_nil
      end

      describe "target_date" do
        before do
          allow(Time).to receive(:now).and_return(Date.new(2018, 11, 1).to_datetime)
        end

        it "sets it to later this year if the birthday hasn't happened yet this year" do
          campaign = Campaign.new_landing_campaign('birthday', user, month: 11, day: 9)
          expect(campaign.target_date).to eq Date.new(2018, 11, 9)
        end

        it "sets it to next year if it's the birthday has already happened this year" do
          campaign = Campaign.new_landing_campaign('birthday', user, month: 10, day: 18)
          expect(campaign.target_date).to eq Date.new(2019, 10, 18)
        end
      end
    end

    describe "#raised" do
      describe "with no donations" do
        it "returns 0" do
          expect(subject.raised).to eq 0
        end
      end
      describe "with donations" do
        let(:campaign) { FactoryBot.create(:campaign) }
        it "returns the sum" do
          campaign.donations.create([
            FactoryBot.attributes_for(:donation, amount: 10),
            FactoryBot.attributes_for(:donation, amount: 5)
          ])
          expect(campaign.raised).to eq 15
        end
      end
    end
    describe "#progress" do
      let(:campaign) { FactoryBot.create(:campaign, target: 200) }
      describe "with no donations" do
        it "returns 0" do
          expect(campaign.progress).to eq 0
        end
      end
      describe "with donations" do
        it "returns the sum" do
          campaign.donations.create([
            FactoryBot.attributes_for(:donation, amount: 10),
            FactoryBot.attributes_for(:donation, amount: 5)
          ])
          expect(campaign.progress).to eq 7.5
        end
      end
    end
  end

  describe "after_create" do
    before do
      subject.slug = "my-campaign"
      subject.user = FactoryBot.create(:user)
      allow(Mailchimp).to receive(:update_member)
    end

    it "calls Mailchimp.update_member after commit" do
      ENV["MAILCHIMP_API_KEY"] = "apikey-us26"
      ENV["MAILCHIMP_LIST_ID"] = "a_list_id"

      subject.run_callbacks(:create)

      expect(Mailchimp).to have_received(:update_member).with(
        subject.user.email,
        "apikey-us26",
        "a_list_id",
        FNAME: subject.user.first_name,
        LNAME: subject.user.last_name,
        RFFURL: "http://localhost:3000/#{subject.slug}",
        R4FREE19: "Yes"
      )
    end
  end
end
