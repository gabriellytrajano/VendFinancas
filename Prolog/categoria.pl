:-module(categoria, [cadastraCategoria/2]).

:- use_module(library(apply)).
:- use_module(library(csv)).

setup_bd :-
	consult('./data/bd_categoria.pl').

write_categoria(Nome, Valor):-
	setup_bd,
	categoria(Nome,_),
	get_word_data_failure.
write_categoria(Nome, Valor):-	
	assertz(categoria(Nome, Valor)),
	write_salary_file, 
	write("Categoria cadastrada com sucesso!!"), nl.

write_salary_file :-
	setup_bd,
		tell('./data/bd_categoria.pl'),nl,
		listing(categoria/2),
		told.


cadastraCategoria:-
	nl,write("Digite o nome da categoria a ser cadastrada:"), nl,
	read(Nome),
	nl,write("Digite o valor da categoria a ser cadastrada:"), nl,
	read(Valor),
	write_categoria(Nome, Valor).

get_word_data_failure :-
  writeln("Essa categoria já foi cadastrada, tente novamente :( "), nl.
