Given("I am not logged in") do
  Capybara.current_session.driver.browser.clear_cookies
end

Given("I am logged in") do
  @me = User.create(username: 'adam', email: 'adam@dragondrop.uk', password: 'password')

  steps %{
    When I login with email "adam@dragondrop.uk" and password "password"
  }
  puts @me
end

When("I login") do
  steps %{
    When I login with email "#{@me.email}" and password "#{@me.password}"
  }
end


When("I login with email {string} and password {string}") do |email, password|
  visit new_user_session_path
  fill_in "Email", with: email
  fill_in "Password", with: password

  find('input[name="commit"]').click
end

Then("I should be logged in") do
  steps %{ Then I should see "Logout" }
end
