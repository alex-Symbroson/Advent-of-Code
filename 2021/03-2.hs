import Data.Char
import Macros

cntBit s
    | s == '0' = -1
    | s == '1' = 1
    | otherwise = 0

mcb i = foldr (\l -> (+) (cntBit $ l !! i)) 0
sign a | a >= 0 = 1 | otherwise = 0

fmcb 5 _ _ = []
fmcb i ls m = digitToInt (m !! sign (mcb i ls)) : fmcb (i+1) ls m

rating i _ [] = []
rating i _ [a] = [a]
rating i m ls = rating (i+1) m (filter (\l -> (m !! sign (mcb i ls)) == (l !! i)) ls)

main = do
    content <- readFile "03.txt"
    let parsed = lines content
    let a = readBin $ reverse $ head (rating 0 "01" parsed)
    let b = readBin $ reverse $ head (rating 0 "10" parsed)
    print $ a*b