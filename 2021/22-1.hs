{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.Foldable (Foldable(foldl'))
import Text.Regex
import Macros
import qualified Data.Set as S

parseLine l = b2i (l!!1=='n') : (map s2i.drop 1.splitRegex (mkRegex "\\.\\.|..=")) l

parse ms l = foldl' (flip (if head l == 1 then S.insert else S.delete)) (d (length ms) ms) $ 
    [(x,y,z) | x <- [l!!1..l!!2], y <- [l!!3..l!!4], z <- [l!!5..l!!6]]

main = do
    content <- readFile "22.txt"
    let res = (map parseLine.lines) content
    print $ length $ foldl' parse S.empty (filter ((50>=).abs.(!!1)) (map parseLine (lines content)))