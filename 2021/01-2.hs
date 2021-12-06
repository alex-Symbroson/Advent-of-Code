import Macros

main = do
    content <- readFile "01.txt"
    let nums = map s2i (lines content)
    let res = [nums !! (x-1) + nums !! (x-2) + nums !! (x-3) | x <- [3..length nums]]
    let res2 = [if res !! (x-1) > res !! (x-2) then 1 else 0 | x <- [2..length res]]
    print $ sum res2
