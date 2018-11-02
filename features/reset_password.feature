Feature: Reset password
  As a forgetful person
  I want to be able to reset my password
  So that I can login to my account

  Background:
    Given an account with email "adam@dragondrop.uk" exists
    And I am not logged in

  Scenario: User goes to reset password page
    Given I am at "/login"
    When I click on "Forgot your password?"
    Then I should see a "Send me reset password instructions" button

  Scenario: User requests password reset
    Given I am on the forgotten password page
    When I request reset password instructions to "adam@dragondrop.uk"
    Then I should see "You will receive an email"
    And "adam@dragondrop.uk" should receive an email


  Scenario: User clicks reset password link
    Given I have requested a reset password email for "adam@dragondrop.uk"
    When "adam@dragondrop.uk" opens the email
    And they click the first link in the email
    Then they should see "Change your password"


  Scenario: Users logs in with new password
    Given I have reset the password for "adam@dragondrop.uk" to "my new password"
    And I am not logged in
    When I go to "/login"
    And I login with email "adam@dragondrop.uk" and password "my new password"
    Then I should be logged in
