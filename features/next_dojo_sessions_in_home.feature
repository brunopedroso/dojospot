# language: pt
Funcionalidade: Lista de próximas sessões na página inicial

	Para poder cativar as pessoas
	Como um visitante qualquer
	Eu quero ver a listagem das próximas sessões propostas na página inicial
			
	Cenário: Não existem sessões marcadas
		
		Dado que não existem sessões marcadas
		E que eu estou na "página inicial"
		Então eu devo ver "Nenhuma sessão proposta no momento." 
	
	Cenário: Três sessões marcadas

		Dado que existem três sessões marcada
		E que eu estou na "página inicial"
		Então eu devo ver os detalhes das três sessões ordenadas
		
	Cenário: Link pra lista de sessões
	
	
		Dado que existem três sessões marcada
		E que eu estou na "página inicial"
		Quando eu clico em "mais detalhes >>" dentro de "#next_sessions"
		Então eu devo estar na "lista de sessões"
	