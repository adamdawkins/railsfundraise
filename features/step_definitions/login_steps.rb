Given("I am not logged in") do
  @me = nil
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
  visit "/login"
  fill_in "Email", with: email
  fill_in "Password", with: password

  find('input[name="commit"]').click
end

