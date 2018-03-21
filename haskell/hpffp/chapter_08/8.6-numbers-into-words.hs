module WordNumber where

import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n
  | n == 0    = "oh"
  | n == 1    = "one"
  | n == 2    = "two"
  | n == 3    = "three"
  | n == 4    = "four"
  | n == 5    = "five"
  | n == 6    = "six"
  | n == 7    = "seven"
  | n == 8    = "eight"
  | n == 9    = "nine"
  | otherwise = "UNDEFINED"

digits :: Int -> [Int]
digits n = go n []
  where go n ns
         | n < 10    = n :[] ++ ns
         | otherwise = go (div n 10) ((mod n 10) :[] ++ ns)

wordNumber :: Int -> String
wordNumber n =
  concat $ intersperse "-" (map digitToWord (digits n))
