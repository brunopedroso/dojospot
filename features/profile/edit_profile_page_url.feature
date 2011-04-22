Feature: Edit Profile Page Url

	In order to reference my stuf
	As a user
	I want to have a link in my profile to my personal page
	
	Scenario: No URL filled
	
		Given there is a user "foo" with password "secret"
		And the user "foo" has page_url ""
		And I am on "all participants' page"
		Then I should not see the "foo" link
		And I should see "foo"
	
	Scenario: invalid URL filled
	
		Given I am logged in as "bruno"
		And I am on the edit profile page
		And I fill in "user[page_url]" with "invalid url"
		And I press "save"
		Then I should be on the update profile page
		And I should see "Personal page URL não é válido"
		And the "Personal page URL:" field should contain "invalid url"
		
	
	Scenario: valid URL filled

		Given I am logged in as "bruno"
		And I am on the edit profile page
		And I fill in "user[page_url]" with "http://mypage.com"
		And I press "save"
		Then I should be on the edit profile page
		And the "Personal page URL:" field should contain "http://mypage.com"
		
	
	Scenario: Page URL is linked in the username and gravatar

		Given there is a user "foo" with password "secret"
		And the user "foo" has email "foo@email.com"
		And the user "foo" has page_url "http://mypage.com"
		And I am on "all participants' page"
		Then I should see the "foo" link pointing to "http://mypage.com"
		Then I should see a gravatar picure for "foo@email.com" linked to "http://mypage.com"