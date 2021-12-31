
import Macros
import Data.List.Split (splitOn)
import qualified Data.Set as S (fromList, toList)
import qualified Data.Map as M
import Data.List (sort)
import Text.Printf (printf)

replPoly m "" = ""
replPoly m [c] = c:""
replPoly m (a:b:rest) = (a:(m M.! (a:b:""))) ++ replPoly m (b:rest)

insPoly 0 _ poly = poly
insPoly n m poly = insPoly (n-1) m $ replPoly m poly

main = do
    content <- readFile "14.txt"
    let (poly:_:ins) = splitOn "\n" content
    let m = M.fromList $ map (to2Tup.splitOn " -> ") ins
    --print m

    let res = insPoly 10 m poly
    let cnt = M.fromListWith (+) (zip res (repeat 1))
    let (min, max) = (minimum $ M.elems cnt, maximum $ M.elems cnt)
    print $ max - min
    --part1 points (map (drop 11) (lines fds))
    --part2 points (map (drop 11) (lines fds))
