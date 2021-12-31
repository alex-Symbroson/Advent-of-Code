{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

import Macros
import Data.List.Split (splitOn)
import Data.List
import Data.Map ((!), empty, insertWith, fromList, toList, elems, Map)
import qualified Data.Functor as IO

mkPairs [c] = empty
mkPairs (a:b:rest) = insertWith (+) [a,b] 1 (mkPairs (b:rest))

replPoly m = foldr myins empty
    where myins (p,n) t = insertWith (+) (p!!0:m!p) n (insertWith (+) (m!p ++ [p!!1]) n t)

docount = foldr myins empty
    where myins (p,n) m = insertWith (+) (p!!0) n (insertWith (+) (p!!1) n m)

insPoly 0 _ pairs = pairs
insPoly n m pairs = insPoly (n-1) m $ replPoly m (toList pairs)

insPoly2 n m pairs = foldl' (\p x -> replPoly m (toList p)) empty [1..n]

foo content = do
    let (poly:_:ins) = splitOn "\n" content
    let m = fromList $ map (to2Tup.splitOn " -> ") ins
    let cnt = docount.toList.insPoly 40 m $ mkPairs poly
    let (min, max) = (minimum $ elems cnt, maximum $ elems cnt)
    (div max 2 + mod max 2) - (div min 2 + mod min 2)

main = do
    content <- readFile "14.txt"
    bnch foo content
