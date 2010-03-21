Dado /^que não existem sessões marcadas$/ do
  Session.find_proposed_sessions.should be_empty
end

proposta_exemplo = {:titulo => "Implementando um campo minado com BDD, usando JSpec e JQuery",
										:texto => "Venha codar com a gente!",
										:local => "na SEA tecnologia",
										:data => "23/03/2010",
										:horario => "17:00 às 19:00"}

Quando /^eu preencho a proposta de sessão com título, texto, local, data, e horario$/ do
  fill_in "Título", :with => proposta_exemplo[:titulo]
	fill_in "Texto", :with => proposta_exemplo[:texto]
	fill_in "Local", :with => proposta_exemplo[:local]
	fill_in "Data", :with => proposta_exemplo[:data]
	fill_in "Horário", :with => proposta_exemplo[:horario]
end

Então /^eu devo ver a sessão proposta com título, texto, local, data e horario informados$/ do
  assert_containt proposta_exemplo[:titulo]
	assert_containt proposta_exemplo[:texto]
	assert_containt proposta_exemplo[:local]
	assert_containt proposta_exemplo[:data]
	assert_containt proposta_exemplo[:horario]
end