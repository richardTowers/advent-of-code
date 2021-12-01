import System.IO

main = do
  input <- readFile "input.txt"
  let ints = map read . words $ input :: [Integer]

  let part1 = sum $ map fromEnum $ zipWith (<) ints $ tail ints
  putStrLn $ "Part 1: " ++ show part1

  let sum3 a b c = a + b + c
  let windows = zipWith3 sum3 (ints) (tail ints) (drop 2 ints)
  let part2 = sum $ map fromEnum $ zipWith (<) windows $ tail windows
  putStrLn $ "Part 2: " ++ show part2
