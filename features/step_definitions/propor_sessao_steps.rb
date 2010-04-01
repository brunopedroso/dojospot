Dado /^que não existem sessões marcadas$/ do
  DojoSession.find_proposed_sessions.should be_empty
end

proposta_exemplo = {:titulo => "Implementando um campo minado com BDD, usando JSpec e JQuery",
										:texto => "Venha codar com a gente!",
										:local => "na SEA tecnologia",
										:data => Date.today + 1, #tomorow
										:horario => "17:00 às 19:00"}

Quando /^eu preencho a proposta de sessão com título, texto, local, data, e horário$/ do
		fill_in "dojo_session[title]", :with => proposta_exemplo[:titulo]
		fill_in "dojo_session[text]", :with => proposta_exemplo[:texto]
		fill_in "dojo_session[place]", :with => proposta_exemplo[:local]
		fill_in "dojo_session[date]", :with => proposta_exemplo[:data].to_s
		fill_in "dojo_session[time]", :with => proposta_exemplo[:horario]
end

Então /^eu devo ver a sessão proposta com título, texto, local, data e horário informados$/ do
	  assert_contain proposta_exemplo[:titulo]
		assert_contain proposta_exemplo[:texto]
		assert_contain proposta_exemplo[:local]
		assert_contain proposta_exemplo[:data].to_s
		assert_contain proposta_exemplo[:horario]
end
