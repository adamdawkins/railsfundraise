Feature: Teacher campaigns

  As a teacher at a very wealthy private school
  I want to receive donations to a charity
  So that I am not inundated with bribes

  Scenario: Create teacher_campaign
    Given I am at "/teachers"
    When I click on "Create your fundraiser page"
    And I fill in my account details with full name "Mr. Bowen" and submit the form
    Then I should see "Mr. Bowen's Christmas Giving"
    And I should be at "/mr-bowen-s-christmas-giving"
    And I should not see "raised"
    And I should not see "target"
