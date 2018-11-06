Feature: Birthday campaigns

  As a generous person
  I want to receive donations to a charity
  So that my birthday does good in the world

  Scenario: Create birthday campaign
    Given I am at "/birthdays"
    When I click on "I pledge my birthday"
    And I fill in my account details with full name "Adam Dawkins"
    And I fill in birth day as "9"
    And I fill in birth month as "November"
    And I submit the form
    Then I should be at "/adam-s-birthday-for-freedom"
    And I should see "Adam's Birthday For Freedom"
    And I should not see "raised"
    And I should not see "target"
