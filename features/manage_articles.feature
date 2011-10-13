Feature: Manage Articles
  In order to display my knowledge base
  As an administrator,
  I want to be able to manage articles

  Scenario: Articles are listed with action buttons
    Given I am a logged in administrator
    And an article exists with title: "How to do", body: "article body"
    When I go to "the articles page"
    Then an article should exist with title: "How to do"
    And I should see the "title" of the article
    And I should see "New Article" which links to "the new article page"
    And I should see "How to do" which links to "the article show page for 'How to do'"
    And I should see "Destroy"
    And I should see "Edit"

  Scenario: Create a new article successfully
    Given I am a logged in administrator
    And a category exists with name: "FAQ", category_type: "Article"
    And I am on "the new article page"
    When I fill in "Title" with "How to make widgets"
    And I fill in "Body" with "Here are the instructions on how to make widgets"
    And I select "FAQ" from "article_category_id"
    And I press "Create"
    Then an article should exist with title: "How to make widgets"
    And I should be on the article show page for 'How to make widgets'
    And I should see "How to make widgets"
    And I should see "Here are the instructions on how to make widgets"

  Scenario: Update an article successfully
    Given I am a logged in administrator
    And an article exists with title: "How to do", body: "article body"
    And I am on "the articles page"
    When I follow "Edit"
    Then I should be on the edit article page for 'How to do'
    When I fill in "Title" with "title changed"
    And I press "Update"
    Then an article should exist with title: "title changed"
    And I should be on the article show page for 'title changed'
    And I should see "title changed"
    And I should see "article body"
    And I should see "Article was successfully updated."

  Scenario: Delete article
    Given I am a logged in administrator
    And a category "faq" exists with name: "FAQ", category_type: "Article"
    And an article exists with title: "name 1", category: category "faq", body: "test"
    And an article exists with title: "name 2", category: category "faq", body: "test"
    And an article exists with title: "name 3", category: category "faq", body: "test"
    And an article exists with title: "name 4", category: category "faq", body: "test"
    When I delete the 3rd article
    Then I should be on "the articles page"
    And I should see the following articles:
      |     name      |
      | name 1        |
      | name 2        |
      | name 4        |
    And I should see "Article was successfully destroyed."

