:-module(categoria, [cadastraCategoria/0,
					adicionaDespesaCategoria/0,
					listaCategorias/0, 
					deletaCategoria/0,
					somatorioCategorias/1]).

:- use_module(library(apply)).
:- use_module(library(csv)).

setup_bd :-
	consult('./data/bd_categoria.pl').

cadastra_categoria(N,V) :-
	setup_bd,
	(categoria(N,_)) -> nl,writeln("Essa categoria já foi cadastrada."),nl;
	write_cat(N,V),
	nl,writeln("Categoria cadastrada com sucesso :)"),nl.


write_cat(Nome, Valor) :-
	string_lower(Nome, N),
	atom_string(NomeAtom, N),
	assertz(categoria(NomeAtom, Valor)),
	write_cat_file.

write_cat_file :-
	setup_bd,
	tell('./data/bd_categoria.pl'), nl,
	listing(categoria/2),
	told.

edita_categoria(N,V) :-
	setup_bd,
	categoria(N,X),
	Y is X + V,
	retract(categoria(N,X)),
	assertz(categoria(N,Y)),
	tell('./data/bd_categoria.pl'), nl,
        listing(categoria/2),
        told,
	nl,writeln("Valor adicionado com sucesso!"),nl.	

cadastraCategoria :-
	nl,write("Digite o nome da categoria a ser cadastrada(se for mais de uma palavra digite entre aspas):"), nl,
	read(Nome),
	nl,write("Digite o valor da categoria a ser cadastrada:"), nl,
	read(Valor),
	cadastra_categoria(Nome, Valor).


adicionaDespesaCategoria :- 
	nl,write("Digite o nome da categoria à qual será adicionado o valor(se for mais de uma palavra digite entre aspas):"), nl,
	read(Nome),
	nl,write("Digite o valor a ser adicionado:"), nl,
	read(NovoValor),
	setup_bd,
	(categoria(Nome,_)) -> edita_categoria(Nome, NovoValor);
	nl,write("Essa categoria não existe. Tente novamente."), nl.

deletaCategoria :-
	nl,write("Digite o nome da categoria que deseja excluir(se for mais de uma palavra digite entre aspas):"), nl,
	read(Nome),
	setup_bd,
	(categoria(Nome,_)) -> deleta_cat(Nome), writeln("Categoria excluída com sucesso! :) ");
	write("Essa categoria não existe. Tente novamente."), nl.

deleta_cat(Nome):-
	setup_bd, 
	retract(categoria(Nome,_)),
	tell('./data/bd_categoria.pl'), nl,
		listing(categoria/2),
		told.

listaCategorias :- 
	nl,show_categorias,nl.

show_categorias :-
    get_categorias(Result),
     get_categoriasV(Result2),
    print_categorias(Result, Result2, 1).

print_categorias([], [], _).
print_categorias([Head|Tail], [Head1|Tail1], Index) :-
    string_concat(Index, "- Categoria: ", SpacesAndIndex),
 	string_concat(SpacesAndIndex, Head, SpacesAndHead),
 	string_concat(SpacesAndHead, " - Valor: R$", SpacesAndHeadSpace),
    string_concat(SpacesAndHeadSpace, Head1, SpacesAndHead1),
    writeln(SpacesAndHead1),
    Index1 is Index + 1,
    print_categorias(Tail, Tail1, Index1).

get_categorias(Result):-
    setup_bd,
    findall(Nome, categoria(Nome, _), Queries),
    list_to_set(Queries, Result).

get_categoriasV(Result):-
    setup_bd,
    findall(Valor, categoria(_, Valor), Queries),
    list_to_set(Queries, Result).

somatorioCategorias(Retorno) :-
	get_categoriasV(ListaValores),
	somatorio(ListaValores, ValorAcumulado),
	Retorno is ValorAcumulado.

somatorio([], 0).
somatorio([Head|Tail], Valor) :-
	somatorio(Tail, ValorAcumulado), Valor is ValorAcumulado + Head.