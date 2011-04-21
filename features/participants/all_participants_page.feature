Feature: All participants page

	In order to evaluate the dojos reputation
	As a visitant
	I want to know who uses to attend this dojo
	
	Scenario: Navigate from home
	
		Given I am on "the home page"
		When I follow "Who?"
		Then I should be on "all participants' page"
