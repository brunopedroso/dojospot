
Given /^que eu estou logado no sistema$/ do
	Dado %{que eu estou logado no sistema como "foo"}
end

Given /^I am logged in$/ do
	Given %{I am logged in as "foo"}
end

Given /^I am not logged in$/ do
	visit("/logout")
end

Given /^I am logged in as "([^\"]*)"$/ do |username|
  user = Factory.create :user, :username=>username
	visit '/sessions/new'
	fill_in "login", :with => user.username
	fill_in "password", :with => user.password
	click_button('Log in')
end

Given /^there is a user "([^\"]*)" with password "([^\"]*)"$/ do |user, pass|
  Factory.create :user, :username=>user, :password=>pass
end


Given /^that the user "([^\"]*)" has propose privileges$/ do |username|
 	u =  User.find_by_username(username)
	u.has_propose_priv = true
	u.save
end

Given /^that the user "([^\"]*)" does not have propose privileges$/ do |username|
 	u =  User.find_by_username(username)
	u.has_propose_priv = false
	u.save
end