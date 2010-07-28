
Given /^the name field is empty$/ do
  response.should have_tag("input[type=?][name=?][value=?]", "text", "name", "")
end