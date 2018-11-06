Feature: Run for Freedom Signup

  As a runner
  I want to create a run for freedom campaign
  So that I can raise money for my overnight run

  Scenario: Create account with valid parameters
    Given I am at "/run-for-freedom"
    When I click on "Create your fundraiser page"
    And I fill in my account details with full name "Jonathan Bowen" and submit the form
    Then I should see "Jonathan's Run For Freedom"
    And I should be at "/jonathan-s-run-for-freedom"
