module RegularExp where
import qualified Data.List as N (nub)
import Data.Char

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

star::[String] -> [String]
star s' = take 50 (star' s')
  where
      star' s = s++map (head x++) (tail x) ++ star' (tail x)
        where x = concat (iterate star' s)

eps::[String]
eps = [""]

rec::[String]->[String]->Bool
-- rec <lista de possiveis> <lista dada pelo usuario>
rec x' y' = or (rec' x' y')
  where
      rec' x y = map (elem (head x)) [y] ++ rec' (tail x) y

notMatch::[String]->[String]->[String]
notMatch x' y' = N.nub (notMatch' x' y')
  where
  notMatch' [] y = y
  notMatch' x [] = x
  notMatch' x y = if elem (head y) x then notMatch' x (tail y) else [head y] ++ notMatch' x (tail y)

-- Todos strings sobre {a, b} com no maximo dois a’s.
t1 = star ["b"] |.| (["a"] |+| eps) |.| (["a"] |+| eps) |.| star ["b"]

-- Todos strings sobre {a, b} com exatamente dois a’s.
t2 = star ["b"] |.| ["a"] |.| star ["b"] |.| ["a"] |.| star ["b"]

-- Todos strings sobre {a, b} com nenhum caracter adjacente repetido, isto é,
--  sem nenhum substring da forma aa ou bb.
t3 = star (["b"] |.| ["a"]) |+| star (["a"] |.| ["b"]) |+| (["a"] |+| ["b"] |+| eps)

-- Todos constantes numericas fracionarias sobre {0, . . . , 9} ∪ {.}.
t4 = star [[Data.Char.intToDigit n | n <-[0..9]]] |.| (["."] |+| eps) |.|
  star [[Data.Char.intToDigit n | n <-[0..9]]]

-- Todos identificadores para tipos em Haskell.
t5 = [['A'..'Z']] |.| star ([['A'..'Z']] |+| [['a'..'z']] |+|
  [['0'..'9']] |+| eps)

-- Identificadores validos em Java.
t6 = ([['A'..'Z']] |+| ["_"]) |.| ([['A'..'Z']] |+| ["_"] |+| [['a'..'z']])
