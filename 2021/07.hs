import Data.List as L
import Data.List.Split
import Macros

cost1 x = x
cost2 x = div (x*x+x) 2

calc x m = sum $ map (\v -> cost2 $ abs (x-v)) m

test x smax subs
    | x <= smax = calc x subs : test (x+1) smax subs
    | otherwise = []

main = do
    content <- readFile "07.txt"
    let subs = L.map s2i $ splitOn "," content
    print $ minimum $ test (minimum subs) (maximum subs) subs
