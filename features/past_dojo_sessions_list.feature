Feature: List past dojo sessions

	In order to evaluate the kudos of the dojo
	As a visitant
	I want to see the list of past sessions
	
	Scenario: Navigating from the home page
	
		Given I am on 'the home page'
		When I follow "histórico de sessões"
		Then I should be in the past sessions listing

	Scenario: Show all past sessions

		Given I have 5 proposed sessions with titles 's1', 's2', 's3', 's4', 's5'
		And I am in the past sessions listing
		Then I should see the titles 's1', 's2', 's3', 's4', 's5'
		
	Scenario: Show sessions in decreasing date order

		Given I have 3 proposed sessions with titles and date 's1'/2 days ago, 's2'/yesterday, 's3'/3 days ago
		And I am in the past sessions listing
		Then I should see the sessions details in this specific order 's2', 's1', 's3'
	
	Scenario: Show title, date, local and body of each sessions
	
		Given I have a session with title 'past session', date yesterday, local 'anywhere', and body 'let's go guys!'
		And I am in the past sessions listing
		Then I should see title 'past session', date yesterday, local 'anywhere', and body 'let's go guys!'

