
module Cipher where

import Data.Char

data CharDirection = Up | Down

-- alphaBase should really be determined upper and lower case
alphaBase = ord 'a'

-- base function to shift chars either up or down depending on supplied function f
charShift :: CharDirection -> Int -> Char -> Char
charShift Up   n c = chr $ alphaBase + (mod ((+) ((ord c) - alphaBase) n) 26)
charShift Down n c = chr $ alphaBase + (mod ((-) ((ord c) - alphaBase) n) 26)

charShiftUp :: Int -> Char -> Char
charShiftUp n c = charShift Up n c

charShiftDown :: Int -> Char -> Char
charShiftDown n c = charShift Down n c

caesar :: Int -> String -> String
caesar _ []     = []
caesar n (x:xs) = charShiftUp n x : caesar n xs

unCaesar :: Int -> String -> String
unCaesar _ []     = []
unCaesar n (x:xs) = charShiftUp n x : unCaesar n xs
