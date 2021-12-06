import Macros

parse [a, n] = (a, s2i n)
result (x, y) = (x, y, x * y)

move (x, y) (act, n)
    | act == "forward" = (x + n, y)
    | act == "down" = (x, y + n)
    | act == "up" = (x, y - n)
    | otherwise = (x, y)

main = do
    content <- readFile "02.txt"
    let parsed = map (parse.words) (lines content)
    print $ foldl move (0, 0) parsed
