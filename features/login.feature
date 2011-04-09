Feature: Do login

	In order to interact with the system
	As a registered user
	I want to log in to the system

	Scenario: Log out link should not appear if not logged in

		Given I am not logged in
		And I am on "the home page"
		Then I should not see the "Log out" link

	Scenario: Log-in link brings to the login page

		Given I am not logged in
		And I am on "the home page"
		When I follow "Log in"
		Then I should be on "login page"


	Scenario: Correct log-in brings back to home page, showing username and log-out link
	
		Given I am not logged in
		And I am on "login page"
		And there is a user "foo" with password "secret"		
 		And I fill in "login" with "foo"
		And I fill in "password" with "secret"
		And I press "Log in"
		Then I should be on "the home page"
		And I should see "foo"
		Then I should see the "Log out" link
		Then I should not see the "Log in" link

		
	Scenario: Incorrect login
	Scenario: Sign up
		# Wont spec these. I'll Inherit from nifty-auth specs.
		
