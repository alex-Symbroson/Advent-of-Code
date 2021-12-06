
import Data.List as L
import Data.Set as S
import Data.Maybe
import Text.Regex
import Control.Parallel
import Macros

isHV v = v!!0 == v!!2 || v!!1 == v!!3

isOn (a,b,c,d) (x,y)
    | peq (a,b) (x,y) = True
    | peq (a,b) (c,d) = False
    | otherwise = isOn (gto a c, gto b d, c, d) (x, y)

toLine [a,b,c,d] = (a,b,c,d)

cntOn (a,b,c,d) (p,q,r,s)
    | peq (p,q) (r,s) = if isOn (a,b,c,d) (p,q) then [(p,q)] else []
    | otherwise = if isOn (a,b,c,d) (p,q) then (p,q) : doRest else doRest
    where doRest = cntOn (a,b,c,d) (gto p r, gto q s, r, s)

cntEach _ [] = []
cntEach line tails =
    (cntOn (toLine line) (toLine (head tails))) ++ (cntEach line (tail tails))

cntEachOn [] _ = []
cntEachOn _ [] = []
cntEachOn heads tails =
    dopar `par` nextpar `pseq` dopar++nextpar
    where
        dopar = cntEach (dbg $ head heads) tails
        nextpar = cntEachOn (tail heads) (tail tails)

main = do
    content <- readFile "05.txt"
    let parsed = L.map (L.map s2i.fromJust.matchRegex (mkRegex "([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)")) (lines content)
    let filtered = parsed -- L.filter isHV parsed
    print $ length $ S.fromList $ cntEachOn filtered (tail filtered)

-- < 5072
-- > 16793