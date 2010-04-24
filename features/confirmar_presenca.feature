# language: pt

Funcionalidade: Confirmar presença em sessão de dojo

	Para encorajar outros participantes
	Como um participante
	Eu quero confirmar minha presença em uma sessão de dojo proposta
	
	Cenário: Confirmação exige que se faça login
	
		Dado que eu não estou logado no sistema
		E que existe uma sessão marcada amanhã
		E que existe um usuário "foo" com senha "secret"
		E que eu estou na "lista de sessões"
		Quando eu clico em "Confirmar minha presença"
		E eu preencho "login" com "foo"
		E eu preencho "senha" com "secret"
		E eu aperto "Log in"
		Então eu devo estar na "lista de sessões"
		E eu devo ver "foo" na lista de nomes confirmados
		
	Cenário: Confirmar presença
	
		Dado que eu estou logado no sistema como "bruno"
		E que existe uma sessão marcada amanhã
		E que eu estou na "lista de sessões"
		Quando eu clico em "Confirmar minha presença"
		Então eu devo estar na "lista de sessões"
		E eu não devo ver o link "confirmar presença"
		E eu devo ver "bruno" na lista de nomes confirmados
		
		
	Cenário: Desconfirmar presença
	
		Dado que eu estou logado no sistema como "bruno"
		E que existe uma sessão com título "minha sessão" marcada amanhã
		E que eu estou confirmado na sessão "minha sessão"
		E que eu estou na "lista de sessões"
		Quando eu clico em "desconfirmar"
		Então eu devo estar na "lista de sessões"
		E eu não devo ver "bruno" na lista de nomes confirmados
		