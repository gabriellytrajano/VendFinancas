:-module(bonusSalarial, [listaBonusSalarial/0, cadastraBonusSalarial/0,
	excluiBonusSalarial/0, editaBonusSalarial/0]).

ListaDeBonusSalarial = [].

cadastraBonusSalarial:- 
	write("Digite o valor do seu bônus salarial em reais:"), nl,
	read(Bonus),
	append(ListaDeBonusSalarial, [Bonus], List),
	ListaDeBonusSalarial = List.
	write("Bônus Salarial cadastrado com sucesso!!"), nl.

listaBonusSalarial:- 
	Res = "",
	percorre(ListaDeBonusSalarial).

excluiBonusSalarial:- 
	write("OI").

editaBonusSalarial:- 
	write("OI").

remove(X, [X|C], C).
remove(X [Y|C], [Y|D]):-
	remove(X, C, D).