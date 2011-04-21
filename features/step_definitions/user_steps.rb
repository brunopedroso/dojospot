require 'digest/md5'

Given /^the name field is empty$/ do
	doc = Nokogiri::HTML(response.body)
	doc.search("input[type='text'][name='user[name]'][value='']", "text", "name")
  # response.should have_tag("input[type=?][name=?][value=?]", "text", "name", "")
end

When /^I follow the pencil image link$/ do
  click_link "edit_profile_link"
end

Then /^I should see a gravatar picure for "([^"]*)"$/ do |email|
	hash = Digest::MD5.hexdigest(email.downcase)
  # assert_have_selector('img', :src=>/http\:\/\/www.gravatar.com\/avatar\/#{hash}\.png.*/)
	assert_match(/http\:\/\/www.gravatar.com\/avatar\/#{hash}\.png.*/, response.body)
end

Then /^I should not see a gravatar picure for "([^"]*)"$/ do |email|
	hash = Digest::MD5.hexdigest(email.downcase)
  # assert_have_no_selector('img', :src=>"http://www.gravatar.com/avatar/#{hash}.png")
	assert_no_match(/http\:\/\/www.gravatar.com\/avatar\/#{hash}\.png.*/, response.body)
end


