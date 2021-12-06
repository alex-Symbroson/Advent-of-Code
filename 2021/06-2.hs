import Data.Map as M
import Data.List as L
import Data.List.Split
import Data.Maybe
import Macros

gener mfish = do
    let n = fromMaybe 0 $ M.lookup 0 mfish
    let m1 = M.insertWith (+) 7 n mfish
    M.insert 0 0 $ M.insertWith (+) 9 n m1

cntFish fish m = L.foldl (\ m f -> M.insertWith (+) f 1 m) m fish
doevo = M.mapKeys (\k -> k-1)

evo 0 fish = fish
evo n fish = evo (n-1) $ doevo $ gener fish

main = do
    content <- readFile "05.txt"
    let fish = L.map s2i $ splitOn "," content
    let mfish = cntFish fish M.empty
    print $ sum $ M.elems $ evo 256 mfish