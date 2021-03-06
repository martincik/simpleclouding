Feature: Starting server for Amazon EC2
  In order to use server
  As a user
  I want to be able start server on Amazon EC2
  
  Scenario: Getting to add new server form
    Given I am logged in as ladislav.martincik@myopenid.com
    When I go to the server listing page
    And I follow "Add server"
    Then I should see "New server"  
    
  Scenario: Create new server
    Given I am logged in as ladislav.martincik@myopenid.com
    And I have created cloud "Amazon"
    And I have stubbed external calls for server lunch
    When I go to the new server page
    And I fill in "server_name" with "MySQL server"
    And I select "Amazon" from "server_cloud_id"
    And I press "Run server"
    Then I should see "MySQL server"
    And server "MySQL server" created on Amazon
    
  Scenario: Shuttingdown server
    Given I am logged in as ladislav.martincik@myopenid.com
    And I have running servers in cloud
    When I go to the server listing page
    And I follow "Shutdown" within "#servers .server"
    Then I should be on the server listing page
    And I should not see "MySQL server"
    
  Scenario: Restart server
    Given I am logged in as ladislav.martincik@myopenid.com
    And I have running servers in cloud
    When I go to the server listing page
    And I follow "Restart" within "#servers .server"
    Then I should be on the server listing page
    And I should see "MySQL server"
  