Feature: Users
  In order to block access from anonymous users
  As a publisher
  I must be able to manage accounts that have access to the backend

  Scenario: User overview
    Given I am authenticated as "demo"
      And I am on "/admin/user"
    Then I should see "demo"
      And I should see "Username"
      And I should see "Relation"
      And I should see "Actions"

  Scenario: Add a user
    Given I am authenticated as "demo"
      And I am on "/admin/user"
      And I follow "New"
    Then I should see "New user"
    When I fill in "integrated_user_profile_form[username]" with "behat"
      And I fill in "integrated_user_profile_form[password]" with "welcomeBehat!"
      And I check "integrated_user_profile_form[enabled]"
      And I check "integrated_user_profile_form[groups][]"
      And I press "Create"
    Then I should see "The user behat is created"
      And I should see "Username"
      And I should see "Relation"
      And I should see "Actions"

  Scenario: Login with a newly added user
    Given I am on "/admin/content"
    Then I should see "Login"
      And I should see "Username"
      And I should see "Password"
      And I should see "Remember me"
    When I fill in "_username" with "behat"
      And I fill in "_password" with "invalidLogin!"
      And I press "Login"
    Then I should see "Bad credentials."
    When I fill in "_username" with "behat"
      And I fill in "_password" with "welcomeBehat!"
      And I press "Login"
    Then I should see "Integrated"
      And I should see "Home"
      And I should see "Content types"
      And I should see "Channels"
      And I should see "Create new"

  Scenario: Delete a user
    Given I am authenticated as "demo"
      And I am on "/admin/user"
    Then I should see "Username"
      And I should see "Relation"
      And I should see "Actions"
    When I click the last icon "glyphicon-remove-circle"
    Then I should see "Delete user"
      And I should see "You are about to delete the user \"behat\", click the delete button below to confirm the action."
      And I press "Delete"
    Then I should see "The user behat is removed"
      And I should see "Username"
      And I should see "Relation"
      And I should see "Actions"