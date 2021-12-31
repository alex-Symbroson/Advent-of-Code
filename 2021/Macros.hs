
module Macros (s2i, b2i, peq, gto, bnch, to2Tup, to3Tup, swap, cartProd, push, dbg, d, d2, mergeList, arrWrite, bin2int, int2bin, surrmap) where

import Debug.Trace
import Data.Char
import Criterion.Main -- cabal
import Numeric (showIntAtBase)

bnch foo arg = defaultMain [ bgroup "fib" [ bench "benchmark"  $ whnf foo arg ] ]

dbg x = trace (show x) x
d m x = trace (show m) x
d2 m x = trace (show (m,x)) x

swap (x,y) = (y,x)
to2Tup (x:y:_) = (x,y)
to3Tup (x:y:z:_) = (x,y,z)

s2i x = read x::Integer
b2i b = if b then 1 else 0

peq (a,b) (c,d) = a == c && b == d
gto a b = a + signum (b-a)

cartProd xs ys zs = [(x,y,z) | x <- xs, y <- ys, z <- zs]

bin2int = _bin2int.reverse
    where
        _bin2int = foldr step 0
        step x y = (+) (digitToInt x) ( (*) y 2 )

int2bin x = reverse.take 4.reverse $ '0':'0':'0':showIntAtBase 2 intToDigit x ""

surrmap c m =
    let m1 = map (const c) (head m) : m
    in map (\r -> c : push c r) (push (head m1) m1)

push a = foldr (:) [a]

arrWrite [] _ _= []
arrWrite (_:arr) 0 x = x:arr
arrWrite (v:arr) i x = v:arrWrite arr (i-1) x

mergeList op [] [] = []
mergeList op [] (n:ns) = n:mergeList op [] ns
mergeList op (m:ms) [] = m:mergeList op ms []
mergeList op (m:ms) (n:ns) = op m n:mergeList op ms ns
