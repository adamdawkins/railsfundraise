Feature: Birthday campaigns

  As a generous person
  I want to receive donations to a charity
  So that my birthday does good in the world

  Scenario: Create birthday campaign
    Given I am at "/birthdays"
    When I click on "Pledge my birthday"
    And I fill in my account details with full name "Adam Dawkins"
    And I fill in birth day as "09"
    And I fill in birth month as "November"
    And I submit the form
    Then I should see "Adam Dawkins's Birthday"
    And I should be at "/adam-dawkins-s-birthday"
    And I should not see "raised"
    And I should not see "target"
