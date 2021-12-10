import Data.List.Split
import Macros

gener [] = []
gener (f:fish) = if f == 0 then 7:9:gener fish else f:gener fish

doevo = map (\x->x-1)

evo 0 fish = fish
evo n fish = evo (n-1) $ doevo $ gener fish

main = do
    content <- readFile "06.txt"
    let fish = map s2i $ splitOn "," content
    print $ length $ evo 50 fish
