import Macros

parse [a, n] = (a, s2i n)
result (x, y, _) = (x, y, x * y)

move (x, y, aim) (act, n)
    | act == "forward" = (x + n, y + n * aim, aim)
    | act == "down" = (x, y, aim + n)
    | act == "up" = (x, y, aim - n)
    | otherwise = (x, y, aim)

main = do
    content <- readFile "02.txt"
    let parsed = map (parse.words) (lines content)
    print $ result $ foldl move (0, 0, 0) parsed
