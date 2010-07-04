Dado /^que não existem sessões marcadas$/ do
  DojoSession.find_proposed_sessions.should be_empty
end


def calculate_relative_date(date_string) 
	if date_string
		date_string.strip!
		
		#Refact: use regexp and extract the number here...
		if date_string == "1 days ago"
			return Date.today - 1

		elsif date_string == "2 days ago"
				return Date.today - 2

		elsif date_string == "3 days ago"
				return Date.today - 3
				
		elsif date_string == "today" or date_string == "hoje"
				return Date.today

		elsif date_string == "tomorow" or date_string == "amanhã"
				return Date.today + 1

		else
				return date_string
		end
	end
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









Dado /^que existe uma sessão marcada (.*)$/ do |qndo|
	Dado %{que existe uma sessão com título "qualquer um" marcada #{qndo}}
end

Dado /^que existe uma sessão com título "(.*)" marcada (.*)$/ do |titulo, qndo|
	if (qndo ==  'amanhã') 
		date = (Date.today + 1)
		
	elsif (qndo == 'hoje')
		date = Date.today
		
	end
	
	@dojo_session = Factory.create :dojo_session, :title=> titulo, :date=>date
  
end

Dado /^que eu estou confirmado na sessão "([^\"]*)"$/ do |title|
  visit path_to('lista de sessões')
	id = DojoSession.find_by_title(title).id
	click_link_within "#dojo_session_#{id}", "Confirmar minha presença"
end


Then /^I should see the following session details:$/ do |table|
	table.hashes.each do |hash|
		within("div") do |div|
	  	div.should have_tag("h2", hash[:title])
	
			date_time_place = ".*#{I18n.l(calculate_relative_date(hash[:date]), :format=>"default")}, #{hash[:time]}, #{hash[:place]}.*"
			div.should have_tag("span", Regexp.new(date_time_place))
			
		end
	end
end


Então /^eu devo ver os detalhes das seguintes sessões, nesta ordem:$/ do |table|
	table.hashes.each do |hash|
	  doc = Nokogiri::HTML(response.body)
		doc.should contain(hash[:title])
	end
end


Então /^eu devo ver "([^\"]*)" na lista de nomes confirmados$/ do |username|
	within("div#confirmations") do |div|
			assert_contain "Confirmados"
  		assert_contain username
	end
end

Então /^eu não devo ver "([^\"]*)" na lista de nomes confirmados$/ do |username|	
	doc = Nokogiri::HTML(response.body)
	dojo = doc.search('div.box #confirmations')
	dojo.should_not contain(username)
	dojo.should contain('Confirmar minha presença')
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
