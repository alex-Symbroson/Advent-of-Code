
import Data.Map ((!), empty, insert, keys, Map)
import Data.List (foldr)
import Data.Char (digitToInt)
import Astar (astarSearch)
import Data.Maybe (fromJust)
--import Text.Printf (printf)

parse _ _ [] = empty
parse x y ([]:lines) = parse 0 (y+1) lines
parse x y ((c:line):lines) = insert (y,x) (digitToInt c) $ parse (x+1) y (line:lines)

insert5 0 0 w h (y,x) m = m
insert5 ox oy w h (y,x) m = insert (y+oy*h,x+ox*w) (1+mod ((m!(y,x))+ox+oy-1) 9) m

main = do
    content <- readFile "15.txt"
    let m = parse 0 0 $ lines content
    let (h,w) = maximum $ keys m
    
    let m2 = foldr (\oy m2 -> foldr (\ox m3 -> foldr (insert5 ox oy (w+1) (h+1)) m3 (keys m)) m2 [0..4]) m [0..4]
    let (h2,w2) = maximum $ keys m2
    --printf $ map (\k -> intToDigit (m2 ! k)) (keys m2)

    let (cost, path) = fromJust $ astarSearch (0,0) (==(h2,w2)) (getNext m2 w2 h2) (\(y,x)->(h2-y)+(w2-x))
    print cost
    where
        getNext m w h (y,x) = map (cost m) $ filter (not.isWall w h) (nbrs (y,x))
        nbrs (y,x) = [(y,x-1), (y,x+1), (y-1,x), (y+1,x)]
        isWall w h (y,x) = x<0||y<0||x>w||y>h
        cost m a = (a, m!a)
