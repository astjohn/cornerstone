Feature: Browse Discussions
  In order to find help
  As a Regular User,
  I want to see what people are talking about

  Scenario: Visit index page
    Given the following categories exist:
        |     name      | category_type | item_count |
        | General Help  |   Discussion  |     5      |
        | FAQs          |   Article     |     3      |
        | Refunds       |   Discussion  |     1      |
    And I am on "the discussions page"
    Then a category should exist with name: "General Help"
    And I should see "General Help" which links to "the discussion category page for 'General Help'"
    And I should see "Refunds" which links to "the discussion category page for 'Refunds'"
    And I should see "New Discussion" which links to "the new discussion page"

  Scenario: Select a category and then a discussion
    Given the following categories exist:
        |     name      | category_type | item_count | id |
        | General Help  |   Discussion  |     5      | 1  |
        | FAQs          |   Article     |     3      | 2  |
        | Refunds       |   Discussion  |     1      | 3  |
    And a discussion_w_user exists with subject: "I have a problem", privte: false, category_id: 1
    And a discussion_w_user exists with subject: "This is private", privte: true, category_id: 1
    And I am on "the discussions page"
    When I follow "General Help"
    Then I should be on "the discussion category page for 'General Help'"
    Then I should see "I have a problem" which links to "the discussion page for 'I have a problem'"
    And I should not see "This is private"
    And a discussion should exist with subject: "I have a problem"
    And I should see the "author_name" of the discussion
    And I should see the "status" of the discussion

