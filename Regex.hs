module RegularExp where
import qualified Data.List as N (nub)

{-
  Exemplos:

-- L={aa,ab,ba,bb}
  r01 = (a |+| b) |.| (a |+| b)
  ss01 = ["aa","ab","ba","bb"]
  rec01 = rec r01 ss01 -- retorna True
  cex01 = c_exs r01 (ss01 ++ ["aaa","","ab","bba"])
-- retorna ["aaa","","bba"]

-- L = Todos os strings sobre {a,b} que terminam em bb
  r03 = star (a |+| b) |.| (b |.| b)
  ss03 = ["bb","abb","bbb"]
  rec03 = rec r03 ss03 -- retorna True
  cex03 = c_exs r03 (ss03 ++ ["aa","ab","ba","bb","aabb"])
-- retorna ["aa","ab","ba"]
-}

{-

  Criar as funcoes com os operandos requisitados e utilizar como entrada as
  Strings.

  Iterar recursivamente sobre elas para obter os resultados esperados.
  Aplicar a isnt acima para cada caracter da String.

-}


(|+|)::[String] -> [String] -> [String]
-- Executar a operacao de uniao sobre s1 e s2
[] |+| _ = []
_ |+| [] = []
s1 |+| s2 = N.nub (s1++s2++((map (head s1++) s2) ++ (tail s1 |+| s2)) ++
  ((map (head s2++) s1) ++ (tail s2 |+| s1)))


(|.|)::[String]->[String]->[String]
-- Executar a operacao de concatenacao sobre s1 e s2
[] |.| _ = []
_ |.| [] = []
s1 |.| s2 = N.nub (map (head s1++) s2 ++ tail s1 |.| s2)

star::[String]->[String]
star s = s++map (head x++) (tail x) ++ star (tail x)
    where x = concat (iterate star s)
      --concat (iterate star s)

char::String->String
char s = if length s == 1 then s else []

rec::[String]->[String]->Bool
-- rec <lista de possiveis> <lista dada pelo usuario>
rec x y = or (rec' x y)

rec'::[String]->[String]->[Bool]
rec' x y = map (elem (head x)) [y] ++ rec' (tail x) y

  --((map (elem (head x)) [y]) ++ rec (tail x) y)


--ex01 = (["a"] |+| ["b"]) |.| (["a"] |+| ["b"])

{-
data Regex = Eps | Lit Char | Concat Regex Regex | Union Regex Regex | Star Regex deriving Eq

instance Show Regex where
  show = printReg

star:: Regex -> [String]
star Eps = []
star (Lit a) = star (Lit a)
star (Concat x y) = star x++star y
star (Union x y) = star x++star y
star (Star x) = star x


verifica:: Regex -> String -> Bool
verifica Eps s = s == ""
verifica (Lit c) s = [c] == s
--verifica (Concat x y) s =  or [verifica x s1 && verifica y s2 | (s1,s2) <- Split s]



-- Lista de Literais
lit::Regex -> String
lit Eps = []
lit (Lit c) = [c]
lit (Concat r1 r2) = lit r1 ++ lit r2
lit (Union r1 r2) = lit r1 ++ lit r2
lit (Star r) = lit r


printReg:: Regex -> String
printReg Eps = "#"
printReg (Lit c) = [c]
printReg (Union r1 r2) = "("++printReg r1++" |+| "++printReg r2++")"
printReg (Concat r1 r2) = "(" ++ printReg r1++ " |.| " ++ printReg r2 ++ ")"
printReg (Star r) = "(" ++ printReg r ++ ")*"
-}
