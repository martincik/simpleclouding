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
    
  Scenario: Getting to listing page of Security group
    Given I am logged in as ladislav.martincik@myopenid.com
    And I have created cloud "Amazon cloud" 
    When I go to cloud show page for cloud "Amazon cloud"
    And I follow "Security Group"
    Then I should be on the security group listing page for cloud "Amazon cloud"
    And I should see "default"
    And I should see "Add Security Group"
    
  Scenario: Adding new security group for Amazon cloud
    Given I am logged in as ladislav.martincik@myopenid.com
    And I have created cloud "Amazon cloud" 
    When I go to cloud show page for cloud "Amazon cloud"
    And I follow "Security Group"
    And I follow "Add Security Group"
    And I fill in "security_group_name" with "New security group name"
    And I fill in "security_group_description" with "New security group description"
    And I press "Create Security Group"
    Then I should be on the security group listing page for cloud "Amazon cloud"
    And I should see "New security group name"
    
  #Scenario: Adding new security group for Amazon cloud
  #  Given I am logged in as ladislav.martincik@myopenid.com
  #  And I have created cloud "Amazon cloud" 
  #  When I go to cloud show page for cloud "Amazon cloud"
  #  And I follow "Security Group"
  #  And I follow delete link for security group "New security group name"
  #  Then I should be on the security group listing page for cloud "Amazon cloud"
  #  And I should not see "New security group name"
    
  Scenario: Getting to listing page of Key Pairs
    Given I am logged in as ladislav.martincik@myopenid.com
    And I have created cloud "Amazon cloud" 
    When I go to cloud show page for cloud "Amazon cloud"
    And I follow "Key Pairs"
    Then I should be on the key pairs listing page for cloud "Amazon cloud"
    And I should see "default-EC2-US"
    And I should see "Create Key Pair"

  Scenario: Adding new key pairs for Amazon cloud
    Given I am logged in as ladislav.martincik@myopenid.com
    And I have created cloud "Amazon cloud" 
    When I go to cloud show page for cloud "Amazon cloud"
    And I follow "Key Pairs"
    And I follow "Create Key Pair"
    And I fill in "key_pair_key_name" with "New key name"
    And I press "Create key pair"
    Then I should be on the key pairs listing page for cloud "Amazon cloud"
    And I should see "New key name"
      
  

  
  

  
  
  

  
