require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "helper"))

Given /^there are no proposed sessions$/ do
  DojoSession.find_proposed_sessions.should be_empty
end


Given /^the following sessions exist:$/ do |table|
  table.hashes.each do |hash|	
		hash[:date] = calculate_relative_date(hash[:date]) if hash[:date]
		d = Factory.create :dojo_session, hash
		
		#FIXME I dont know why the factory is not assigning the date :-/
		d.date=hash[:date] if hash[:date]
		d.save
		
	end
end

Given /^there is a session scheduled for (.*)$/ do |date|
	Given %{there is a session with title "any one" scheduled for #{date}}
end

Given /^there is a session with title "(.*)" scheduled for (.*)$/ do |title, date|
	real_date = calculate_relative_date(date)
	Factory.create :dojo_session, :title=> title, :date=>real_date  
end

Given /^I am confirmed in the session "([^\"]*)"$/ do |title|
  visit path_to('lista de sessões')
	id = DojoSession.find_by_title(title).id
	click_link_within "#dojo_session_#{id}", "Confirm my presence"
end





When /^I fill the proposal with "([^\"]*)", "([^\"]*)", "([^\"]*)", "([^\"]*)", and "([^\"]*)"$/ do |title, text, place, date, time|
	fill_in "dojo_session[title]", :with => title
	fill_in "dojo_session[text]", :with => text
	fill_in "dojo_session[place]", :with => place
	
	date = calculate_relative_date(date)
	
	fill_in "dojo_session[date]", :with => date.to_s
	fill_in "dojo_session[time]", :with => time
end



Then /^I should see the following session details:$/ do |table|
	table.hashes.each do |hash|
		within("div") do |div|
	  	response.should contain(hash[:title])
			date_time_place = /.*#{I18n.l(calculate_relative_date(hash[:date]), :format=>"pretty")}.*#{hash[:time]}.*#{hash[:place]}.*/
			within("span") do |span|
				assert_contain date_time_place
			end
			# div.should have_tag("span", date_time_place)
		end
	end
end




Then /^I should see "([^\"]*)" in the confirmed users list$/ do |username|
	within("div#confirmations") do |div|
			assert_contain "Confirmed"
  		assert_contain username
	end
end

Then /^I should not see "([^\"]*)" in the confirmed users list$/ do |username|
	doc = Nokogiri::HTML(response.body)
	dojo = doc.search('div.box #confirmations')
	dojo.should_not contain(username)
	dojo.should contain('Confirm my presence')
end


#TODO: transform into array
Then /^I should see the titles (.*), (.*), (.*), (.*), (.*)$/ do |t1,t2,t3,t4,t5|
    assert_contain t1
		assert_contain t2
		assert_contain t3
		assert_contain t4
		assert_contain t5
end

Then /^I should see the sessions details in this specific order (.*), (.*), (.*)$/ do |a,b,c|
  doc = Nokogiri::HTML(response.body)
	dojo = doc.search('h2')
	dojo[0].content.should == a
	dojo[1].content.should == b
	dojo[2].content.should == c
end
