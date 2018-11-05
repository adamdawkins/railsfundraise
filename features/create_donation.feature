@javascript
Feature: Create Donation
  As a friend of a fundraiser
  I want to Donate
  To help rescue women and children from slavery

  Scenario: Add donation
    Given a campaign exists
    And I am on the campaign page
    When I donate £10 to the campaign with comment "go for it!"
    Then I should see "£10"
    And I should see "go for it!"

  Scenario: Add donation to teacher campaign
    Given a teacher campaign exists
    Given I am on the campaign page
    When I donate £10 to the campaign with comment "go for it!"
    Then I should see "£10"
    And I should see "go for it!"
