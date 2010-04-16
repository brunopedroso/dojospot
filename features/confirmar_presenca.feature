# language: pt

Funcionalidade: Confirmar presença em sessão de dojo

	Para encorajar outros participantes
	Como um participante
	Eu quero confirmar minha presença em uma sessão de dojo proposta
	
	Cenário: Confirmação exige que se faça login
	
		Dado que eu não estou logado no sistema
		E que existe uma sessão marcada amanhã
		E que eu estou na "página inicial"
		Quando eu clico em "Confirmar minha presença"
		Então eu devo estar na "página de login"
		# TODO: quando faz login, cai na index, já confirmado (se não quiser ele desconfirma)	
		
	Cenário: Confirmar presença
	
		Dado que eu estou logado no sistema como "bruno"
		E que existe uma sessão marcada amanhã
		E que eu estou na "página inicial"
		Quando eu clico em "Confirmar minha presença"
		Então eu devo estar na "página inicial"
		E eu não devo ver o link "confirmar presença"
		E eu devo ver "bruno" na lista de nomes confirmados
		
		
	Cenário: Desconfirmam presença