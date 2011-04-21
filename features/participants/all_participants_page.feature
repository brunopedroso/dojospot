Feature: All participants page

	In order to evaluate the dojos reputation
	As a visitant
	I want to know who uses to attend this dojo
	
	Scenario: Navigate from home
	
		Given I am on "the home page"
		When I follow "Who?"
		Then I should be on "all participants' page"

	Scenario: Presents gravatar picutres and names

		Given there is a user "foo" with password "secret"
		And the user "foo" has email "foo@email.com"
		And there is a user "foo2" with password "secret"
		And the user "foo2" has email "foo2@email.com"
		And I am on "all participants' page"
		Then I should see "foo"
		And I should see a gravatar picure for "foo@email.com"
		And I should see "foo2"
		And I should see a gravatar picure for "foo2@email.com"
