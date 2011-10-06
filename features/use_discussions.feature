Feature: Use Discussions
  In order to get some help
  As a Regular User,
  I want to create and use discussions

  Scenario: Create a new discussion when not logged in
    Given 2 categories exist
    And I am on "the discussions page"
    When I follow "New Discussion"
    Then I should be on "the new discussion page"
    When I select an option from "discussion_category_id"
    And I fill in the following:
      | Subject                                  | I need help!               |
      | Name                                     | Waffles                    |
      | Email                                    | w@ihop.com                 |
      | discussion[posts_attributes][0][body]    | Please help me out. k thx. |
    And I press "Create"
    Then I should be on "the discussion page for 'I need help!'"

  Scenario: Create a new discussion when logged in
    Given I am a regular, logged in user
    And 2 categories exist
    And I am on "the discussions page"
    When I follow "New Discussion"
    Then I should be on "the new discussion page"
    When I select an option from "discussion_category_id"
    And I fill in the following:
      | Subject                                  | I need help!               |
      | discussion[posts_attributes][0][body]    | Please help me out. k thx. |
    And I press "Create"
    Then a user should exist with name: "Tester"
    And a discussion should exist with subject: "I need help!"
    Then the discussion should be in the user's cornerstone_discussions

  Scenario: Click on new discussion from Category
    Given I am on "the new discussion page"
    Then the category should already be selected

