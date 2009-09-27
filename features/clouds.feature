Feature: Support for configuration of cloud
  In order access clouds
  As a user
  I want to setup my credentials and default configuration
  
  Scenario: Getting to add cloud form
    Given I am logged in as ladislav.martincik@myopenid.com
    When I go to the cloud listing page
    And I follow "Add cloud"
    Then I should see "New cloud"
  
  Scenario: Adding new cloud with credentials for Amazon EC2
    Given I am on the new cloud page
    When I fill in "name" with "New Cloud"
    And I fill in "cloud_access_key" with "AKIAIDFDWUQAAFHYSS5Q"
    And I fill in "cloud_secret_access_key" with "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"
    And I press "Create cloud"
    Then I should see "New Cloud"
  
  Scenario: Adding new cloud with wrong credentials for Amazon EC2
    Given I am on the new cloud page
    When I fill in "name" with "New Cloud"
    And I fill in "cloud_access_key" with "xxx"
    And I fill in "cloud_secret_access_key" with "xxx"
    And I press "Create cloud"
    Then I should see "1 error prohibited"
    
  Scenario: Getting to configuration page of cloud
    Given I am logged in as ladislav.martincik@myopenid.com
    And I have created cloud "Amazon cloud" 
    When I go to cloud show page for cloud "Amazon cloud"
    Then I should be on cloud show page for cloud "Amazon cloud"
    And I should see "Amazon cloud"
    And I should see "Security Group"
    And I should see "Key Pairs"
    And I should see "Default zone" 
  

  
  
  

  
