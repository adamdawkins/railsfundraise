Feature: View Campaign
  As a user
  I want to view a campaign
  So that I can consider donating

  Scenario: No Donations
    Given a campaign exists
    When I go to the campaign
    Then I should see "Be the first to donate!"
