Feature: Visit The Home Page
  In order to interact with Cornerstone
  As a Regular User,
  I want to see what help is available

  Scenario: Home Page
    Given I am on the home page
    Then I should see "New Discussion" which links to "the new discussion page"
    And I should see "Browse Discussions" which links to "the discussions page"
    And I should see a link to the knowledge base
    And I should see a list of recent discussions
    And I should see a list of recent articles
    And I should see a list of support staff
    And I should see an opening paragraph

  Scenario: Start a new discussion
    Given I am on the home page
    When I follow "New Discussion"
    Then I should be on "the new discussion page"

  Scenario: Browse Discussions
    Given I am on the home page
    When I follow "Browse Discussions"
    Then I should be on "the discussions page"

  Scenario: Browse Knowledge Base
    Given I am on the home page
    When I click on the link to the knowledge base
    Then I should be on the knowledge base index page

