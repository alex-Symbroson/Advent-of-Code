
import Data.Map ((!), empty, insert, keys, elems, Map)
import qualified Data.List as L
import Data.Char (digitToInt)
import Data.Maybe (fromJust)
import Algorithm.Search (aStar, pruning)

parse _ _ [] = empty
parse x y ([]:lines) = parse 0 (y+1) lines
parse x y ((c:line):lines) = insert (y,x) (digitToInt c) $ parse (x+1) y (line:lines)

main = do
    content <- readFile "15.txt"
    let m = parse 0 0 $ lines content
    let (h,w) = maximum $ keys m
    let (cost, path) = fromJust $ aStar (getNext w h) (mcost m) (dist (h,w)) (==(h,w)) (0,0)
    print cost
    where
        mcost m a b = m!b
        dist (a,b) (c,d) = abs(a-c)+abs(b-d)
        getNext w h = nbrs `pruning` isWall w h
        nbrs (y,x) = [(y,x-1), (y,x+1), (y-1,x), (y+1,x)]
        isWall w h (y,x) = x<0||y<0||x>w||y>h