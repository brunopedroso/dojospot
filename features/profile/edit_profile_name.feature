Feature: Edit Profile Name

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
		Given I am logged in as "bruno"
		And I am on the home page
		When I follow the pencil image link
		Then I should be on the edit profile page
		
	Scenario: Editing the name
		Given the following sessions exist:
			|title	|date	|
			|s1		|tomorow|
		And I am logged in as "bruno"
		And I am confirmed in the session "s1"
		And I am on the edit profile page
		When I fill in "user[name]" with "Bruno Pedroso"
		And I press "save"
		Then I should be on the edit profile page
		And the "Your real name:" field should contain "Bruno Pedroso"
	
	Scenario: Editing the name causes it to appear instead of username
		Given the following sessions exist:
			|title	|date	|
			|s1		|tomorow|
		And I am logged in as "bruno"
		And I am confirmed in the session "s1"
		And I am on the edit profile page
		When I fill in "user[name]" with "a diferent name"
		And I press "save"
		When I go to the next sessions page
		Then I should see "a diferent name" in the confirmed users list
		And I should see "Welcome, a diferent name" within "div#logon_menu"
		
	
	
	
	
	