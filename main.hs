import System.Directory
import System.IO
import System.IO.Unsafe(unsafeDupablePerformIO)

main :: IO()
main = do
    putStrLn (exibeLetreiro)
    putStrLn $ "Bem vind@!"
    putStrLn $ "Aqui vamos calcular suas finanças!\n"
    showMenu

showMenu :: IO()
showMenu = do
    putStrLn("Menu de navegação:")
    putStrLn("1 - Navegar por categoria")
    putStrLn("2 - Navegar por gasto fixo")
    putStrLn("3 - Navegar por salário")
    putStrLn("4 - Navegar por bônus salarial")
    putStrLn("5 - Navegar por investimentos")
    putStrLn("6 - Calcular saldo final")
    putStrLn("7 - Encerrar navegacao")
    
    opcao <- getLine
    chamarMenus opcao

menuCategoria :: IO()
menuCategoria = do
    putStrLn("Menu de Categorias:")
    putStrLn("1 - Cadastrar categoria")
    putStrLn("2 - Adiciona gasto na categoria")
    putStrLn("3 - Excluir categoria")
    putStrLn("4 - Voltar ao menu principal")
    opcao <- getLine
    chamarMenuCategoria opcao

menuGastoFixo :: IO()
menuGastoFixo = do
    putStrLn("Menu de Gastos Fixos:")
    putStrLn("1 - Cadastrar gasto fixo")
    putStrLn("2 - Editar gasto fixo")
    putStrLn("3 - Excluir gasto fixo")
    putStrLn("4 - Voltar ao menu principal")
    opcao <- getLine
    chamarMenuGastoFixo opcao

menuSalario :: IO()
menuSalario = do
    putStrLn("Menu de Salário:")
    putStrLn("1 - Cadastrar salário")
    putStrLn("2 - Editar salário")
    putStrLn("3 - Excluir salário")
    putStrLn("4 - Voltar ao menu principal")
    opcao <- getLine
    chamarMenuSalario opcao

menuBonusSalarial :: IO()
menuBonusSalarial = do
    putStrLn("Menu de Bônus Salarial:")
    putStrLn("1 - Cadastrar bônus salarial")
    putStrLn("2 - Editar bônus salarial")
    putStrLn("3 - Excluir bônus")
    putStrLn("4 - Voltar ao menu principal")
    opcao <- getLine
    chamarMenuBonusSalarial opcao

menuInvestimento :: IO()
menuInvestimento = do
    putStrLn("Menu de Investimentos:")
    putStrLn("1 - Calcular juros simples")
    putStrLn("2 - Calcular juros compostos")
    putStrLn("3 - Voltar ao menu principal")
    opcao <- getLine
    chamarMenuInvestimento opcao

menuSaldo :: IO()
menuSaldo = do
    putStrLn("Menu de Saldos:")
    putStrLn("1 - Calcular saldo final mensal")
    putStrLn("2 - Calcular estimativa do saldo semestral")
    putStrLn("3 - Calcular estimativa do saldo anual")
    putStrLn("4 - Voltar ao menu principal")
    opcao <- getLine
    chamarMenuSaldo opcao



chamarMenus :: String -> IO()
chamarMenus x
    | x == "1" = menuCategoria
    | x == "2" = menuGastoFixo
    | x == "3" = menuSalario
    | x == "4" = menuBonusSalarial
    | x == "5" = menuInvestimento
    | x == "6" = menuSaldo
    | x == "7" = putStrLn ("Obrigado por usar o Vend!Financas *-*")
    | otherwise = opcaoInvalida

chamarMenuCategoria :: String -> IO()
chamarMenuCategoria x
    | x == "1" = cadastraCategoria
    | x == "2" = adicionaDespesaCategoria
    | x == "3" = excluiCategoria
    | x == "4" = showMenu
    | otherwise = opcaoInvalida

