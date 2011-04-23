Feature: Needs authorization to edit session

	In order to keep the content relevant
	As a participant
	I want to allow only authorized people to edit session's content
	
	Scenario: Cannot edit if not logged in

		Given I am not logged in
		And there is a session scheduled for tomorow
		And I am on "next sessions page"
		Then I should not see the "Edit" link


	Scenario: Cannot edit if not confirmed in the session
	
		Given I am logged in
		And there is a session scheduled for tomorow
		And I am on "next sessions page"
		Then I should not see the "Edit" link

	
	Scenario: User can edit if he is confirmed in the session
	
		Given I am logged in as "bruno"
		And that the user "bruno" has propose privileges
		And there is a session scheduled for tomorow
		And I am on "next sessions page"
		When I follow "Confirm my presence"
		Then I should see the "Edit" link
	

	Scenario: Cannot edit without propose privileges
		
		Given I am logged in as "bruno"
		And that the user "bruno" does not have propose privileges
		And there is a session scheduled for tomorow
		And I am on "next sessions page"
		When I follow "Confirm my presence"
		Then I should not see the "Edit" link
