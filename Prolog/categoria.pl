:-module(categoria, [cadastraCategoria/0, adicionaDespesaCategoria/0, 
	excluiCategoria/0, listaCategorias/0]).

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
	atom_string(NomeAtom, N ),
	assertz(categoria(NomeAtom,Valor)),
	write_cat_file.

write_cat_file :-
	setup_bd,
	tell('./data/bd_categoria.pl'), nl,
	listing(categoria/2),
	told.

adicionaDespesa_categoria(N,V) :-
	setup_bd,
	(categoria(N,_)) -> ;
	write_cat(N,V),
	nl,writeln("Categoria edita com sucesso :)"),nl.	

cadastraCategoria:-
	nl,write("Digite o nome da categoria a ser cadastrada:"), nl,
	read(Nome),
	nl,write("Digite o valor da categoria a ser cadastrada:"), nl,
	read(Valor),
	cadastra_categoria(Nome, Valor).


adicionaDespesaCategoria:- 
	nl,write("Digite o nome da categoria a ser editada:"), nl,
	read(Nome),
	nl,write("Digite o valor da categoria a ser editado:"), nl,
	read(NovoValor),
	adicionaDespesa_categoria(Nome, NovoValor).

excluiCategoria:- 
	write("kasjdkajsd").

listaCategorias:- 
	nl,show_categorias,nl.

show_categorias :-
    get_categorias(Result),
    print_categorias(Result, 1).

print_categorias([], _).
print_categorias([Head|Tail], Index) :-
    string_concat(" ", Index, SpacesAndIndex),
    string_concat(SpacesAndIndex, " - ", SpacesIndexAndDash),
    string_concat(SpacesIndexAndDash, Head, CompleteString),
    writeln(CompleteString),
    Index1 is Index + 1,
    print_categorias(Tail, Index1).

get_categorias(Result):-
    setup_bd,
    findall(Nome, categoria(Nome, Valor), Queries),
    list_to_set(Queries, Result).