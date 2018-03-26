
module Cipher where

import Data.Char

-- alphaBase should really be determined upper and lower case
alphaBase = ord 'a'

-- base function to shift chars either up or down depending on supplied function f
charShift :: Int -> Char -> Char
charShift n c
  | isUpper c = chr $ (ord 'A') + (mod (((ord c) - (ord 'A')) + n) 26)
  | otherwise = chr $ (ord 'a') + (mod (((ord c) - (ord 'a')) + n) 26)

caesar :: Int -> String -> String
caesar _ []     = []
caesar n (x:xs) = charShift n x : caesar n xs

unCaesar :: Int -> String -> String
unCaesar _ []     = []
unCaesar n (x:xs) = charShift (negate n) x : unCaesar n xs
