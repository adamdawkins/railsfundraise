Then(/^(?:I|they) should see "([^"]*?)"$/) do |string|
  expect(page).to have_content(string)
end

Then(/^(?:I|they) should not see "([^"]*?)"$/) do |string|
  expect(page).to_not have_content(string)
end
