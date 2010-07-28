require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "helper"))

Dado /^que não existem sessões marcadas$/ do
  DojoSession.find_proposed_sessions.should be_empty
end

Given /^the following sessions exist:$/ do |table|
  table.hashes.each do |hash|
		hash[:date] = calculate_relative_date(hash[:date]) if hash[:date]
		Factory.create :dojo_session, hash
	end
end

Dado /^que existem as seguintes sessões marcadas:$/ do |table|
	 Given %{the following sessions exist:}, table
end

Dado /^que existe uma sessão marcada (.*)$/ do |qndo|
	Dado %{que existe uma sessão com título "qualquer um" marcada #{qndo}}
end

Dado /^que existe uma sessão com título "(.*)" marcada (.*)$/ do |titulo, qndo|
	date = calculate_relative_date(qndo)
	Factory.create :dojo_session, :title=> titulo, :date=>date  
end

Dado /^que eu estou confirmado na sessão "([^\"]*)"$/ do |title|
	Given %{I am confirmed in the session "#{title}"}
end

Given /^I am confirmed in the session "([^\"]*)"$/ do |title|
  visit path_to('lista de sessões')
	id = DojoSession.find_by_title(title).id
	click_link_within "#dojo_session_#{id}", "Confirm my presence"
end






Quando /^eu preencho a proposta de sessão com "([^\"]*)", "([^\"]*)", "([^\"]*)", "([^\"]*)", e "([^\"]*)"$/ do |title, text, place, date, time|
	fill_in "dojo_session[title]", :with => title
	fill_in "dojo_session[text]", :with => text
	fill_in "dojo_session[place]", :with => place
	
	date = calculate_relative_date(date)
	
	fill_in "dojo_session[date]", :with => date.to_s_br
	fill_in "dojo_session[time]", :with => time
end




Então /^eu devo ver a sessão proposta com "([^\"]*)", "([^\"]*)", "([^\"]*)", "([^\"]*)", e "([^\"]*)"$/ do |title, text, place, date, time|
  assert_contain title
	assert_contain text
	assert_contain place
	
	date = calculate_relative_date(date)	
	assert_contain I18n.l(date, :format=>"pretty")
	assert_contain time
end

Then /^I should see the following session details:$/ do |table|
	table.hashes.each do |hash|
		within("div") do |div|
	  	response.should contain(hash[:title])
			date_time_place = /.*#{I18n.l(calculate_relative_date(hash[:date]), :format=>"pretty")}.*#{hash[:time]}.*#{hash[:place]}.*/
			response.should have_tag("span", date_time_place)
		end
	end
end


Então /^eu devo ver os detalhes das seguintes sessões, nesta ordem:$/ do |table|
	Then %{I should see the following session details:} ,table
end


Então /^eu devo ver "([^\"]*)" na lista de nomes confirmados$/ do |username|
	Then %{I should see "#{username}" in the confirmed users list}
end

Então /^I should see "([^\"]*)" in the confirmed users list$/ do |username|
	within("div#confirmations") do |div|
			assert_contain "Confirmed"
  		assert_contain username
	end
end

Então /^eu não devo ver "([^\"]*)" na lista de nomes confirmados$/ do |username|	
	doc = Nokogiri::HTML(response.body)
	dojo = doc.search('div.box #confirmations')
	dojo.should_not contain(username)
	dojo.should contain('Confirm my presence')
end

#TODO: transformar em array
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
