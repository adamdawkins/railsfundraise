Given("an account with email {string} exists") do |email|
  steps %{
  Given I have an account with email "#{email}" and password "whatever"
  }
end

Given("I have an account with email {string} and password {string}") do |email, password|
  @me = User.create(email: email, password: password, full_name: 'Joseph H. Bloggs')
end

When("I fill in my account details with full name {string}") do |full_name|
  fill_in "user[full_name]", with: full_name
  fill_in "user[email]", with: "joe.bloggs@exapmel.com"
  fill_in "user[password]", with: "password"
  fill_in "user[password_confirmation]", with: "password"

  find('input[name="commit"]').click
end

When("I request reset password instructions to {string}") do |email|
  fill_in "Email", with: email
  click_on "Send me reset password instructions"
end

Given("I have requested a reset password email for {string}") do |email|
  steps %{
    Given I am on the forgotten password page
    And I request reset password instructions to "#{email}"
  }
end

Given("I have reset the password for {string} to {string}") do |email, password|
  steps %{
    Given I have requested a reset password email for "#{email}"
    And "#{email}" opens the email
    And they click the first link in the email
  }

  fill_in "New password", with: password
  fill_in "Confirm new password", with: password
  click_on "Change my password"
end
