{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

import Data.Char
import Macros

data Tree a = Nil | Node a a [Tree a] | Leaf a a a
    deriving (Eq, Show, Read, Ord)

readLiteral s =
    let (r,t) = parseLiteral s in (bin2int r, t)
    where
        parseLiteral ('0':a:b:c:d:s) = (a:b:c:d:"", s)
        parseLiteral ('1':a:b:c:d:s) =
            let (r,t) = parseLiteral s in (a:b:c:d:r, t)

parseBody (_,_) "" = (Nil, "")
parseBody (v,4) s = let (r,t) = readLiteral s in (Leaf v 4 r, t)
parseBody (v,t) (i:s) =
    let (res, rem) = if i == '0'
        then (parse (take readLen dropLen), drop readLen dropLen)
        else parseNum readLen dropLen
    in (Node v t res, rem)
    where
        getLen = if i == '0' then 15 else 11
        readLen = bin2int (take getLen s)
        dropLen = drop getLen s

parseNum 0 s = ([], s)
parseNum n (a:b:c: d:e:f: s) =
    let (node, s2) = parseBody (bin2int [a,b,c], bin2int [d,e,f]) s
        (res, rem) = parseNum (n-1) s2
    in if node == Nil then ([], s) else (node : res, rem)

parse "" = []
parse (a:b:c: d:e:f: s) =
    let (node, s2) = parseBody (bin2int [a,b,c], bin2int [d,e,f]) s
    in if node == Nil then [] else node : parse s2

versum (Leaf a b c) = a
versum (Node a b c) = a + sum (map versum c)
versum Nil = error "nil node"

evaluate (Leaf v 4 n) = n
evaluate (Node v 0 l) = sum $ map evaluate l
evaluate (Node v 1 l) = product $ map evaluate l
evaluate (Node v 2 l) = minimum $ map evaluate l
evaluate (Node v 3 l) = maximum $ map evaluate l
evaluate (Node v 5 [l, r]) = b2i $ evaluate l > evaluate r
evaluate (Node v 6 [l, r]) = b2i $ evaluate l < evaluate r
evaluate (Node v 7 [l, r]) = b2i $ evaluate l == evaluate r
evaluate (Leaf _ x _) = error ("invalid literal " ++ show x)
evaluate (Node _ x _) = error ("invalid opcode " ++ show x)
evaluate Nil = error "nil node"

main = do
    content <- readFile "16.txt"
    --print $ map (map (i2b.digitToInt)) (lines content)
    let res = map (parse.concatMap (int2bin.digitToInt)) (lines content)
    --print res
    print $ map (versum.head) res
    print $ map (evaluate.head) res

