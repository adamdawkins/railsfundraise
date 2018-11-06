When("I fill in birth day as {string}") do |day|
  select day, from: "user[birthday][day]"
end

When("I fill in birth month as {string}") do |month|
  select month, from: "user[birthday][month]"
end
