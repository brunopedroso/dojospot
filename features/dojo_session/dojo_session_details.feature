Feature: Dojo session details page

	In order to see the details of a particular session
	As a participant
	I want to see the session details page
	
	Scenario: Navigating from the history page
		Given the following sessions exist:
			|title		|date		|time			|place		|text			|
			|a session  |1 days ago	|whatever time	|anywhere	|let's go guys!	|
		And I am on 'the history page'
		When I follow "a session"
		Then I should be on 'the session detail page'
		And I should see the following session details:
			|title		|date		|time			|place		|text			|
			|a session	|1 days ago	|whatever time	|anywhere	|let's go guys!	|

