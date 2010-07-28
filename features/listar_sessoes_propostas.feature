# language: pt
Funcionalidade: Listar próximas sessões na tela inicial

	Para poder participar de sessões
	Como um provável participante
	Eu quero ver as próximas sessões propostas na página inicial
	
	Cenário: Não existem sessões marcadas
		
		Dado que não existem sessões marcadas
		E que eu estou na "lista de sessões"
		Então eu devo ver "No proposed sessions at this moment" 
	
	Cenário: Uma sessão marcada amanhã
	
		Dado que existem as seguintes sessões marcadas:
			|title		|date		|time	|place	|
			|session 1	|tomorow	|qq		|qq		|
		E que eu estou na "lista de sessões"
		Então eu devo ver os detalhes das seguintes sessões, nesta ordem:
			|title		|date		|time	|place	|
			|session 1	|tomorow	|qq		|qq		|

	Cenário: Uma sessão marcada hoje

		Dado que existem as seguintes sessões marcadas:
			|title		|date		|time	|place	|
			|session 1	|today		|qq		|qq		|
		E que eu estou na "lista de sessões"
		Então eu devo ver os detalhes das seguintes sessões, nesta ordem:
			|title		|date		|time	|place	|
			|session 1	|today		|qq		|qq		|
	
	Cenário: Três sessões marcadas

		Dado que existem as seguintes sessões marcadas:
			|title		|date		|time	|place	|
			|session 1	|today		|qq		|qq		|
			|session 2	|tomorow	|qq		|qq		|
			|session 3	|tomorow	|qq		|qq		|
		E que eu estou na "lista de sessões"
		Então eu devo ver os detalhes das seguintes sessões, nesta ordem:
			|title		|date		|time	|place	|
			|session 1	|today		|qq		|qq		|
			|session 2	|tomorow	|qq		|qq		|
			|session 3	|tomorow	|qq		|qq		|
