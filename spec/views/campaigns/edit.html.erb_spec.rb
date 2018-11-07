require 'rails_helper'

describe 'campaigns/edit.html.erb' do
  describe "with an occasion campaign" do
    let(:campaign) { FactoryBot.create(:campaign, :teacher) }
    before do
      assign(:campaign, campaign)
    end
    it "doesn't show a target field" do
      render

      expect(rendered).to_not have_selector("input[name='campaign[target]']")
    end
  end

  describe "with a challenge campaign" do
    let(:campaign) { FactoryBot.create(:campaign, :run_for_freedom) }
    before do
      assign(:campaign, campaign)
    end
    it "shows a target field" do
      render

      expect(rendered).to have_selector("input[name='campaign[target]']")
    end
  end
end
