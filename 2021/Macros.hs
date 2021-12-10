
module Macros (s2i, b2i, peq, gto, dbg, d, mergeList, arrWrite, readBin, surrmap) where

import Debug.Trace
import Data.Char

dbg x = trace (show x) x
d m x = trace ((show m)++" "++(show x)) x


s2i x = read x::Integer
b2i b = if b then 1 else 0

peq (a,b) (c,d) = a == c && b == d
gto a b = a + signum (b-a)

readBin (c:s) = digitToInt c + 2 * readBin s
readBin [] = 0

surrmap c m =
    let m1 = map (const c) (head m) : m
    in map (\r -> c : push c r) (push (head m1) m1)
    where push a = foldr (:) [a]

arrWrite [] _ _= []
arrWrite (_:arr) 0 x = x:arr
arrWrite (v:arr) i x = v:arrWrite arr (i-1) x

mergeList op [] [] = []
mergeList op [] (n:ns) = n:mergeList op [] ns
mergeList op (m:ms) [] = m:mergeList op ms []
mergeList op (m:ms) (n:ns) = op m n:mergeList op ms ns
