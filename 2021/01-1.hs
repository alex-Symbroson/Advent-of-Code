import Macros

main = do
    content <- readFile "01.txt"
    let nums = map s2i (lines content)
    let res = [if nums !! (x-1) > nums !! (x-2) then 1 else 0 | x <- [2..length nums]]
    print(sum res)
