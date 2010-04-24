# language: pt

# TODO: refact: mudar pra pagina inicial de volta

Funcionalidade: Fazer login

	Para poder interagir com o sistema (propor sessões, confirmar presença, etc)
	Como um usuário registrado
	Eu quero apresentar minhas credenciais e ser reconhecido no sistema

	Cenário: Link de log-out não deve aparecer se eu não estiver logado

		Dado que eu não estou logado no sistema
		E que eu estou na "página inicial"
		Então eu não devo ver o link "Log out"

	Cenário: Link de log-in leva à página de login
	
		Dado que eu não estou logado no sistema
		E que eu estou na "página inicial"
		Quando eu clico em "Log in"
		Então eu devo estar na "página de login"

	Cenário: Login correto volta pra home, mostrando nome do usuário e link de log-out

		Dado que eu não estou logado no sistema
		E que eu estou na "página de login"
		E que existe um usuário "foo" com senha "secret"
		Quando eu preencho "login" com "foo"
		E eu preencho "password" com "secret"
		E eu aperto "Log in"
		Então eu devo estar na "página inicial"
		E eu devo ver "foo"
		E eu devo ver um link "Log out"
		E eu não devo ver o link "Log in"
		
	Cenário: Login incorreto
	Cenário: Criação de conta
		# Não vou especificar esses, herdo as specs do nifty_auth
		
