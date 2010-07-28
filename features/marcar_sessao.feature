# language: pt
Funcionalidade: Propor uma sessão de dojo

	Para poder convidar pessoas
	Como um participante
	Eu quero propor uma sessão de dojo
	
	Cenário: Iniciando a marcação de uma nova sessão
		
		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E que eu estou na "lista de sessões"
		Quando eu clico em "Propose a new session"
		Então eu devo estar na "página de nova sessão"
	
	Cenário: Iniciando a partir da home

		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E que não existem sessões marcadas
		E que eu estou na "página inicial"
		Quando eu clico em "Propose a new session"
		Então eu devo estar na "página de nova sessão"
	
	Cenário: Propondo uma sessão
	
		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E que não existem sessões marcadas
		E eu estou na página de nova sessão
		Quando eu preencho a proposta de sessão com "título", "texto", "local", "amanhã", e "12:00"
		E eu aperto "Save"
		Então eu devo estar na "lista de sessões"
		E eu devo ver a sessão proposta com "título", "texto", "local", "amanhã", e "12:00"
		E eu devo ver "bruno" na lista de nomes confirmados

	Cenário: Texto da sessão estilizado
	
		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E eu estou na página de nova sessão
		Quando eu preencho a proposta de sessão com "título", "h3. meu titulo feliz", "local", "amanhã", e "12:00"
		E eu aperto "Save"
		Então eu devo estar na "lista de sessões"
		Então eu devo ver "meu titulo feliz" dentro de "h3"
		
	Cenário: Editando uma sessão

		Dado que eu estou logado no sistema como "bruno"
		E que o usuário "bruno" tem privilégio de propor sessão
		E que existe uma sessão marcada amanhã
		E que eu estou na "lista de sessões"
		Quando eu clico em "Confirm my presence"
		E eu clico em "edit"
		E eu preencho a proposta de sessão com "título", "texto", "local", "amanhã", e "12:00"
		E eu aperto "Save"
		Então eu devo estar na "lista de sessões"
		E eu devo ver a sessão proposta com "título", "texto", "local", "amanhã", e "12:00"

