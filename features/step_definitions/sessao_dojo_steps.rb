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

Quando /^eu preencho a proposta de sessão com "([^\"]*)", "([^\"]*)", "([^\"]*)", "([^\"]*)", e "([^\"]*)"$/ do |title, text, place, date, time|
	fill_in "dojo_session[title]", :with => title
	fill_in "dojo_session[text]", :with => text
	fill_in "dojo_session[place]", :with => place
	
	if date == 'amanhã'
		date = Date.today + 1
	end
	
	fill_in "dojo_session[date]", :with => date.to_s_br
	fill_in "dojo_session[time]", :with => time
end

Então /^eu devo ver a sessão proposta com "([^\"]*)", "([^\"]*)", "([^\"]*)", "([^\"]*)", e "([^\"]*)"$/ do |title, text, place, date, time|
  assert_contain title
	assert_contain text
	assert_contain place
	
	if date == 'amanhã'
		date = Date.today + 1
	end
	
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

#TODO: refactoring: colocar os títulos das sessões na descrição do passo ao invés de guardar como field
Dado /^que existem três sessões marcada$/ do
  @dojo_session1 = Factory.create :dojo_session, :date => Date.today
	@dojo_session2 = Factory.create(:dojo_session, :date => (Date.today + 1))
	@dojo_session3 = Factory.create(:dojo_session, :date => (Date.today + 1))
end


Then /^I should see the following session details:$/ do |table|
	table.hashes.each do |hash|
		within("div") do |div|
	  	div.should have_tag("h2", hash[:title])
	
			date_time_place = I18n.l(calculate_relative_date(hash[:date]), :format=>"default") +
												", " + hash[:time] + 
												", " + hash[:place]
	
			div.should have_tag("span", date_time_place)
			
		end
	end
end

Então /^eu devo ver os detalhes da sessão$/ do
  assert_contain @dojo_session.title
	assert_contain @dojo_session.text
end

Então /^eu devo ver os detalhes das três sessões ordenadas$/ do

  doc = Nokogiri::HTML(response.body)
	
	doc.should contain(@dojo_session1.title)
	doc.should contain(@dojo_session3.title)
	doc.should contain(@dojo_session2.title)
	
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
