Given("I have a campaign") do
  @me.campaigns.create(FactoryBot.attributes_for(:campaign))
end

Given("a campaign exists") do
  @campaign = FactoryBot.create(:campaign)
end

Given("a teacher campaign exists") do
  @campaign = FactoryBot.create(:campaign, :teacher)
end

Given("{int} campaigns exist") do |number|
  @campaigns = number.times.collect { FactoryBot.create(:campaign) }
end

Given("I am on the campaign page") do
  visit campaign_path @campaign
end

When("I donate £{int} to the campaign with comment {string}") do |amount, comment|
  post campaign_donations_path @campaign, params: { donation: { amount: amount, first_name: 'Joe', last_name: 'Bloggs', comment: comment  } }
end

When("I go to the campaign") do
  visit campaign_path @campaign
end


When("I start a Run for Freedom campaign") do
  visit "/signup?campaign=runforfreedom"
end

Then("I should see the campaigns") do
  @campaigns.each do |campaign|
    expect(page).to have_content(campaign.title)
  end
end

# Routing
When("I go to my campaign") do
  visit campaign_path @me.campaign
end

When(/^(?:I|they) go to edit my campaign/) do
  visit edit_campaign_path @me.campaign
end

When(/^(?:I|they) go to edit the campaign/) do
  visit edit_campaign_path @campaign
end

Then(/^(?:I|they) should be on my campaign page/) do
  expect(page).to have_current_path(campaign_path(@me.campaign))
end

Then(/^(?:I|they) should be on the campaign page/) do
  expect(page).to have_current_path(campaign_path(@campaign))
end
