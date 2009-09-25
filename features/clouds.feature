Feature: Support for Amazon EC2 cloud
  In order access Amazon EC2 cloud
  As a user
  I want to be asked to give my credentials
  
  Scenario: Getting to add cloud form
    Given I am logged in as ladislav.martincik@myopenid.com
    When I go to the cloud listing page
    And I follow "Add cloud"
    Then I should see "New cloud"
  
  Scenario: Adding new cloud with credentials
    Given I am on the new cloud page
    When I fill in "name" with "New Cloud"
    And I fill in "cloud_access_key" with "AKIAIDFDWUQAAFHYSS5Q"
    And I fill in "cloud_secret_access_key" with "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"
    And I press "Create cloud"
    Then I should see "1 error prohibited"
  
  Scenario: Adding new cloud with wrong credentials
    Given I am on the new cloud page
    When I fill in "name" with "New Cloud"
    And I fill in "cloud_access_key" with "xxx"
    And I fill in "cloud_secret_access_key" with "xxx"
    And I press "Create cloud"
    Then I should see "1 error prohibited"
  
  

  
