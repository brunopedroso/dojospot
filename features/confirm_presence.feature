Feature: Confirm presence in a dojo session

	In order to encourage other participants
	As a participant
	I want to confirm my presence in a proposed dojo session

	Scenario: Confirmation needs login
	
		Given I am not logged in
		And there is a session scheduled for tomorow
		And there is a user "foo" with password "secret"
		And I am on "next sessions page"
		When I follow "Confirm my presence"
		And I fill in "login" with "foo"
		And I fill in "password" with "secret"
		And I press "Log in"
		Then I should be on "next sessions page"
		And I should see "foo" in the confirmed users list


	Scenario: Confirm presence
	
		Given I am logged in as "bruno"
		And there is a session scheduled for tomorow
		And I am on "next sessions page"
		When I follow "Confirm my presence"
		Then I should be on "next sessions page"
		Then I should not see the "edit" link
		And I should see "bruno" in the confirmed users list


	Scenario: Unconfirm presence
	
		Given I am logged in as "bruno"
		And there is a session with title "my session" scheduled for tomorow
		And I am confirmed in the session "my session"
		And I am on "next sessions page"
		When I follow "unconfirm"
		Then I should be on "next sessions page"
		And I should not see "bruno" in the confirmed users list
