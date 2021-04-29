import System.Directory
import System.IO

main :: IO()
main = do

    putStrLn $ "Bem vind@!\n"
    putStrLn $ "Aqui vamos calcular suas finanças"
    putStrLn $ "Se possuir, digite seu salario, caso nao possua, digite 0"
    salario <- getLine
    putStrLn $ "Ok, salário cadastrado!" ++ "\n"
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
    --opcao <- getLine
    --chamarMenuGastoFixo opcao

menuSalario :: IO()
menuSalario = do
    putStrLn("Menu de Salário:")
    putStrLn("1 - Cadastrar salário")
    putStrLn("2 - Editar salário")
    putStrLn("3 - Excluir salário")
    putStrLn("4 - Voltar ao menu principal")
    --opcao <- getLine
    --chamarMenuSalario opcao

menuBonusSalarial :: IO()
menuBonusSalarial = do
    putStrLn("Menu de Bônus Salarial:")
    putStrLn("1 - Cadastrar bônus salarial")
    putStrLn("2 - Editar bônus salarial")
    putStrLn("3 - Excluir bônus")
    putStrLn("4 - Voltar ao menu principal")
    --opcao <- getLine
    --chamarMenuBonusSalarial opcao

menuInvestimento :: IO()
menuInvestimento = do
    putStrLn("Menu de Investimentos:")
    putStrLn("1 - Cadastrar investimento")
    putStrLn("2 - Editar investimento")
    putStrLn("3 - Excluir investimento")
    putStrLn("4 - Voltar ao menu principal")
    --opcao <- getLine
    --chamarMenuInvestimento opcao


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
    | otherwise = putStrLn("Não é uma opção válida")


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
  addSomasCategorias (read valor)


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


addSomasCategorias:: Float -> IO()
addSomasCategorias valor = do
  fileExists <- doesFileExist ("somaCategorias.txt")
  if fileExists
  then do
  file <- openFile ("somaCategorias.txt") ReadMode
  valorTotal <- hGetContents file
  novoValorTotal <- (read valorTotal::IO Float) + valor
  hFlush file
  hClose file
  file2 <- openFile ("somaCategorias.txt") WriteMode
  hPutStr file2 novoValorTotal
  hFlush file2
  hClose file2
  else do
  file <- openFile ("somaCategorias.txt") WriteMode
  hPutStr file valor
  hFlush file
  hClose file