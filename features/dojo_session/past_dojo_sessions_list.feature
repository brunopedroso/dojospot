Feature: List past dojo sessions

	In order to evaluate the kudos of the dojo
	As a visitor
	I want to see the list of all past sessions
	
	Scenario: Navigating from the home page
		Given I am on 'the home page'
		When I follow "Past sessions"
		Then I should be on 'the past sessions listing'

	Scenario: Show all past sessions
		Given the following sessions exist:
			|title	|
			|s1		|
			|s2		|
			|s3		|
			|s4		|
			|s5		|
		And I am on 'the past sessions listing'
		Then I should see the titles s1, s2, s3, s4, s5
		
	Scenario: Show sessions in decreasing date order
		Given the following sessions exist:
			|title	|date		|
			|s1		|2 days ago	|
			|s2		|1 days ago	|
			|s3		|3 days ago	|
		And I am on 'the past sessions listing'
		Then I should see the sessions details in this specific order s2, s1, s3
	
	Scenario: Show title, date, local and body of each sessions
		Given the following sessions exist:
			|title		|date		|time			|place		|text			|
			|a session	|1 days ago	|whatever time	|anywhere	|let's go guys!	|
		And I am on 'the past sessions listing'
		Then I should see the following session details:
			|title		|date		|time			|place		|text			|
			|a session	|1 days ago	|whatever time	|anywhere	|let's go guys!	|

