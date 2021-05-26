:- use_module("categoria").
:- use_module("gastoFixo").
:- use_module("salario").
:- use_module("bonusSalarial").
:- use_module("investimentos").
:- use_module("saldoFinal").

mostraLetreiro :-
    writeln(" _   _                   _  _ ______  _                                        "),                                       
    writeln("| | | |                 | || ||  ___|(_)                                       "),
    writeln("| | | |  ___  _ __    __| || || |_    _  _ __    __ _  _ __    ___   __ _  ___ "),
    writeln("| | | | / _ \\| '_ \\  / _` || ||  _|  | || '_ \\  / _` || '_ \\  / __| / _` |/ __|"),
    writeln("\\ \\_/ /|  __/| | | || (_| ||_|| |    | || | | || (_| || | | || (__ | (_| |\\__ )"),
    writeln(" \\___/  \\___||_| |_| \\__,_|(_)\\_|    |_||_| |_| \\__,_||_| |_| \\___| \\__,_||___/").


main :- 
    tty_clear,
	apresentacao, 
	mostraMenu,nl.
	

apresentacao :- 
	writeln("Bem-vinde!"), 
	writeln("Aqui vamos calcular suas finanças!"), nl.

mostraMenu :- 
    mostraLetreiro, nl,
	writeln("Menu de navegação:"),
    writeln("1 - Navegar por categoria"),
    writeln("2 - Navegar por gasto fixo"),
    writeln("3 - Navegar por salário"),
    writeln("4 - Navegar por bônus salarial"),
    writeln("5 - Navegar por investimentos"),
    writeln("6 - Calcular saldo final"),
    writeln("7 - Encerrar navegacao"),
    read(Option),
    (Option == 1 -> menuCategoria; 
    Option == 2 -> menuGastoFixo; 
    Option == 3 -> menuSalario; 
    Option == 4 -> menuBonusSalarial; 
    Option == 5 -> menuInvestimentos;
    Option == 6 -> menuSaldoFinal; 
    Option == 7 -> writeln("Obrigado por usar o Vend!Financas *-*"), nl, halt();
   funcaoInvalidaFuncion,
    mostraMenu, nl, halt).


menuCategoria :-
    writeln("Menu de Categorias:"),
    writeln("1 - Cadastrar categoria"),
    writeln("2 - Adiciona gasto na categoria"),
    writeln("3 - Excluir categoria"),
    writeln("4 - Exibir categorias"),
    writeln("5 - Voltar ao menu principal"),
    read(Opcao),
    (Opcao == 1 -> tty_clear,categoria:cadastraCategoria, menuCategoria;
    Opcao == 2 -> tty_clear,categoria:adicionaDespesaCategoria, menuCategoria;
    Opcao == 3 -> tty_clear,categoria:deletaCategoria, menuCategoria;
    Opcao == 4 -> tty_clear,categoria:listaCategorias, menuCategoria;
    Opcao == 5 -> tty_clear,mostraMenu;
    funcaoInvalidaFuncion,
    menuCategoria).


menuGastoFixo :- 
	writeln("Menu de Gastos Fixos:"),
    writeln("1 - Cadastrar gasto fixo"),
    writeln("2 - Editar gasto fixo"),
    writeln("3 - Excluir gasto fixo"),
    writeln("4 - Exibir gasto fixo"),
    writeln("5 - Voltar ao menu principal"),
    read(Opcao),
    (Opcao == 1 -> tty_clear,gastoFixo:cadastraGastoFixo, menuGastoFixo;
    Opcao == 2 -> tty_clear,gastoFixo:editaGastoFixo, menuGastoFixo;
    Opcao == 3 -> tty_clear,gastoFixo:excluiGastoFixo, menuGastoFixo;
    Opcao == 4 -> tty_clear,gastoFixo:listaGastoFixo, menuGastoFixo;
    Opcao == 5 -> tty_clear,mostraMenu;
    funcaoInvalidaFuncion,
    menuGastoFixo).


