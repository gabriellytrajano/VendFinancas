:-module(investimentos, [jurosSimples/0, jurosCompostos/0]).

jurosSimples:-
	write("Digite o capital a ser calculado: "), nl,
    read(Capital),
    write("Digite a taxa a ser calculada: "), nl,
    read(Taxa),
    write("Digite o tempo em meses a ser calculado: "),nl,
    read(Tempo),
    Res is ((Capital * (Taxa/100))*Tempo),
    Mon is (Capital + Res),
    tty_clear,
    write("Nessa modalidade o seu dinheiro rendeu: R$"),
    write(Res),nl,
    write("O montante total do seu investimento é de: R$"),
    write(Mon), nl.

jurosCompostos:-
    write("Digite o capital a ser calculado: "), nl,
    read(Capital),
    write("Digite a taxa a ser calculada: "), nl,
    read(Taxa),
    write("Digite o tempo em meses a ser calculado: "),nl,
    read(Tempo),
    Res is (Capital * ((1 + (Taxa/100))^Tempo)),
    Mon is (Capital + Res),
    tty_clear,
    write("Nessa modalidade o seu dinheiro rendeu: R$"),
    write(Res),nl,
    write("O montante total do seu investimento é de: R$"),
    write(Mon), nl.
