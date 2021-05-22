:-module(salario, [ cadastraSalario/0, 
	mostraSalario/0,
	editaSalario/0, 
	excluiSalario/0]).

:- dynamic salary/1.
salary(0).


cadastraSalario :- 
	write("Digite o valor do seu salário em reais:"), nl,
	read(Salario),
	retractall(salary(_)),
	asserta(salary(Salario)),
	write("Salário cadastrado com sucesso!!"), nl.

mostraSalario :- 
	salary(X),
	(X == 0) -> write("Ainda não foi cadastrado um salário."),nl,write("O que deseja fazer?"), nl;
	write("Seu Salário é R$"),
	salary(X),
	write(X), nl.

editaSalario :- 
	salary(X),
	(X == 0) -> write("Ainda não foi cadastrado um salário."),nl,write("O que deseja fazer?"), nl;
	write("Digite o novo valor do seu salário em reais:"), nl,
	read(NovoSalario),
	retractall(salary(_)),
	asserta(salary(NovoSalario)),
	write("Novo Salário cadastrado com sucesso!!"), nl.

excluiSalario :- 
	salary(X),
	(X == 0) -> write("Ainda não foi cadastrado um salário."),nl,write("O que deseja fazer?"), nl;
	retractall(salary(_)),
	asserta(salary(0)),
	write("Salário excluído com sucesso!!").
