Feature: Manage Categories
  In order to organize discussions and articles
  As an administrator,
  I want to be able to manage categories

  Scenario: Categories are listed with action buttons
    Given the following categories:
      |     name      | category_type |
      | General Help  |   Discussion  |
      | FAQs          |   Article     |
    When I go to "the categories page"
    Then I should see the following categories:
      |     name      | category_type |
      | General Help  |   Discussion  |
      | FAQs          |   Article     |
    And I should see "New Category" which links to "the new category page"
    And I should see "Destroy"
    And I should see "Edit"

  Scenario: Create a new category successfully
    Given I am on "the new category page"
    When I fill in "Name" with "name 1"
    And I select "Discussion" from "category_type"
    And I press "Create"
    Then I should be on "the categories page"
    And I should see "name 1"
    And I should see "Discussion"

  Scenario: Update a category successfully
    Given the following categories:
      |     name      | category_type |
      | name 1        | Discussion    |
    And I am on "the categories page"
    When I follow "Edit"
    Then I should be on "the edit category page for 'name 1'"
    When I fill in "Name" with "name changed"
    And I press "Update"
    Then I should be on "the categories page"
    And I should see "name changed"
    And I should see "Discussion"
    And I should see "Category was successfully updated."

  Scenario: Delete category
    Given the following categories:
      |     name      | category_type |
      | name 1        | Discussion    |
      | name 2        | Article       |
      | name 3        | Discussion    |
      | name 4        | Discussion    |
    When I delete the 3rd category
    Then I should be on "the categories page"
    And I should see the following categories:
      |     name      | category_type |
      | name 1        | Discussion    |
      | name 2        | Article       |
      | name 4        | Discussion    |
    And I should see "Category was successfully destroyed."