chamarMenuGastoFixo :: String -> IO()
chamarMenuGastoFixo x
    | x == "1" = cadastraGastoFixo
    | x == "2" = editaGastoFixo
    | x == "3" = excluiGastoFixo
    | x == "4" = showMenu
    | otherwise = opcaoInvalida


chamarMenuSalario :: String -> IO()
chamarMenuSalario x
    | x == "1" = cadastraSalario
    | x == "2" = editaSalario
    | x == "3" = excluiSalario
    | x == "4" = showMenu
    | otherwise = opcaoInvalida

chamarMenuBonusSalarial :: String -> IO()
chamarMenuBonusSalarial x
    | x == "1" = cadastraBonusSalarial
    | x == "2" = editaBonusSalarial
    | x == "3" = excluiBonusSalarial
    | x == "4" = showMenu
    | otherwise = opcaoInvalida

chamarMenuInvestimento :: String -> IO()
chamarMenuInvestimento x
    | x == "1" = jurosSimples
    | x == "2" = jurosCompostos
    | x == "3" = showMenu
    | otherwise = opcaoInvalida

chamarMenuSaldo :: String -> IO()
chamarMenuSaldo x
    | x == "1" = saldoMensal
    | x == "2" = estimativaSemestral
    | x == "3" = estimativaAnual
    | x == "4" = showMenu
    | otherwise = opcaoInvalida
    
opcaoInvalida :: IO()
opcaoInvalida = do
    putStrLn("Não é uma opção válida")
    showMenu


-- CATEGORIA
cadastraCategoria :: IO()
cadastraCategoria = do
 putStrLn "Digite o nome da nova categoria:"
 categoria <- getLine
 fileExists <- doesFileExist (categoria ++ ".txt")
 if fileExists
  then do
  putStrLn "Categoria já existe!!\nO que deseja fazer?\n\n"
  menuCategoria
  else do
  file <- openFile (categoria ++ ".txt") WriteMode
  putStrLn "Digite o valor em reais da categoria: "
  valor <- getLine
  hPutStr file valor
  putStrLn "Categoria cadastrada com sucesso!!\n\n"
  hFlush file
  hClose file
  somaCategoriasCadastradas (read valor :: Float)
  menuCategoria

somaCategoriasCadastradas :: Float -> IO ()
somaCategoriasCadastradas valor = do
    file <- openFile ("somaCategorias.txt") ReadMode
    valorTotal <- hGetContents file
    let valor1 = (read valorTotal :: Float) + valor
    print ("Aviso: seus gastos ja se acumulam em " ++ (show valor1))
    hClose file
    file2 <- openFile ("somaCategorias.txt") WriteMode
    hPutStr file2 (show valor1)
    hFlush file2
    hClose file2

adicionaDespesaCategoria :: IO()
adicionaDespesaCategoria = do
 putStrLn "Digite a categoria a ser editada:"
 categoria <- getLine
 fileExists <- doesFileExist (categoria ++ ".txt")
 if fileExists
  then do
  file <- openFile (categoria ++ ".txt") ReadMode
  valorAntigo <- hGetContents file
  let valorAntigoFloat = (read valorAntigo :: Float)
  print ("O valor atual dessa categoria eh: R$" ++ (show valorAntigoFloat))
  hClose file
  putStrLn "Digite o valor em reais da nova despesa da categoria:\n"
  valorNovaDespesa <- getLine
  file <- openFile (categoria ++ ".txt") WriteMode
  hPutStr file (show ((read valorNovaDespesa :: Float) + valorAntigoFloat))
  putStrLn ("Sucesso! O valor atual dessa categoria agora é: " ++ (show ((read valorNovaDespesa :: Float) + valorAntigoFloat)))
  hFlush file
  hClose file
  adicionaDespesaCategoriasCadastradas (read valorNovaDespesa :: Float)
  menuCategoria
  else do
  putStrLn "Categoria não existe!! \nO que deseja fazer?\n"
  menuCategoria

