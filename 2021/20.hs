
import Data.Map as M (empty,insert,Map,lookup,elems,keys)
import Data.List
import Data.Char
import Macros
import Data.Maybe

parse _ _ [] = empty
parse x y ([]:lines) = parse 0 (y+1) lines
parse x y ((c:line):lines) = M.insert (y,x) (b2i$'#'==c) $ parse (x+1) y (line:lines)

get9 x y map = reverse.concat $ 
    foldl' (\s dy -> getLine dy:s) [] [-1..1]
    where
        getc dx dy = intToDigit $ fromMaybe 0 (M.lookup (y+dy,x+dx) map)
        getLine dy = foldl' (\t dx -> getc dx dy:t) "" [-1..1]

gen (x1,y1,x2,y2) alg map =
    foldl' (\m dy -> foldl' (getCell dy) m [x1..x2]) empty [y1..y2]
    where
        getIdx x y = bin2int (get9 x y map)
        getCell dy m dx = M.insert (dy,dx) (b2i ('#' == (alg !! getIdx dx dy))) m

gens alg (x1,y1,x2,y2) n m =
    foldl' dogen m (reverse [n..2*n-1])
    where dogen m n = gen (x1-n-1, y1-n-1, x2+n+1, y2+n+1) alg m

main = do
    content <- readFile "20.txt"
    let (alg:_:lmap) = lines content
    print.sum $ gens alg (0,0,100,100) 50 $ parse 0 0 lmap
    --print $ foldr (\c s -> (if c==1 then '#' else '.'):s) "" (M.elems map)
    --print.maximum $ M.keys map
    --print.minimum $ M.keys map
