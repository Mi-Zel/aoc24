import Data.List

distance:: [[Int]] -> Int
distance [one,two] = sum (map (\(x,y) -> abs(x-y)) (zip (sort one) (sort two)))

similarity:: [[Int]] -> Int
similarity [one,two] = sum (map (\x -> x * foldl (\count y -> if x == y then count + 1 else count) 0 two) one)



split :: [String] -> ([Int], [Int])
split input = foldl (\(one, two) string -> 
    let line = words string 
        first = read (line!!0) :: Int
        second = read (line!!1) :: Int
    in (first:one, second:two)) ([], []) input

main :: IO ()
main = do 
    file <- readFile "input.txt"
    let input = lines file
    let (one, two) = split input 
    -- print input
    -- print one
    -- print two
    print (distance ([one, two]))
    print (similarity ([one, two]))