adicionaDespesaCategoriasCadastradas :: Float -> IO ()
adicionaDespesaCategoriasCadastradas valorNovaDespesa = do
    file <- openFile ("somaCategorias.txt") ReadMode
    valorTotal <- hGetContents file
    let valor1 = (read valorTotal :: Float) + valorNovaDespesa
    print ("Aviso: agora seus gastos de categorias se acumulam em " ++ (show valor1))
    hClose file
    file2 <- openFile ("somaCategorias.txt") WriteMode
    hPutStr file2 (show valor1)
    hFlush file2
    hClose file2

excluiCategoria:: IO()
excluiCategoria = do
 putStrLn "Digite o nome da categoria a ser excluida:"
 categoria <- getLine
 fileExists <- doesFileExist (categoria ++ ".txt")
 if fileExists
  then do
  file <- openFile (categoria ++ ".txt") ReadMode
  valorSubtracao <- hGetContents file
  let valorSubtracaoFloat = (read valorSubtracao :: Float)
  print ("O valor R$" ++ (show valorSubtracaoFloat) ++ " ja nao consta mais no seu montante de despesas!")
  hClose file
  removeFile (categoria ++ ".txt")
  putStrLn "Categoria excluida com sucesso!!\n"
  excluiValorSomaCategoriasCadastradas valorSubtracaoFloat
  menuCategoria
  else do
  putStrLn "Categoria nao existe!! \nO que deseja fazer?\n"
  menuCategoria

excluiValorSomaCategoriasCadastradas :: Float -> IO()
excluiValorSomaCategoriasCadastradas valorSubtracaoFloat = do
    file <- openFile ("somaCategorias.txt") ReadMode
    valorTotal <- hGetContents file
    let valor1 = (read valorTotal :: Float) - valorSubtracaoFloat
    print ("Aviso: agora seus gastos se acumulam em " ++ (show valor1))
    hClose file
    file2 <- openFile ("somaCategorias.txt") WriteMode
    hPutStr file2 (show valor1)
    hFlush file2
    hClose file2


-- GASTO FIXO
cadastraGastoFixo :: IO()
cadastraGastoFixo = do
 putStrLn "Digite o nome do gasto fixo:"
 gastoFixo <- getLine
 fileExists <- doesFileExist (gastoFixo ++ ".txt")
 if fileExists
  then do
  putStrLn "Gasto fixo já existe!!\nO que deseja fazer?\n\n"
  menuGastoFixo
  else do
  file <- openFile (gastoFixo ++ ".txt") WriteMode
  putStrLn "Digite o valor em reais do gasto fixo: "
  valor <- getLine
  hPutStr file valor
  putStrLn "Gasto fixo cadastrada com sucesso!!\n\n"
  hFlush file
  hClose file
  somaGastosFixosCadastradas (read valor :: Float)
  menuGastoFixo

somaGastosFixosCadastradas :: Float -> IO ()
somaGastosFixosCadastradas valor = do
    file <- openFile ("somaGastosFixos.txt") ReadMode
    valorTotal <- hGetContents file
    let valor1 = (read valorTotal :: Float) + valor
    print ("Aviso: a soma dos seus gastos fixos agora totaliza em R$" ++ (show valor1))
    hClose file
    file2 <- openFile ("somaGastosFixos.txt") WriteMode
    hPutStr file2 (show valor1)
    hFlush file2
    hClose file2

