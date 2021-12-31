
import Macros
import Data.List.Split (splitOn)
import qualified Data.Set as S (fromList, toList)
import Data.List (sort)
import Text.Printf (printf)

foldY fy (x, y) = (x, if y > fy then 2*fy-y else y)
foldX fx (x, y) = (if x > fx then 2*fx-x else x, y)

mfold [] p = p
mfold (('x':_:n):rest) p = mfold rest $ foldX (s2i n) p
mfold (('y':_:n):rest) p = mfold rest $ foldY (s2i n) p

putfd [] _ _ = "\n"
putfd rest 40 cy = '\n':putfd rest 0 (cy+1)
putfd ((y,x):rest) cx cy
    | cy == y && cx == x = '#':putfd rest (cx+1) cy
    | otherwise = ' ':putfd ((y,x):rest) (cx+1) cy

part1 points folds =
    print.length.S.fromList $ map (mfold [head folds]) points

part2 points folds = do
    let folded = sort.S.toList.S.fromList $ map (swap.mfold folds) points
    printf $ putfd folded 0 0

main = do
    content <- readFile "13.txt"
    let [pts, fds] = splitOn "\n\n" content
    let points = map (to2Tup.map s2i . splitOn ",") (lines pts)
    part1 points (map (drop 11) (lines fds))
    part2 points (map (drop 11) (lines fds))
