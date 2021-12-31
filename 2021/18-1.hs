{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.Char (digitToInt)
import Macros

data SFN a = Nil | Leaf a | Node (SFN a) (SFN a) deriving (Show,Eq)

parseNode ('[':s) =
    let (l,rem) = parseNode s
        (r,rem2) = parseNode rem
    in if r == Nil then (l,"") else (Node l r, rem2)
parseNode (',':d:']':s) = (Leaf (digitToInt d), s)
parseNode (d:',':s) =
    let (res,rem) = parseNode s
    in (Node (Leaf (digitToInt d)) res, rem)
parseNode (d:']':s) = (Leaf (digitToInt d), s)
parseNode "" = (Nil, "")

step (Node (Node (Node (Node (Node a b) c) d) e) f)
    = 0

main = do
    let content = "[[[[[9,8],1],2],3],4]"
    let arr = parseNode content
    print arr