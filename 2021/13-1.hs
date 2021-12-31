
import Macros
import Data.List.Split (splitOn)
import Data.Set (fromList)
import Data.List (sort)

foldY fy (x, y) = (x, if y > fy then 2*fy-y else y)
foldX fx (x, y) = (if x > fx then 2*fx-x else x, y)

main = do
    content <- readFile "13.txt"
    let [pts, fds] = splitOn "\n\n" content
    let points = map (to2Tup.map s2i . splitOn ",") (lines pts)
    let folds = drop 11.head.lines $ fds
    let foldop = if head folds == 'x' then foldX else foldY
    print.length.fromList $ map (foldop.s2i.drop 2 $ folds) points
