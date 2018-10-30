Feature: Create Donation
  As a friend of a fundraiser
  I want to Donate
  To help rescue women and children from slavery

  Background:
    Given a campaign exists

  Scenario: Add donation
    Given I am on the campaign page
    When I donate £10 to the campaign
    Then I should see "£10"
