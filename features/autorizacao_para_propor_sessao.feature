# language: pt
Funcionalidade: Precisa de autorização para propor uma sessão

	Para manter o conteúdo do site relevante
	Como um participante
	Eu quero que só pessoas autorizadas possam propor sessões
			
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
