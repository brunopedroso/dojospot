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
	
	