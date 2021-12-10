{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Macros
import Data.Char
-- import Text.Printf

islow u l m r b =
    if u > m && l > m && r > m && b > m
    then 1 + digitToInt m else 0

lowpoints [_, p2] [q1, q2] [_, r2] = []
lowpoints (_:p2:prest) (q1:q2:q3:qrest) (_:r2:rrest) =
    islow p2 q1 q2 q3 r2 : lowpoints (p2:prest) (q2:q3:qrest) (r2:rrest)

lowpointrows [prev, cur] = []
lowpointrows (prev:cur:next:rest) =
    lowpoints prev cur next : lowpointrows (cur:next:rest)

main = do
    content <- readFile "09.txt"
    let pmap = lines content
    print.sum.concat.lowpointrows $ surrmap '9' pmap
    -- printf $ unlines $ pmap
