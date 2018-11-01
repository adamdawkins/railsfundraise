Feature: Create Donation
  As a friend of a fundraiser
  I want to Donate
  To help rescue women and children from slavery

  Background:
    Given a campaign exists

  @javascript
  Scenario: Add donation
    Given I am on the campaign page
    When I donate £10 to the campaign with comment "go for it!"
    Then I should see "£10"
    And I should see "go for it!"
