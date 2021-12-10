{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.List (elemIndex, sort)
import Data.Maybe (fromJust)

open = "([{<"; close = ")]}>"; points = [1, 2, 3, 4]
fromIdx k l i = k !! fromJust (elemIndex i l)

parse [] ls = reverse (init ls)
parse (c:cs) (l:last)
  | c `elem` open = parse cs (fromIdx close open c : l : last)
  | c == l = parse cs last
  | otherwise = ""

getPoints [] = 0
getPoints (l : ls) = fromIdx points close l + 5 * getPoints ls

main = do
    content <- readFile "10.txt"
    let res = sort $ filter (>0) (map (getPoints.(`parse` " ")) (lines content))
    print $ res !! div (length res) 2
