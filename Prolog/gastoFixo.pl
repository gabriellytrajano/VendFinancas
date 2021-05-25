:-module(gastoFixo, [cadastraGastoFixo/0, 
	editaGastoFixo/0,
	excluiGastoFixo/0,
	listaGastoFixo/0]).

:- use_module(library(apply)).
:- use_module(library(csv)).

setup_bd :-
	consult('./data/bd_gastofixo.pl').

cadastra_gastofixo(N,V) :-
	setup_bd,
	(gastofixo(N,_)) -> nl,writeln("Esse gasto fixo já foi cadastrado."),nl;
	write_gastofixo(N,V),
	nl,writeln("Gasto Fixo cadastrado com sucesso :)"),nl.


write_gastofixo(Nome, Valor) :-
	string_lower(Nome, N),
	atom_string(NomeAtom, N ),
	assertz(gastofixo(NomeAtom,Valor)),
	write_gastofixo_file.

write_gastofixo_file :-
	setup_bd,
	tell('./data/bd_gastofixo.pl'), nl,
	listing(gastofixo/2),
	told.

edita_gastofixo(N,V) :-
	setup_bd,
	gastofixo(N,X),
	retract(gastofixo(N,X)),
	assertz(gastofixo(N,V)),
	tell('./data/bd_gastofixo.pl'), nl,
        listing(gastofixo/2),
        told,
	nl,writeln("Gasto Fixo editado com sucesso!"),nl.	

cadastraGastoFixo:- 
	nl,write("Digite o nome do Gasto Fixo a ser cadastrado:"), nl,
	read(Nome),
	nl,write("Digite o valor do Gasto Fixo a ser cadastrado:"), nl,
	read(Valor),
	cadastra_gastofixo(Nome, Valor).

editaGastoFixo:- 
	nl,write("Digite o nome do Gasto Fixo a ser editado:"), nl,
	read(Nome),
	nl,write("Digite o valor a ser alterado:"), nl,
	read(NovoValor),
	setup_bd,
	(gastofixo(Nome,_)) -> edita_gastofixo(Nome, NovoValor);
	nl,write("Essa Gasto Fixo não existe. Tente novamente."), nl.

excluiGastoFixo:- 
	nl,write("Digite o nome do Gasto Fixo que deseja excluir:"), nl,
	read(Nome),
	setup_bd,
	(gastofixo(Nome,_)) -> deleta_gastofixo(Nome), nl,writeln("Gasto Fixo excluído com sucesso! :) "),nl;
	nl,write("Esse Gasto Fixo não existe. Tente novamente."), nl.

deleta_gastofixo(Nome):-
	setup_bd, 
	retract(gastofixo(Nome,_)),
	tell('./data/bd_gastofixo.pl'), nl,
		listing(gastofixo/2),
		told.


listaGastoFixo:- 
	nl,show_gastofixo,nl.


show_gastofixo :-
    get_gastofixo(Result),
    print_gastofixo(Result, 1).

print_gastofixo([], _).
print_gastofixo([Head|Tail], Index) :-
    string_concat(" ", Index, SpacesAndIndex),
    string_concat(SpacesAndIndex, " - ", SpacesIndexAndDash),
    string_concat(SpacesIndexAndDash, Head, CompleteString),
    writeln(CompleteString),
    Index1 is Index + 1,
    print_gastofixo(Tail, Index1).

get_gastofixo(Result):-
    setup_bd,
    findall(Nome, gastofixo(Nome,_), Queries),
    list_to_set(Queries, Result).
