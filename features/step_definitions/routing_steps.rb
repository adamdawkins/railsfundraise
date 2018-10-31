Given("I am at {string}") do |path|
  visit path
end

When("I go to {string}") do |path|
  visit path
end

Then("I should be at {string}") do |path|
  expect(current_path).to eq path
end
