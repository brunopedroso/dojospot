Feature: Edit Profile

	In order to see my name in the interface
	As a user
	I want to edit my profile
	
	Scenario: Show username when I did not fill my name
		Given the following sessions exist:
			|title	|date	|
			|s1		|tomorow|
		And I am logged in as "bruno"
		And I am confirmed in the session "s1"
		And I am on the edit profile page
		And the name field is empty
		When I go to the next sessions page
		Then I should see "bruno" in the confirmed users list
	
	Scenario: Navigating from the home page
		And I am logged in as "bruno"
		And I am on the home page
		When I follow the pencil image link
		Then I should be on the edit profile page
		
	# Scenario: Editing the name
	# 	Given the following sessions exist:
	# 		|title	|date	|
	# 		|s1		|tomorow|
	# 	And I am logged in as "bruno"
	# 	And I am confirmed in the session "s1"
	# 	And I am in the home page
	# 	When I click in the pencil image link
	# 	Then I should

	