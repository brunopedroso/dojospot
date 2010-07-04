# language: pt
Funcionalidade: Listar próximas sessões na tela inicial

	Para poder participar de sessões
	Como um provável participante
	Eu quero ver as próximas sessões propostas na página inicial
	
	Cenário: Não existem sessões marcadas
		
		Dado que não existem sessões marcadas
		E que eu estou na "lista de sessões"
		Então eu devo ver "Nenhuma sessão proposta no momento." 
	
	Cenário: Uma sessão marcada amanhã
	
		Dado que existem as seguintes sessões marcadas:
			|title		|date		|
			|session 1	|tomorow	|
		E que eu estou na "lista de sessões"
		Então eu devo ver os detalhes das seguintes sessões, nesta ordem:
			|title		|date		|
			|session 1	|tomorow	|

	Cenário: Uma sessão marcada hoje

	Dado que existem as seguintes sessões marcadas:
		|title		|date		|
		|session 1	|today		|
	E que eu estou na "lista de sessões"
	Então eu devo ver os detalhes das seguintes sessões, nesta ordem:
		|title		|date		|
		|session 1	|today		|
	
	Cenário: Três sessões marcadas

		Dado que existem as seguintes sessões marcadas:
			|title		|date		|
			|session 1	|today		|
			|session 2	|tomorow	|
			|session 3	|tomorow	|
		E que eu estou na "lista de sessões"
		Então eu devo ver os detalhes das seguintes sessões, nesta ordem:
			|title		|date		|
			|session 1	|today		|
			|session 2	|tomorow	|
			|session 3	|tomorow	|
