Feature: Edit Profile Gravatar

	In order to see my picture in the interface
	As a user
	I want to use my gravatar in the system
	
	
	Scenario: No email filled
		Given I am logged in as "bruno"
		And the user "bruno" has email ""
		And I am on the edit profile page
		Then I should see a gravatar picure for ""
		
	
	Scenario: Edit email updates gravatar
		Given I am logged in as "bruno"
		And I am on the edit profile page
		When I fill in "user[email]" with "aRandomEmail@gmail.com"
		And I press "save"
		Then I should be on the edit profile page
		Then I should see a gravatar picure for "aRandomEmail@gmail.com"


	Scenario: Invalid email gives an error message
		Given I am logged in as "bruno"
		And the user "bruno" has email ""
		And I am on the edit profile page
		When I fill in "user[email]" with "anInvalidEmail"
		And I press "save"
		Then I should be on the update profile page
		Then I should see "Email is invalid"
		And the "Email:" field should contain "anInvalidEmail"
