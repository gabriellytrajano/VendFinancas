:-module(bonusSalarial, [listaBonusSalarial/0, cadastraBonusSalarial/0,
	excluiBonusSalarial/0, editaBonusSalarial/0]).

:- dynamic bonus/1.
bonus(0).


cadastraBonusSalarial:- 
	write("Digite o valor do seu bônus salarial em reais:"), nl,
	read(Bonus),
	bonus(X),
	BonusNovo is X + Bonus,
	asserta(bonus(BonusNovo)),
	write("Bônus Salarial cadastrado com sucesso!!"), nl.

listaBonusSalarial:- 
	bonus(X),
	(X == 0) -> write("Ainda não foi cadastrado nenhum bônus salarial."), nl, write("O que deseja fazer?"), nl;
	write("Seu bônus salarial total é R$"),
	bonus(X),
	write(X), nl.

excluiBonusSalarial:- 
	bonus(X),
	(X == 0) -> write("Ainda não foi cadastrado nenhum bônus salarial."), nl, write("O que deseja fazer?"), nl;
	retractall(bonus(_)),
	asserta(bonus(0)),
	write("Bônus salarial zerado com sucesso!!"), nl.

editaBonusSalarial:- 
	write("OI").