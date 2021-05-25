:-module(salario, [ cadastraSalario/0, 
	mostraSalario/0,
	editaSalario/0, 
	excluiSalario/0,
	valorSalario/1]).

:- use_module(library(apply)).
:- use_module(library(csv)).

setup_bd :-
	consult('./data/bd_salario.pl').

write_salary(Valor):-
	open('./data/bd_salario.pl', write, S),
	write(S,':-dynamic salary/1.'),
	nl(S),
	write(S,Valor),
	put_char(S,.),
	close(S).

cadastraSalario :- 
	write("Digite o valor do seu salário em reais:"), nl,
	read(Salario),
	assertz(salary(Salario)),
	write_salary(salary(Salario)),
	write("Salário cadastrado com sucesso!!"), nl.

mostraSalario :- 
	setup_bd,
	salary(X),
	nl, (X = 0) -> write("Salário inexistente, cadastre um."), nl;
	salary(X),
	nl,write("Seu Salário é R$"),
	write(X), nl.

editaSalario :- 
	setup_bd,
	salary(X),
	nl,(X = 0) -> write("Salário inexistente, cadastre um."),nl;
	write("Digite o valor do seu novo salário em reais:"), nl,
	read(Salario),
	assertz(salary(Salario)),
	write_salary(salary(Salario)),
	write("Salário atualizado com sucesso!!"), nl.

excluiSalario :- 
	setup_bd,
	salary(X),
	(X == 0) -> write("Ainda não foi cadastrado um salário."),nl,write("O que deseja fazer?"),nl;
	write_salary(salary(0)),
	nl,write("Salário zerado com sucesso!!"),nl.

valorSalario(Valor) :-
	setup_bd,
	salary(X),
	Valor is X.