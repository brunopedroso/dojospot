# language: pt
Funcionalidade: Precisa de autorização para editar sessão

	Para manter o conteúdo do site relevante
	Como um participante
	Eu quero que só pessoas autorizadas possam editar o conteúdo das sessões
	
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

