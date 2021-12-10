import Data.List.Split
import Macros

count1478 = map $ b2i.(`elem` [2,4,3,7]).length

main = do
    content <- readFile "08.txt"
    let pats = concatMap (words.last.splitOn " | ") (lines content)
    print.sum $ count1478 pats