editaGastoFixo :: IO()
editaGastoFixo = do
 putStrLn "Digite o nome do gasto fixo a ser editado:"
 gastoFixo <- getLine
 fileExists <- doesFileExist (gastoFixo ++ ".txt")
 if fileExists
  then do
  file <- openFile (gastoFixo ++ ".txt") ReadMode
  valorAntigo <- hGetContents file
  let valorAntigoFloat = (read valorAntigo :: Float)
  print ("O antigo valor cadastrado nesse gasto fixo era: R$" ++ (show valorAntigoFloat))
  hClose file
  putStrLn "Digite o novo valor em reais do gasto fixo:\n"
  valor <- getLine
  file <- openFile (gastoFixo ++ ".txt") WriteMode
  hPutStr file valor
  putStrLn "Gasto fixo editado com sucesso!!\n"
  hFlush file
  hClose file
  editaSomaGastosFixosCadastradas valorAntigoFloat (read valor :: Float)
  menuGastoFixo
  else do
  putStrLn "Gasto fixo não existe!! \nO que deseja fazer?\n"
  menuGastoFixo

editaSomaGastosFixosCadastradas :: Float -> Float -> IO ()
editaSomaGastosFixosCadastradas valorAntigoFloat valor = do
    file <- openFile ("somaGastosFixos.txt") ReadMode
    valorTotal <- hGetContents file
    let valor1 = (read valorTotal :: Float) - valorAntigoFloat + valor
    print ("Aviso: agora seus gastos fixos se acumulam em R$" ++ (show valor1))
    hClose file
    file2 <- openFile ("somaGastosFixos.txt") WriteMode
    hPutStr file2 (show valor1)
    hFlush file2
    hClose file2

excluiGastoFixo:: IO()
excluiGastoFixo = do
 putStrLn "Digite o nome do gasto fixo a ser excluído:"
 gastoFixo <- getLine
 fileExists <- doesFileExist (gastoFixo ++ ".txt")
 if fileExists
  then do
  file <- openFile (gastoFixo ++ ".txt") ReadMode
  valorSubtracao <- hGetContents file
  let valorSubtracaoFloat = (read valorSubtracao :: Float)
  print ("O valor R$" ++ (show valorSubtracaoFloat) ++ " ja nao consta mais no seu montante de gastos fixos!")
  hClose file
  removeFile (gastoFixo ++ ".txt")
  putStrLn "Gasto fixo excluído com sucesso!!\n"
  excluiValorSomaGastosFixosCadastradas valorSubtracaoFloat
  menuGastoFixo
  else do
  putStrLn "Gasto fixo não existe!! \nO que deseja fazer?\n"
  menuGastoFixo

excluiValorSomaGastosFixosCadastradas :: Float -> IO()
excluiValorSomaGastosFixosCadastradas valorSubtracaoFloat = do
    file <- openFile ("somaGastosFixos.txt") ReadMode
    valorTotal <- hGetContents file
    let valor1 = (read valorTotal :: Float) - valorSubtracaoFloat
    print ("Aviso: agora seus gastos fixos se acumulam em R$" ++ (show valor1))
    hClose file
    file2 <- openFile ("somaGastosFixos.txt") WriteMode
    hPutStr file2 (show valor1)
    hFlush file2
    hClose file2


-- SALARIO
cadastraSalario :: IO()
cadastraSalario = do
  putStrLn "Digite o valor do seu salário em reais:"
  salario <- getLine
  file <- openFile ("salario.txt") WriteMode
  hPutStr file salario
  putStrLn "Salário cadastrado com sucesso!!\n"
  hFlush file
  hClose file
  menuSalario

editaSalario :: IO()
editaSalario = do
 putStrLn "Digite o novo valor do seu salário:"
 salario <- getLine
 fileExists <- doesFileExist ("salario.txt")
 if fileExists
  then do
  file <- openFile ("salario.txt") WriteMode
  hPutStr file salario
  putStrLn "Salário editado com sucesso!!\n"
  hFlush file
  hClose file
  menuSalario
  else do
  putStrLn "Ainda não foi cadastrado um salário. \nO que deseja fazer?\n"
  menuSalario

