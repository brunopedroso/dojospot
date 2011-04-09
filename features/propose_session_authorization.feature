Feature: Need authorization to propose sessions

	In order to keep the content relevant
	As a participant
	I want only authorized people to propose sessions

	Scenario: Cannot propose session if not logged in

		Given I am not logged in
		And I am on "next sessions page"
		Then I should not see the "Propose a new session" link

	
	Scenario: Cannot propose session without propose privileges
	
		Given I am logged in as "bruno"
		And that the user "bruno" does not have propose privileges
		And I am on "next sessions page"
		Then I should not see the "Propose a new session" link
		

	Scenario: Should not give direct access to the new session form without login
		
		Given I am not logged in
		When I go to "new session page"
		Then I should be on "login page"
		
	
	Scenario: Should not give direct access to the new session form without propose privileges

		Given I am logged in as "bruno"
		And that the user "bruno" does not have propose privileges
		When I go to "new session page"
		Then I should be on "login page"
