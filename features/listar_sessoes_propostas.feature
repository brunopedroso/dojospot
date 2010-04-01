# language: pt
Funcionalidade: Listar próximas sessões na tela inicial

	Para poder participar de sessões
	Como um provável participante
	Eu quero ver as próximas sessões propostas na página inicial
	
	Cenário: Não existem sessões marcadas
		
		Dado que não existem sessões marcadas
		E que eu estou na "página inicial"
		Então eu devo ver "Nenhuma sessão proposta no momento." 
	
	Cenário: Uma sessão marcada
	
		Dado que existe uma sessão marcada
		E que eu estou na "página inicial"
		Então eu devo ver os detalhes da sessão
	
	Cenário: Três sessões marcadas

		Dado que existem três sessões marcada
		E que eu estou na "página inicial"
		Então eu devo ver os detalhes das três sessões