excluiSalario:: IO()
excluiSalario = do
 fileExists <- doesFileExist ("salario.txt")
 if fileExists
  then do
  file <- openFile ("bonusSalarial.txt") WriteMode
  hPutStr file "0.0"
  hFlush file
  hClose file
  putStrLn "Salário excluído com sucesso!!\n"
  menuSalario
  else do
  putStrLn "Ainda não foi cadastrado um salário. \nO que deseja fazer?\n"
  menuSalario


-- BONUS SALARIAL
cadastraBonusSalarial :: IO()
cadastraBonusSalarial = do
  putStrLn "Digite o valor do bônus salarial em reais:"
  bonusSalarial <- getLine
  file <- openFile ("bonusSalarial.txt") WriteMode
  hPutStr file bonusSalarial
  putStrLn "Bônus salarial cadastrado com sucesso!!\n"
  hFlush file
  hClose file
  menuBonusSalarial

editaBonusSalarial :: IO()
editaBonusSalarial = do
 putStrLn "Digite o novo valor do valor do Bônus Salarial:"
 bonusSalarial <- getLine
 fileExists <- doesFileExist ("bonusSalarial.txt")
 if fileExists
  then do
  file <- openFile ("bonusSalarial.txt") WriteMode
  hPutStr file bonusSalarial
  putStrLn "Bônus salarial editado com sucesso!!\n"
  hFlush file
  hClose file
  menuBonusSalarial
  else do
  putStrLn "Ainda não foi cadastrado um bônus salarial. \nO que deseja fazer?\n"
  menuBonusSalarial

excluiBonusSalarial:: IO()
excluiBonusSalarial = do
 fileExists <- doesFileExist ("bonusSalarial.txt")
 if fileExists
  then do
  file <- openFile ("bonusSalarial.txt") WriteMode
  hPutStr file "0.0"
  hFlush file
  hClose file
  putStrLn "Bônus salarial excluído com sucesso!!\n"
  menuBonusSalarial
  else do
  putStrLn "Ainda não foi cadastrado um bônus salarial. \nO que deseja fazer?\n"
  menuBonusSalarial


-- INVESTIMENTO 

jurosSimples:: IO()
jurosSimples = do
 putStrLn "Digite o capital a ser calculado: "
 capital <- getLine
 putStrLn "Digite a taxa a ser calculada: "
 taxa <- getLine
 putStrLn "Digite o tempo em meses a ser calculado: "
 tempo <- getLine
 let calculo = (read capital) * (read taxa/100) * (read tempo)
 putStrLn ("Nessa modalidade o seu dinheiro rendeu: R$" ++ show calculo)
 putStrLn ("O montante total do seu investimento é de: R$" ++ (show(read capital + calculo)))
 menuInvestimento


jurosCompostos:: IO()
jurosCompostos = do
 putStrLn "Digite o capital a ser calculado: "
 capital <- getLine
 putStrLn "Digite a taxa a ser calculada: "
 taxa <- getLine
 putStrLn "Digite o tempo em meses a ser calculado: "
 tempo <- getLine
 let calculo = (read capital) * ((1 + (read taxa/100)) ^ (read tempo))
 putStrLn ("Nessa modalidade o seu dinheiro rendeu: R$" ++ (show(calculo - (read capital :: Float))))
 putStrLn ("O montante total do seu investimento é de: R$" ++ show calculo)
 menuInvestimento

