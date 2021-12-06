{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

import Data.List as L
import Data.Maybe
import Data.Map as M
import Text.Regex
import Macros

isHV v = v!!0 == v!!2 || v!!1 == v!!3
insPt (a,b) = M.insertWith (+) (a,b) 1

traceLine [a,b,c,d] pmap
    | peq (a,b) (c,d) = insPt (a,b) pmap
    | otherwise = traceLine [gto a c,gto b d,c,d] (insPt (a,b) pmap)

traceLines ls pmap = L.foldl (flip traceLine) pmap ls
cntIts m = sum $ L.map (\x -> if x>1 then 1 else 0) (M.elems m)

main = do
    content <- readFile "05.txt"
    let parsed = L.map (L.map s2i.fromJust.matchRegex (mkRegex "([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)")) (lines content)
    let filtered = parsed -- L.filter isHV parsed
    print $ cntIts $ traceLines filtered M.empty
