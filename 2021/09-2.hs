{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

import Data.Char (digitToInt)
import Data.Map (Map, (!), assocs, insert, insertWith, elems, empty)
import Data.List (sort)
import Macros (surrmap)

bcat _ _ 9 n mc me = (9, n, mc, me)
bcat 9 9 c n mc me = (n, n+1, insertWith (+) n 1 mc, me)
bcat 9 u c n mc me = (u, n, insertWith (+) u 1 mc, me)
bcat l 9 c n mc me = (l, n, insertWith (+) l 1 mc, me)
bcat l u c n mc me =
    if l == u then bcat l 9 c n mc me
    else (u, n, insertWith (+) u 1 mc, insert l u me)

basin [_,_] [_,_] n mc me = ([9], n, mc, me)
basin (_:u:urest) (l:cur:rest) n mc me =
    let (nc, nn, nmc, nme) = bcat l u cur n mc me
        (nrest, nnn, nnmc, nnme) = basin (u:urest) (nc:rest) nn nmc nme
    in (nc : nrest, nnn, nnmc, nnme)

basinrows [prev] n mc me = (mc, me)
basinrows (prev:cur:rest) n mc me =
    let (row, nn, nmc, nme) = basin prev cur n mc me
    in basinrows ((9:row):rest) nn nmc nme

applWhl mc me = if not $ hasrem2 mc me then mc
    else applWhl (applEq mc me) me
    where
        hasrem2 mc l = foldr (test2 mc) False l
        test2 mc = (||).(0<).(mc!).fst

        applEq mc [] = mc
        applEq mc ((k,v):rest) =
            let nmc = applEq mc rest
            in insert k 0 $ insertWith (+) v (nmc ! k) nmc

main = do
    content <- readFile "09.txt"
    let pmap = map (map digitToInt) $ lines content
    let (mc, me) = basinrows (surrmap 9 pmap) 10 empty empty
    print.product.take 3.reverse.sort.elems $
        applWhl mc (reverse (assocs me))

