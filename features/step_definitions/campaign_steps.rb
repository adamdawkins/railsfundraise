
Given("I have a campaign") do
  @me.campaigns.create(FactoryBot.attributes_for(:campaign))
end

Given("a campaign exists") do
  @campaign = FactoryBot.create(:campaign)
end

Given("I am on the campaign page") do
  visit campaign_path @campaign
end

When("I donate £{int} to the campaign") do |amount|
  post campaign_donations_path @campaign, params: { donation: { amount: amount, name: 'Joe Bloggs' } }
end

When("I start a Run for Freedom campaign") do
  visit "/signup?campaign=runforfreedom"
end

