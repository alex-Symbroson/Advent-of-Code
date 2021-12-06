import Data.List
import Data.List.Split
import Data.Maybe
import Macros

bingo [] _ _ lastRes = lastRes
bingo (n:ns) boards marked lastRes = do
    let (nbs, nms) = markBoards n boards marked
    if isJust (won nms)
    then bingo ns nbs nms (nbs !! fromJust (won nms), n)
    else bingo ns nbs nms lastRes
    where won = findIndex $ elem 5

markBoards n [] [] = ([], [])
markBoards n a [] = error "well"
markBoards n [] b = error "welll"
markBoards n (b:bs) (m:ms) = do
    let (nb, nm) = getMarks n b
    let (nbs, nms) = markBoards n bs ms
    if won m then (nbs, nms) else (nb:nbs, mergeList (+) m nm:nms)
    where won = elem 5 -- True

getMarks n board = do
    let i = elemIndex n board
    case i of
        Nothing -> (board, makeBoard 5)
        _ -> (arrWrite board (fromJust i) (-1), makeMarks $ fromJust i)

makeMarks i = map (\x -> b2i $ x == div i 5 * 2 || x == (mod i 5*2+1)) (makeIndexBoard 5)
makeBoard n = map (const 0) (makeIndexBoard n)
makeIndexBoard n = [0..2*n-1]

points (b,n) = (*n).sum $ filter (>= 0) b

main = do
    content <- readFile "04.txt"
    let parsed = splitOn "\n\n" content
    let numbers = map s2i $ splitOn "," $ head parsed
    let boards = map (map s2i.words) (tail parsed)
    let marked = map (\_ -> makeBoard 5) boards

    print $ points $ bingo numbers boards marked ([],0)
