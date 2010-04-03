Dado /^que não existem sessões marcadas$/ do
  DojoSession.find_proposed_sessions.should be_empty
end

Quando /^eu preencho a proposta de sessão com título, texto, local, data, e horário$/ do
		@proposta_exemplo = Factory.build :dojo_session
		fill_in "dojo_session[title]", :with => @proposta_exemplo.title
		fill_in "dojo_session[text]", :with => @proposta_exemplo.text
		fill_in "dojo_session[place]", :with => @proposta_exemplo.place
		fill_in "dojo_session[date]", :with => @proposta_exemplo.date
		fill_in "dojo_session[time]", :with => @proposta_exemplo.time
end

Então /^eu devo ver a sessão proposta com título, texto, local, data e horário informados$/ do
	  assert_contain @proposta_exemplo.title
		assert_contain @proposta_exemplo.text
		assert_contain @proposta_exemplo.place
		assert_contain @proposta_exemplo.date.to_s
		assert_contain @proposta_exemplo.time
end

Dado /^que existe uma sessão marcada (.*)$/ do |qndo|
  @dojo_session = Factory.create :dojo_session
end

Então /^eu devo ver os detalhes da sessão$/ do
  assert_contain @dojo_session.title
	assert_contain @dojo_session.text
end

Dado /^que existem três sessões marcada$/ do
  @dojo_session1 = Factory.create :dojo_session
	@dojo_session2 = Factory.create :dojo_session
	@dojo_session3 = Factory.create :dojo_session
end

Então /^eu devo ver os detalhes das três sessões$/ do
  assert_contain @dojo_session1.title
	assert_contain @dojo_session2.title
	assert_contain @dojo_session3.title
end