Feature: Edit Campaign
  As a fundraiser
  I want to customize my campaign
  So that I can make it more personal for my friends and family

  Background: 
    Given I have an account
    And I have a campaign

  Scenario: Fundraiser visits own Campaign
    Given I am logged in
    When I go to my campaign
    Then I should see "Edit your campaign"

  Scenario: Guest visits Campaign
    Given I am not logged in
    When I go to my campaign
    Then I should not see "Edit your campaign"

  Scenario: Another Fundraiser visits Campaign
    Given I am logged in
    And a campaign exists
    When I go to the campaign
    And I should not see "Edit your campaign"

  Scenario: Fundraiser edits campaign
    Given I am logged in
    When I go to edit my campaign
    And I fill in "Title" with "My Editted Campaign"
    And I submit the form
    Then I should be on my campaign page
    Then I should see "My Editted Campaign"

  Scenario: Guest tries to edit campaign
    Given they are not logged in
    When they go to edit my campaign
    Then they should be on the sign in page

  Scenario: User tries to edit a different fundraiser's campaign
    Given I am logged in
    And a campaign exists
    When I go to edit the campaign
    Then I should be on the campaign page
