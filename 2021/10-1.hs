{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.List (elemIndex)
import Data.Maybe (fromJust)

parse [] _ = 0
parse (c:cs) (l:last) =
    let open = "([{<"; close = ")]}>"; points = [3,57,1197,25137]
    in if c `elem` open
        then parse cs ((close !! fromJust (elemIndex c open)):l:last)
        else if c == l then parse cs last else points !! fromJust (elemIndex c close)

main = do
    content <- readFile "10.txt"
    print $ sum (map (`parse` " ") (lines content))
