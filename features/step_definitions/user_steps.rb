
Given /^the name field is empty$/ do
	doc = Nokogiri::HTML(response.body)
	doc.search("input[type='text'][name='user[name]'][value='']", "text", "name")
  # response.should have_tag("input[type=?][name=?][value=?]", "text", "name", "")
end

When /^I follow the pencil image link$/ do
  click_link "edit_profile_link"
end