Feature: List next sessions

	In order to participate in sessions
	As a potential participant
	I wnt to see the next proposed sesions in the home page

	Scenario: There is no proposed sessions
	
		Given there are no proposed sessions
		And I am on "next sessions page"
		Then I should see "No proposed sessions at this moment"

		
	Scenario: There will be a session tomorow

		Given the following sessions exist:
			|title		|date		|time	|place	|
			|session 1	|tomorow	|qq		|qq		|
		And I am on "next sessions page"
		Then I should see the following session details:
			|title		|date		|time	|place	|
			|session 1	|tomorow	|qq		|qq		|

	Scenario: There is a session today

		Given the following sessions exist:
			|title		|date		|time	|place	|
			|session 1	|today		|qq		|qq		|
		And I am on "next sessions page"
		Then I should see the following session details:
			|title		|date		|time	|place	|
			|session 1	|today	|qq		|qq		|

	Scenario: Three proposed sesisons

		Given the following sessions exist:
			|title		|date		|time	|place	|
			|session 1	|today		|qq		|qq		|
			|session 2	|tomorow	|qq		|qq		|
			|session 3	|tomorow	|qq		|qq		|
		And I am on "next sessions page"
		Then I should see the following session details:
			|title		|date		|time	|place	|
			|session 1	|today		|qq		|qq		|
			|session 2	|tomorow	|qq		|qq		|
			|session 3	|tomorow	|qq		|qq		|
