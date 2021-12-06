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

main = do
    content <- readFile "03.txt"
    let parsed = lines content
    let a = readBin $ reverse (fmcb 0 parsed "01")
    let b = readBin $ reverse (fmcb 0 parsed "10")
    print $ a*b