saldoMensal :: IO()
saldoMensal = do
    file <- openFile ("salario.txt") ReadMode
    salario <- hGetContents file
    let salarioFloat = (read salario :: Float)
    
    print ("Seu salario atual cadastrado eh de: R$" ++ (show (salarioFloat)))
    hClose file
    file <- openFile ("bonusSalarial.txt") ReadMode
    bonusSalarial <- hGetContents file
    let bonusSalarialFloat = (read bonusSalarial :: Float)
    print ("O valor total cadastrado em bonus salarial eh de: R$" ++ (show (bonusSalarialFloat)))
    hClose file
    file <- openFile ("somaCategorias.txt") ReadMode
    somaCategorias <- hGetContents file
    let somaCategoriasFloat = (read somaCategorias :: Float)
    print ("O valor total de despesas das categorias eh de: R$" ++ (show (somaCategoriasFloat)))
    hClose file
    file <- openFile ("somaGastosFixos.txt") ReadMode
    somaGastosFixos <- hGetContents file
    let somaGastosFixosFloat = (read somaGastosFixos :: Float)
    print ("O valor total cadastrado nos gastos fixos eh de: R$" ++ (show (somaGastosFixosFloat)))
    hClose file
    putStrLn ("Com os valores atuais, seu saldo deste mês é de: R$" ++ (show (salarioFloat + bonusSalarialFloat - somaCategoriasFloat - somaGastosFixosFloat)))
    menuSaldo

estimativaSemestral :: IO()
estimativaSemestral = do
    file <- openFile ("salario.txt") ReadMode
    salario <- hGetContents file
    let salarioFloat = (read salario :: Float)
    print ("Seu salario atual cadastrado eh de: R$" ++ (show (salarioFloat)))
    hClose file
    file <- openFile ("bonusSalarial.txt") ReadMode
    bonusSalarial <- hGetContents file
    let bonusSalarialFloat = (read bonusSalarial :: Float)
    print ("O valor total cadastrado em bonus salarial eh de: R$" ++ (show (bonusSalarialFloat)))
    hClose file
    file <- openFile ("somaCategorias.txt") ReadMode
    somaCategorias <- hGetContents file
    let somaCategoriasFloat = (read somaCategorias :: Float)
    print ("O valor total de despesas das categorias eh de: R$" ++ (show (somaCategoriasFloat)))
    hClose file
    file <- openFile ("somaGastosFixos.txt") ReadMode
    somaGastosFixos <- hGetContents file
    let somaGastosFixosFloat = (read somaGastosFixos :: Float)
    print ("O valor total cadastrado nos gastos fixos eh de: R$" ++ (show (somaGastosFixosFloat)))
    hClose file
    putStrLn ("Com os valores atuais, seu saldo em 6 meses sera de: R$" ++ (show ((salarioFloat + bonusSalarialFloat - somaCategoriasFloat - somaGastosFixosFloat) * 6)))
    menuSaldo

estimativaAnual :: IO()
estimativaAnual = do
    file <- openFile ("salario.txt") ReadMode
    salario <- hGetContents file
    let salarioFloat = (read salario :: Float)
    print ("Seu salario atual cadastrado eh de: R$" ++ (show (salarioFloat)))
    hClose file
    file <- openFile ("bonusSalarial.txt") ReadMode
    bonusSalarial <- hGetContents file
    let bonusSalarialFloat = (read bonusSalarial :: Float)
    print ("O valor total cadastrado em bonus salarial eh de: R$" ++ (show (bonusSalarialFloat)))
    hClose file
    file <- openFile ("somaCategorias.txt") ReadMode
    somaCategorias <- hGetContents file
    let somaCategoriasFloat = (read somaCategorias :: Float)
    print ("O valor total de despesas das categorias eh de: R$" ++ (show (somaCategoriasFloat)))
    hClose file
    file <- openFile ("somaGastosFixos.txt") ReadMode
    somaGastosFixos <- hGetContents file
    let somaGastosFixosFloat = (read somaGastosFixos :: Float)
    print ("O valor total cadastrado nos gastos fixos eh de: R$" ++ (show (somaGastosFixosFloat)))
    hClose file
    putStrLn ("Com os valores atuais, seu saldo em 1 ano sera de: R$" ++ (show ((salarioFloat + bonusSalarialFloat - somaCategoriasFloat - somaGastosFixosFloat) * 12)))
    menuSaldo

exibeLetreiro :: String
exibeLetreiro = unsafeDupablePerformIO (readFile "letreiro.txt")
