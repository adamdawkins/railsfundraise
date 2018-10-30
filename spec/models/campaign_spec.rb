require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:donations) }
  it { is_expected.to validate_presence_of(:title) }

  describe "new_landing_campaign" do
    let (:user) { FactoryBot.create(:user) }
     describe "type is 'run_for_freedom'" do 
       it "returns a campaign with run for freedom information" do
         campaign = Campaign.new_landing_campaign('run_for_freedom', user)
         expect(campaign.title).to  match /Run For Freedom/
         expect(campaign.campaign_type).to eq 'CHALLENGE'
         expect(campaign.target).to eq 1000
         expect(campaign.target_date).to eq Date.new(2019,3,22)
       end
     end

     describe "type is 'teachers'" do 
       it "returns a campaign with teacher christmas information" do
         campaign = Campaign.new_landing_campaign('teachers', user)
         expect(campaign.title).to  match /Christmas Giving/
         expect(campaign.campaign_type).to eq 'OCCASION'
         expect(campaign.target).to be_nil
         expect(campaign.target_date).to eq Date.new(2018,12,25)
       end
     end
  end

end
