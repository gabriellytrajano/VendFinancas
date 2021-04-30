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
    putStrLn("6 - Encerrar navegacao")
    opcao <- getLine
    chamarMenus opcao

menuCategoria :: IO()
menuCategoria = do
    putStrLn("Menu de Categorias:")
    putStrLn("1 - Cadastrar categoria")
    putStrLn("2 - Editar categoria")
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


chamarMenus :: String -> IO()
chamarMenus x
    | x == "1" = menuCategoria
    | x == "2" = menuGastoFixo
    | x == "3" = menuSalario
    | x == "4" = menuBonusSalarial
    | x == "5" = menuInvestimento
    | otherwise = putStrLn("Não é uma opção válida")

chamarMenuCategoria :: String -> IO()
chamarMenuCategoria x
    | x == "1" = cadastraCategoria
    | x == "2" = editaCategoria
    | x == "3" = excluiCategoria
    | x == "4" = showMenu
    | otherwise = putStrLn("Não é uma opção válida")

chamarMenuGastoFixo :: String -> IO()
chamarMenuGastoFixo x
    | x == "1" = cadastraGastoFixo
    | x == "2" = editaGastoFixo
    | x == "3" = excluiGastoFixo
    | x == "4" = showMenu
    | otherwise = putStrLn("Não é uma opção válida")


chamarMenuSalario :: String -> IO()
chamarMenuSalario x
    | x == "1" = cadastraSalario
    | x == "2" = editaSalario
    | x == "3" = excluiSalario
    | x == "4" = showMenu
    | otherwise = putStrLn("Não é uma opção válida")

chamarMenuBonusSalarial :: String -> IO()
chamarMenuBonusSalarial x
    | x == "1" = cadastraBonusSalarial
    | x == "2" = editaBonusSalarial
    | x == "3" = excluiBonusSalarial
    | x == "4" = showMenu
    | otherwise = putStrLn("Não é uma opção válida")

chamarMenuInvestimento :: String -> IO()
chamarMenuInvestimento x
    | x == "1" = jurosSimples
    | x == "2" = jurosCompostos
    | x == "3" = showMenu
    | otherwise = putStrLn("Não é uma opção válida")


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
  menuCategoria

editaCategoria :: IO()
editaCategoria = do
 putStrLn "Digite a categoria a ser editada:"
 categoria <- getLine
 fileExists <- doesFileExist (categoria ++ ".txt")
 if fileExists
  then do
  putStrLn "Digite o novo valor em reais da categoria:\n"
  valor <- getLine
  file <- openFile (categoria ++ ".txt") WriteMode
  hPutStr file valor
  putStrLn "Categoria editada com sucesso!!\n"
  hFlush file
  hClose file
  else do
  putStrLn "Categoria não existe!! \nO que deseja fazer?\n"
  menuCategoria

excluiCategoria:: IO()
excluiCategoria = do
 putStrLn "Digite o nome da categoria a ser excluída:"
 categoria <- getLine
 fileExists <- doesFileExist (categoria ++ ".txt")
 if fileExists
  then do
  removeFile (categoria ++ ".txt")
  putStrLn "Categoria excluída com sucesso!!\n"
  else do
  putStrLn "Categoria não existe!! \nO que deseja fazer?\n"
  menuCategoria


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
  menuGastoFixo

editaGastoFixo :: IO()
editaGastoFixo = do
 putStrLn "Digite o nome do gasto fixo a ser editado:"
 gastoFixo <- getLine
 fileExists <- doesFileExist (gastoFixo ++ ".txt")
 if fileExists
  then do
  putStrLn "Digite o novo valor em reais do gasto fixo:\n"
  valor <- getLine
  file <- openFile (gastoFixo ++ ".txt") WriteMode
  hPutStr file valor
  putStrLn "Gasto fixo editado com sucesso!!\n"
  hFlush file
  hClose file
  else do
  putStrLn "Gasto fixo não existe!! \nO que deseja fazer?\n"
  menuGastoFixo

excluiGastoFixo:: IO()
excluiGastoFixo = do
 putStrLn "Digite o nome do gasto fixo a ser excluído:"
 gastoFixo <- getLine
 fileExists <- doesFileExist (gastoFixo ++ ".txt")
 if fileExists
  then do
  removeFile (gastoFixo ++ ".txt")
  putStrLn "Gasto fixo excluído com sucesso!!\n"
  else do
  putStrLn "Gasto fixo não existe!! \nO que deseja fazer?\n"
  menuGastoFixo


-- SALARIO
cadastraSalario :: IO()
cadastraSalario = do
 fileExists <- doesFileExist ("salario.txt")
 if fileExists
  then do
  putStrLn "Sálario já cadastrado!!\nO que deseja fazer?\n"
  menuSalario
  else do
  putStrLn "Digite o valor do seu salário em reais:"
  salario <- getLine
  file <- openFile ("salario.txt") WriteMode
  hPutStr file salario
  putStrLn "Salário cadastrado com sucesso!!\n"
  hFlush file
  hClose file

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
  else do
  putStrLn "Ainda não foi cadastrado um salário. \nO que deseja fazer?\n"
  menuSalario

excluiSalario:: IO()
excluiSalario = do
 fileExists <- doesFileExist ("salario.txt")
 if fileExists
  then do
  removeFile ("salario.txt")
  putStrLn "Salário excluído com sucesso!!\n"
  else do
  putStrLn "Ainda não foi cadastrado um salário. \nO que deseja fazer?\n"
  menuSalario


-- BONUS SALARIAL
cadastraBonusSalarial :: IO()
cadastraBonusSalarial = do
 fileExists <- doesFileExist ("bonusSalarial.txt")
 if fileExists
  then do
  putStrLn "Bônus salarial já cadastrado!!\nO que deseja fazer?\n"
  menuBonusSalarial
  else do
  putStrLn "Digite o valor do bônus salarial em reais:"
  bonusSalarial <- getLine
  file <- openFile ("bonusSalarial.txt") WriteMode
  hPutStr file bonusSalarial
  putStrLn "Bônus salarial cadastrado com sucesso!!\n"
  hFlush file
  hClose file

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
  else do
  putStrLn "Ainda não foi cadastrado um bônus salarial. \nO que deseja fazer?\n"
  menuBonusSalarial

excluiBonusSalarial:: IO()
excluiBonusSalarial = do
 fileExists <- doesFileExist ("bonusSalarial.txt")
 if fileExists
  then do
  removeFile ("bonusSalarial.txt")
  putStrLn "Bônus salarial excluído com sucesso!!\n"
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
 putStrLn ("O juro simples é de: R$" ++ show calculo)


jurosCompostos:: IO()
jurosCompostos = do
 putStrLn "Digite o capital a ser calculado: "
 capital <- getLine
 putStrLn "Digite a taxa a ser calculada: "
 taxa <- getLine
 putStrLn "Digite o tempo em meses a ser calculado: "
 tempo <- getLine
 let calculo = (read capital) * 1 + (read taxa/100) ^ (read tempo)
 putStrLn ("O juro compostos é de: R$" ++ show calculo)


exibeLetreiro :: String
exibeLetreiro = unsafeDupablePerformIO (readFile "letreiro.txt")
