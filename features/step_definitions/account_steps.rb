When("I fill in my account details with full name {string}") do |full_name|
  fill_in "user[full_name]", with: full_name
  fill_in "user[email]", with: "joe.bloggs@exapmel.com"
  fill_in "user[password]", with: "password"

  find('input[name="commit"]').click
end

