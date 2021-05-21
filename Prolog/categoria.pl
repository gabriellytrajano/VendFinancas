:-module(categoria, [listaCategorias/0, cadastraCategoria/0, 
	adicionaDespesaCategoria/0, excluiDespesaCategoria/0,
	excluiCategoria/0]).

ListaDeCategorias = [].


cadastraCategoria(Nome,Valor):-
	append(ListaDeCategorias, [categoria(Nome,Valor)],List),
	ListaDeCategorias = List.

listaCategorias:-
	Res = "",
	percorre(ListaDeCategorias).

adicionaDespesaCategoria(Categoria,Novo):-
	member(categoria(Categoria,_), ListaDeCategorias) -> categoria.

excluiDespesaCategoria:- 
	write("Oi").

excluiCategoria:- 
	write("Oi").


toString(categoria(X,Y),R) :-
	write("Oi").