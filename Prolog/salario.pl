:-module(salario, [ cadastraSalario/0, 
	mostraSalario/0,
	editaSalario/0, 
	excluiSalario/0]).

:- use_module(library(apply)).
:- use_module(library(csv)).


setup_bd :-
	consult('./data/bd_salario.pl').

write_salary(Valor):-
	setup_bd,
	retractall(salary(_)),
	assertz(salary(Valor)),
	write_salary_file.

write_salary_file :-
	setup_bd,
		tell('./data/bd_salario.pl'),nl,
		listing(salary/1),
		told.

cadastraSalario :- 
	write("Digite o valor do seu salário em reais:"), nl,
	read(Salario),
	write_salary(Salario),
	write("Salário cadastrado com sucesso!!"), nl.

mostraSalario :- 
	setup_bd,
	salary(X),
	(X == 0) -> write("Ainda não foi cadastrado um salário."),nl,write("O que deseja fazer?"), nl;
	write("Seu Salário é R$"),
	salary(X),
	write(X), nl.

editaSalario :- 
	setup_bd,
	salary(X),
	(X == 0) -> write("Ainda não foi cadastrado um salário."),nl,write("O que deseja fazer?"), nl;
	write("Digite o novo valor do seu salário em reais:"), nl,
	read(NV),
	write_salary(NV),
	write("Novo Salário cadastrado com sucesso!!"), nl.

excluiSalario :- 
	setup_bd,
	salary(X),
	(X == 0) -> write("Ainda não foi cadastrado um salário."),nl,write("O que deseja fazer?"),nl;
	write_salary(0),
	write("Salário excluído com sucesso!!").

getValor(Valor) :-
	setup_bd,
	salary(X),
	Valor is X.
