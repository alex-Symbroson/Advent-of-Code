import qualified Data.Map as M

(#+) (a,b) (c,d) = (a+c,b+d)
(.*) f (a,b) = (f*a,f*b)

part1 (a,b) (s,t) n
    | s >= 1000 = n*t-t
    | t >= 1000 = n*s-s
    | otherwise =
        let p = mod n 100 + mod (n+1) 100 + mod (n+2) 100
            (c,d) = (mod (a-1+p*mod n 2) 10+1, mod (b-1+p*(1-mod n 2)) 10+1)
            (u,v) = (s+c*mod n 2, t+d*(1-mod n 2))
        in part1 (c,d) (u,v) (n+3)

part2 (a,b) (s,t) n
    | s >= 21 = (1,0)
    | t >= 21 = (0,1)
    | otherwise = dice 3 #+ 
        (3.*dice 4) #+ (6.*dice 5) #+ (7.*dice 6) #+
        (6.*dice 7) #+ (3.*dice 8) #+ dice 9
    where dice p = let
            (c,d) = (mod (a-1+p*n) 10+1, mod (b-1+p*(1-n)) 10+1)
            (u,v) = (c*n, t+d*(1-n))
            in part2 (c,d) (u,v) (1-n)

-- (113467910521040,116741133558209)
main = do
    print $ part1 (8,1) (0,0) 1
    print $ part2 (8,1) (0,0) 1