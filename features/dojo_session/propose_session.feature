Feature: Propose a dojo session

	In order to invite people
	As a participant
	I want to propose a dojo session

	Scenario: Beginning the proposal
	
		Given I am logged in as "bruno"
		And that the user "bruno" has propose privileges
		And I am on "next sessions page"
		When I follow "Propose a new session"
		Then I should be on "new session page"
	
	Scenario: Beginning the proposal from home page

		Given I am logged in as "bruno"
		And that the user "bruno" has propose privileges
		And there are no proposed sessions
		And I am on "the home page"
		When I follow "Propose a new session"
		Then I should be on "new session page"

	
	Scenario: Proposing a session
	
		Given I am logged in as "bruno"
		And that the user "bruno" has propose privileges
		And there are no proposed sessions
		And I am on "new session page"
		When I fill the proposal with "title", "text", "place", "tomorow", and "12:00"
		And I press "Save"
		Then I should be on "next sessions page"
		And I should see the following session details:
			|title		|date		|time			|place		|text			|
			|title		|tomorow	|12:00			|place		|text	|
		And I should see "bruno" in the confirmed users list
		
	

	Scenario: Session's text should be stylized

		Given I am logged in as "bruno"
		And that the user "bruno" has propose privileges
		And I am on "new session page"
		When I fill the proposal with "title", "h3. my happy title", "place", "tomorow", and "12:00"
		And I press "Save"
		Then I should be on "next sessions page"
		And I should see "my happy title" within "h3"
		

	Scenario: Editing a session
	
		Given I am logged in as "bruno"
		And that the user "bruno" has propose privileges
		And there is a session scheduled for tomorow
		And I am on "next sessions page"
		When I follow "Confirm my presence"
		And I follow "edit_dojo_session"
		And I fill the proposal with "title", "text", "place", "tomorow", and "12:00"
		And I press "Save"
		Then I should be on "next sessions page"
		And I should see the following session details:
			|title		|date		|time			|place		|text			|
			|title		|tomorow	|12:00			|place		|text	|
		
