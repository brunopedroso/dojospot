# language: pt
Funcionalidade: Propor uma sessão de dojo

	Para poder convidar pessoas
	Como um participante
	Eu quero propor uma sessão de dojo
			
	Cenário: Só pode marcar sessão de dojo se estiver logado
	
		Dado que eu não estou logado no sistema
		E que eu estou na "página inicial"
		Então eu não devo ver o link "Porpor nova sessão"

	Cenário: Não deve permitir acesso ao formulário de nova sessão sem login
	
		Dado que eu não estou logado no sistema
		Quando eu vou para "página de nova sessão"
		Então eu devo estar na "página de login"

	Cenário: Iniciando a marcação de uma nova sessão
		
		Dado que eu estou logado no sistema
		E que eu estou na "página inicial"
		Quando eu clico em "Propor uma nova sessão"
		Então eu devo estar na "página de nova sessão"
		
	Cenário: Propondo uma sessão
	
		Dado que eu estou logado no sistema como "bruno"
		E que não existem sessões marcadas
		E eu estou na página de nova sessão
		Quando eu preencho a proposta de sessão com título, texto, local, data in dd/MM/yyyy, e horário
		E eu aperto "Salvar"
		Então eu devo estar na página inicial
		E eu devo ver a sessão proposta com título, texto, local, data localizada e horário informados
		E eu devo ver "bruno" na lista de nomes confirmados
		
	Cenário: Editando uma sessão
	
		Dado que eu estou logado no sistema
		E que existe uma sessão marcada amanhã
		E que eu estou na "página inicial"
		Quando eu clico em "editar"
		E eu preencho a proposta de sessão com "título", "texto", "local", "amanhã", e "12:00"
		E eu aperto "Salvar"
		Então eu devo estar na página inicial
		E eu devo ver a sessão proposta com "título", "texto", "local", "amanhã", e "12:00"
		
		
		
		