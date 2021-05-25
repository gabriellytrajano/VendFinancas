:-module(saldoFinal, [saldoMensal/4, estimativaSemestral/4,
	estimativaAnual/4]).

estimativaSemestral(Salario, Bonus, Categorias, Fixos):- 
	write("Seu salario atual cadastrado eh de: R$"),
	write(Salario), nl,
	write("O valor total cadastrado em bonus salarial eh de: R$"),
	write(Bonus), nl,
	write("O valor total de despesas das categorias eh de: R$"),
	write(Categorias), nl,
	write("O valor total cadastrado nos gastos fixos eh de: R$"),
	write(Fixos), nl,
	SaldoMensal is (Salario + Bonus - Categorias - Fixos) * 6,
	write("Com os valores atuais, seu saldo deste mês eh de: R$"),
	write(SaldoMensal), nl.

estimativaAnual(Salario, Bonus, Categorias, Fixos):- 
	write("Seu salario atual cadastrado eh de: R$"),
	write(Salario), nl,
	write("O valor total cadastrado em bonus salarial eh de: R$"),
	write(Bonus), nl,
	write("O valor total de despesas das categorias eh de: R$"),
	write(Categorias), nl,
	write("O valor total cadastrado nos gastos fixos eh de: R$"),
	write(Fixos), nl,
	SaldoMensal is (Salario + Bonus - Categorias - Fixos) * 12,
	write("Com os valores atuais, seu saldo deste mês eh de: R$"),
	write(SaldoMensal), nl.

saldoMensal(Salario, Bonus, Categorias, Fixos):- 
	write("Seu salario atual cadastrado eh de: R$"),
	write(Salario), nl,
	write("O valor total cadastrado em bonus salarial eh de: R$"),
	write(Bonus), nl,
	write("O valor total de despesas das categorias eh de: R$"),
	write(Categorias), nl,
	write("O valor total cadastrado nos gastos fixos eh de: R$"),
	write(Fixos), nl,
	SaldoMensal is Salario + Bonus - Categorias - Fixos,
	write("Com os valores atuais, seu saldo deste mês eh de: R$"),
	write(SaldoMensal), nl.
