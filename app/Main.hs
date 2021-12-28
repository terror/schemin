module Main where
import Control.Monad
import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)

data LispVal =
    Atom       String
  | List       [LispVal]
  | DottedList [LispVal] LispVal
  | Number     Integer
  | String     String
  | Bool       Bool
  deriving Show

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

spaces :: Parser ()
spaces = skipMany1 space

parseString :: Parser LispVal
parseString = do
  char '"'
  x <- many (noneOf "\"")
  char '"'
  return $ String x

parseAtom :: Parser LispVal
parseAtom = do
  first <- letter <|> symbol
  rest  <- many (letter <|> digit <|> symbol)
  let atom = first:rest
  return $ case atom of
    "#t" -> Bool True
    "#f" -> Bool False
    _    -> Atom atom

parseNumber :: Parser LispVal
parseNumber = liftM (Number . read) $ many1 digit

parseExpr :: Parser LispVal
parseExpr = parseAtom
 <|> parseString
 <|> parseNumber

readExpr :: String -> String
readExpr input = case parse parseExpr "schemin" input of
  Left  e -> "No match: "    ++ show e
  Right v -> "Found value: " ++ show v

main :: IO ()
main = do
  (expr:_) <- getArgs
  putStrLn (readExpr expr)
