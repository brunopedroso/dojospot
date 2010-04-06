# language: pt

Funcionalidade: Fazer login

	Para poder interagir com o sistema (propor sessões, confirmar presença, etc)
	Como um usuário registrado
	Eu quero apresentar minhas credenciais e ser reconhecido no sistema
	
	Cenário: Não logado
	
		Dado que eu não estou logado no sistema
		Então eu devo ver um link "login"