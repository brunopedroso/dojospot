# language: pt
Funcionalidade: Propor uma sessão de dojo

	Para poder convidar pessoas
	Como um participante
	Eu quero propor uma sessão de dojo
			
	Cenário: Só pode marcar sessão de dojo se estiver logado
	
		Dado que eu não estou logado no sistema
		E que eu estou na "lista de sessões"
		Então eu não devo ver o link "Porpor nova sessão"

	Cenário: Só pode marcar sessão de dojo se tiver privilégio

		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" não tem privilégio de propor sessão
		E que eu estou na "lista de sessões"
		Então eu não devo ver o link "Propor uma nova sessão"

	Cenário: Não deve permitir acesso ao formulário de nova sessão sem login
	
		Dado que eu não estou logado no sistema
		Quando eu vou para "página de nova sessão"
		Então eu devo estar na "página de login"

	Cenário: Não deve permitir acesso ao formulário de nova sessão sem login

		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" não tem privilégio de propor sessão
		Quando eu vou para "página de nova sessão"
		Então eu devo estar na "página de login"
			

	Cenário: Iniciando a marcação de uma nova sessão
		
		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E que eu estou na "lista de sessões"
		Quando eu clico em "Propor uma nova sessão"
		Então eu devo estar na "página de nova sessão"
		
	Cenário: Propondo uma sessão
	
		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E que não existem sessões marcadas
		E eu estou na página de nova sessão
		Quando eu preencho a proposta de sessão com "título", "texto", "local", "amanhã", e "12:00"
		E eu aperto "Salvar"
		Então eu devo estar na "lista de sessões"
		E eu devo ver a sessão proposta com "título", "texto", "local", "amanhã", e "12:00"
		E eu devo ver "bruno" na lista de nomes confirmados

	Cenário: Só pode editar se estiver logado

		Dado que eu não estou logado no sistema
		E que existe uma sessão marcada amanhã
		E que eu estou na "lista de sessões"
		Então eu não devo ver o link "editar"


	Cenário: Não pode editar se não estiver confirmado

		Dado que eu estou logado no sistema
		E que existe uma sessão marcada amanhã
		E que eu estou na "lista de sessões"
		Então eu não devo ver o link "editar"

	Cenário: Só pode editar se estiver confirmado

		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E que existe uma sessão marcada amanhã
		E que eu estou na "lista de sessões"
		Quando eu clico em "Confirmar minha presença"
		Então eu devo ver o link "editar"

	Cenário: Só pode editar se tiver privilégio

		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" não tem privilégio de propor sessão
		E que existe uma sessão marcada amanhã
		E que eu estou na "lista de sessões"
		# mesmo se estiver confirmado
		Quando eu clico em "Confirmar minha presença"
		Então eu não devo ver o link "editar"

	Cenário: Editando uma sessão

		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E que existe uma sessão marcada amanhã
		E que eu estou na "lista de sessões"
		Quando eu clico em "Confirmar minha presença"
		E eu clico em "editar"
		E eu preencho a proposta de sessão com "título", "texto", "local", "amanhã", e "12:00"
		E eu aperto "Salvar"
		Então eu devo estar na "lista de sessões"
		E eu devo ver a sessão proposta com "título", "texto", "local", "amanhã", e "12:00"

