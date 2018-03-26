
module Cipher where

import Data.Char

-- alphaBase should really be determined upper and lower case
alphaBase = ord 'a'

-- base function to shift chars either up or down depending on supplied function f
charShift :: Int -> Char -> Char
charShift n c = chr $ alphaBase + (mod (((ord c) - alphaBase) + n) 26)

caesar :: Int -> String -> String
caesar _ []     = []
caesar n (x:xs) = charShift n x : caesar n xs

unCaesar :: Int -> String -> String
unCaesar _ []     = []
unCaesar n (x:xs) = charShift (negate n) x : unCaesar n xs