menuSalario :- 
	writeln("Menu de Salário:"),
    writeln("1 - Cadastrar salário"),
    writeln("2 - Editar salário"),
    writeln("3 - Excluir salário"),
    writeln("4 - Exibir salário"),
    writeln("5 - Voltar ao menu principal"),
    read(Option),
    (Option == 1 -> tty_clear,salario:cadastraSalario, nl,menuSalario;
    Option == 2 -> tty_clear,salario:editaSalario,nl,menuSalario;
    Option == 3 -> tty_clear,salario:excluiSalario,nl,menuSalario;
    Option == 4 -> tty_clear,salario:mostraSalario,nl,menuSalario;
    Option == 5 -> tty_clear,mostraMenu;
    funcaoInvalidaFuncion, 
    menuSalario).


menuBonusSalarial :- 
	writeln("Menu de Bônus Salarial:"),
    writeln("1 - Cadastrar bônus salarial"),
    writeln("2 - Editar bônus salarial"),
    writeln("3 - Excluir bônus"),
    writeln("4 - Exibir Bônus"),
    writeln("5 - Voltar ao menu principal"),
    read(Option),
    (Option == 1 -> tty_clear,bonusSalarial:cadastraBonusSalarial,nl,menuBonusSalarial;
    Option == 2 -> tty_clear,bonusSalarial:editaBonusSalarial,nl,menuBonusSalarial;
    Option == 3 -> tty_clear,bonusSalarial:excluiBonusSalarial,nl,menuBonusSalarial;
    Option == 4 -> tty_clear,bonusSalarial:listaBonusSalarial,nl,menuBonusSalarial;
    Option == 5 -> tty_clear,mostraMenu;
    funcaoInvalidaFuncion, 
    menuBonusSalarial).


menuInvestimentos :- 
	writeln("Menu de Investimentos:"),
    writeln("1 - Calcular juros simples"),
    writeln("2 - Calcular juros compostos"),
    writeln("3 - Voltar ao menu principal"),
    read(Option),
    (Option == 1 -> tty_clear,investimentos:jurosSimples, menuInvestimentos;
    Option == 2 -> tty_clear,investimentos:jurosCompostos, menuInvestimentos;
    Option == 3 -> tty_clear, mostraMenu;
    funcaoInvalidaFuncion,
    menuInvestimentos).


menuSaldoFinal :-
	writeln("Menu de Saldos:"),
    writeln("1 - Calcular saldo final mensal"),
    writeln("2 - Calcular estimativa do saldo semestral"),
    writeln("3 - Calcular estimativa do saldo anual"),
    writeln("4 - Voltar ao menu principal"),
    read(Option),
    (Option == 1 ->  tty_clear, mostrarSaldoFinalMensal, nl, menuSaldoFinal;
    Option == 2 ->  tty_clear, mostrarEstimativaSemestral, nl, menuSaldoFinal;
    Option == 3 ->  tty_clear, mostrarEstimativaAnual, nl, menuSaldoFinal;
    Option == 4 ->  tty_clear, mostraMenu; 
    funcaoInvalidaFuncion, 
    menuSaldoFinal).

mostrarSaldoFinalMensal :-
    salario:valorSalario(Salario),
    bonusSalarial:valorBonus(Bonus),
    categoria:somatorioCategorias(Categorias),
    gastoFixo:somatorioGastosFixos(GastosFixos),
    saldoFinal:saldoMensal(Salario, Bonus, Categorias, GastosFixos).

mostrarEstimativaSemestral :-
    salario:valorSalario(Salario),
    bonusSalarial:valorBonus(Bonus),
    categoria:somatorioCategorias(Categorias),
    gastoFixo:somatorioGastosFixos(GastosFixos),
    saldoFinal:estimativaSemestral(Salario, Bonus, Categorias, GastosFixos).

mostrarEstimativaAnual :-
    salario:valorSalario(Salario),
    bonusSalarial:valorBonus(Bonus),
    categoria:somatorioCategorias(Categorias),
    gastoFixo:somatorioGastosFixos(GastosFixos),
    saldoFinal:estimativaAnual(Salario, Bonus, Categorias, GastosFixos).

funcaoInvalidaFuncion :-
	 writeln("Opcao invalida :( "), nl.
