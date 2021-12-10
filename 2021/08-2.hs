{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.List.Split
import Data.List as L
import Data.List (findIndex)
import Data.Maybe (fromJust)

mapnums [] _ = []
mapnums (x:xs) ns = fromJust (elemIndex x ns) : mapnums xs ns

fromDigits [] = 0
fromDigits (v:ds) = v+10*fromDigits ds

getnum [] = []
getnum ([x,n]:l) = do
    let l0 = L.sortBy (\a b -> compare (length a) (length b)) x
    -- 1478 : [2,4,3,7] 5,6
    let [v1, v4, v7, v8] = [l0!!0, l0!!2, l0!!1, l0!!9]
    -- match 4
    let ul = l0 L.\\ [v1, v4, v7, v8]
    let [v2, v9] = match (map (L.intersect v4) ul) ul [2, 4]
    -- match 2
    let ul0356 = ul L.\\ [v2, v9]
    let [v5] = match (map (L.intersect v2) ul0356) ul0356 [3]
    -- length 5
    let ul036 = ul0356 L.\\ [v5]
    let v3 = ul036 !! lenidx ul036 5
    -- match 1
    let ul06 = ul036 L.\\ [v3]
    let [v0, v6] = match (map (L.intersect v1) ul06) ul06 [2,1]
    -- concat
    let nums = [v0, v1, v2, v3, v4, v5, v6, v7, v8, v9]
    reverse (mapnums (map sort n) (map sort nums)) : getnum l
    where 
        match src tgt = map ((tgt !!).lenidx src)
        lenidx l n = fromJust $ L.findIndex (\s -> length s == n) l

main = do
    content <- readFile "08.txt"
    let pats = map (map words.splitOn " | ") $ lines content
    print $ sum $ map fromDigits $ getnum pats
