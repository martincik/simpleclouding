Feature: OpenID login
  In order to login
  As a user
  I want to use my OpenID
  
  Scenario: Login
    Given I am on the login page
    When I fill in "openid_identifier" with "ladislav.martincik@myopenid.com"
    And I press "Login"
    Then I should be on the OpenID authentication page
