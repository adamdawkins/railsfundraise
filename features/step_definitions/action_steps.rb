When("I click on {string}") do |thing|
  click_on(thing)
end

When("I submit the form") do
  find('input[name="commit"]').click
end
