Feature: Report Schools flow
  Background:
    Given cohort was created with start_year "2021"
    And I am logged in as a "lead_provider"
    And scenario "lead_provider_with_delivery_partners" has been run

  Scenario: Visiting the start page
    Given I am on "dashboard" page
    When I click on "link" containing "Find and add schools"
    Then I should be on "lead providers report schools start" page
    And "page body" should contain "2021"
    And the page should be accessible
    And percy should be sent snapshot called "Lead provider report schools start page"

  Scenario: Selecting a delivery partner
    And I am on "lead providers report schools start" page
    When I click on "link" containing "Continue"
    Then I should be on "lead providers report schools choose delivery partner" page
    And "page body" should contain "Choose the delivery partner"
    And "page body" should contain "Delivery Partner 1"
    And the page should be accessible
    And percy should be sent snapshot called "Lead provider report schools choose delivery partner page"

