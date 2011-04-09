Feature: Next dojo sessions in the home page

	In order to cativate people
	As a visitor
	I want to see the next sessions' list in the home page

	Scenario: There is no proposed sessions
	
		Given there are no proposed sessions
		And I am on "the home page"
		Then I should see "No proposed sessions at the moment"
	
	Scenario: Three proposed sesisons

		Given the following sessions exist:
			|title		|date		|
			|session 1	|today		|
			|session 2	|tomorow	|
			|session 3	|tomorow	|
		And I am on "the home page"
		Then I should see the following session details:
			|title		|date		|
			|session 1	|today		|
			|session 2	|tomorow	|
			|session 3	|tomorow	|
		
	Scenario: Link to the sessions list
	
		Given the following sessions exist:
			|title		|date		|
			|session 1	|today		|
			|session 2	|tomorow	|
			|session 3	|tomorow	|
		And I am on "the home page"
		When I follow "more details >>" within "#next_sessions"
		Then I should be on "next sessions page"
