:-module(investimentos, [jurosSimples/0, jurosCompostos/0]).

jurosSimples:-
	write("Digite o capital a ser calculado: "), nl,
    read(Capital),
    write("Digite a taxa a ser calculada: "), nl,
    read(Taxa),
    write("Digite o tempo em meses a ser calculado: "),nl,
    read(Tempo),
    Res is ((Capital * (Taxa/100))/Tempo),
    tty_clear,
    write("O montante total do seu investimento é de: R$"),
    write(Res),nl.

jurosCompostos:-
	write("Digite o capital a ser calculado: "), nl,
    read(Capital),
    write("Digite a taxa a ser calculada: "), nl,
    read(Taxa),
    write("Digite o tempo em meses a ser calculado: "),nl,
    read(Tempo),
    Res is (Capital * ((1 + (Taxa/100))^Tempo)),
    tty_clear,
    write("O montante total do seu investimento é de: R$"),
    write(Res),nl.
