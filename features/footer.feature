Feature: Footer
  In order to quickly browse cornerstone,
  As a Regular User,
  I want to see recent items in a footer

  Scenario: Discussion Index Page
    Given I am on "the discussions page"
    Then the footer should have the latest X discussions from all categories
    And the footer should have the latest X articles from all categories

  Scenario: Discussion Categorical Index Page
    Given I am on a categorical index page
    Then the footer should have the latest X discussions for the category
    And the footer should have the latest X articles from all categories

  Scenario: Discussion Page
    Given I am on a discussion page
    Then the footer should have the latest X discussions for the category
    And the footer should have the latest X articles from all categories

  Scenario: Anywhere within the Knowledge Base
    Given I am on "the knowledge base page"
    Then the footer should have the latest X discussions from all categories
    And the footer should have the latest X articles from all categories
    Given I am on the categorical index page
    Then the footer should have the latest X discussions from all categories
    And the footer should have the latest X articles from all categories
    Given I am on the article page
    Then the footer should have the latest X discussions from all categories
    And the footer should have the latest X articles from all categories

