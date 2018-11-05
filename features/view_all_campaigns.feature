Feature: View all campaigns

  As a potential fundraiser
  I want to see all the campaigns
  So that I'm encouraged to start a campaign

  Scenario: View existing campaigns
    Given 2 campaigns exist
    When I go to '/campaigns'
    Then I should see the campaigns
