{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.Foldable (Foldable(foldl'))
import Text.Regex
import Macros
import qualified Data.Set as S

-- data cube = [0,x,x,y,y,z,z]

un3tup (a,b,c) = [a,b,c]

parseLine l = mergeList (+) [0,1,0,1,0,1] $ (map s2i.drop 1.splitRegex (mkRegex "\\.\\.|..=")) l
parseLine2 l = b2i (l!!1=='n') : parseLine l

isLineIts a b c d = not $ d<=a || c>=b
isLineOvr a b c d = c<=a && d>=b

itsLine a b c d
    | c>=a && d<=b = [[a,c],[c,d],[d,b]] -- 2cut
    | c>=a = [[a,c],[c,b]] -- 1cut
    | d<=b = [[a,d],[d,b]]
    | otherwise = [[a,b]]

isCubeIts [xa,xb,ya,yb,za,zb] [xc,xd,yc,yd,zc,zd] =
    isLineIts xa xb xc xd &&
    isLineIts ya yb yc yd &&
    isLineIts za zb zc zd

isCubeOvr [xa,xb,ya,yb,za,zb] [xc,xd,yc,yd,zc,zd] =
    isLineOvr xa xb xc xd &&
    isLineOvr ya yb yc yd &&
    isLineOvr za zb zc zd

filtProd [xc,xd,yc,yd,zc,zd] ([xa,xb],[ya,yb],[za,zb]) = not $
    isCubeOvr [xa,xb,ya,yb,za,zb] [xc,xd,yc,yd,zc,zd]

doItsCube [xa,xb,ya,yb,za,zb] [xc,xd,yc,yd,zc,zd] =
    let xs = itsLine xa xb xc xd
        ys = itsLine ya yb yc yd
        zs = itsLine za zb zc zd
    in map ((1:).concat.un3tup)
         $ filter (filtProd [xc,xd,yc,yd,zc,zd])
         $ cartProd xs ys zs

itsCube (m:a) (n:b)
    | isCubeOvr a b = []
    | not $ isCubeIts a b = [m:a]
    | otherwise = doItsCube a b

insertCube cubes (n:cube) =
    (if n==1 then ((n:cube):) else id) $ 
        concatMap (`itsCube` (n:cube)) cubes

cubeSizeSum :: [[Integer]] -> Integer
cubeSizeSum = foldr ((+).cubeSize) 0
    where cubeSize [m,xa,xb,ya,yb,za,zb] = (xb-xa)*(yb-ya)*(zb-za)

main = do
    content <- readFile "22.txt"
    let res = map parseLine2 (lines content)
    let cut = foldl' insertCube [] res
    print $ cubeSizeSum cut
