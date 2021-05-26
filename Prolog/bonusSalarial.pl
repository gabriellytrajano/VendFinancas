:-module(bonusSalarial, [listaBonusSalarial/0, cadastraBonusSalarial/0,
	excluiBonusSalarial/0, editaBonusSalarial/0, valorBonus/1]).

:- use_module(library(apply)).
:- use_module(library(csv)).

setup_bd :-
	consult('./data/bd_bonusSalarial.pl').

write_bonus(Valor):-
	open('./data/bd_bonusSalarial.pl', write, S),
	write(S,':-dynamic bonus/1.'),
	nl(S),
	write(S,Valor),
	put_char(S,.),
	close(S).

cadastraBonusSalarial:- 
	write("Digite o valor do seu bônus salarial em reais:"), nl,
	read(Bonus),
	assertz(bonus(Bonus)),
	write_bonus(bonus(Bonus)),
	write("Bônus cadastrado com sucesso!!"), nl.

listaBonusSalarial:- 
	setup_bd,
	bonus(X),
	nl,(X = 0) -> write("Bônus inexistente, cadastre um."),nl;
	bonus(X),
	nl,write("Seu Bônus salarial é: R$"),
	write(X), nl.

excluiBonusSalarial:- 
	setup_bd,
	bonus(X),
	(X = 0) -> write("Ainda não foi cadastrado um bônus salarial."),nl,write("O que deseja fazer?"),nl;
	write_bonus(bonus(0)),
	nl,write("Bônus Salarial zerado com sucesso!!"),nl.

editaBonusSalarial:- 
	setup_bd,
	bonus(X),
	nl,(X = 0) -> write("Bônus Salarial inexistente, cadastre um."),nl;
	write("Digite o valor do seu novo Bônus Salarial em reais:"), nl,
	read(Bonus),
	assertz(bonus(Bonus)),
	write_bonus(bonus(Bonus)),
	write("Bônus Salarial atualizado com sucesso!!"), nl.

valorBonus(Valor) :-
	setup_bd,
	bonus(X),
	Valor is X.
