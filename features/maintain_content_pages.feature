Feature: Maintain content pages

	In order to create the site's context
	As admin
	I want to maintain the content pages
	
	Scenario: Stylized pages
	
		Given I am on About coding-dojo?
		Then I should see "O que é Coding Dojo?" within "h1"
