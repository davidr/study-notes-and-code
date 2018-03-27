- [9.1 Lists](#org9cc5551)
- [9.2 The list datatype](#org145bfb1)
- [9.3 Pattern matching on lists](#org603755a)
- [9.4 List's syntactic sugar](#org3a37119)
- [9.5 Using ranges to construct lists](#orgb17b6ad)
- [9.6 Extracting portions of lists](#orgc7916b9)
- [9.7 List comprehensions](#orgc93c753)
- [9.8 Spines and nonstrict evaluation](#org676de12)
- [9.9 Transforming lists of values](#org2567afc)
- [9.10 Filtering lists of values](#orgc83ea5f)
- [9.11 Zipping lists](#orgd28b0e9)
- [9.12 Chapter Exercises](#org8330dc7)



<a id="org9cc5551"></a>

# 9.1 Lists


<a id="org145bfb1"></a>

# 9.2 The list datatype

The list datatype is defined like: `data [] a = [] | a : [a]`. Sum datatypes haven't been introduced yet.


<a id="org603755a"></a>

# 9.3 Pattern matching on lists

Naive pattern matching on lists doesn't take into account an empty list, so Maybe is needed:

```haskell
safeTail         :: [a] -> Maybe [a]
safeTail []      = Nothing
safeTail (x:[])  = Nothing
safeTail (_:xs)  = Just xs
```


<a id="org3a37119"></a>

# 9.4 List's syntactic sugar

Note that

```haskell
[1, 2, 3] ++ [4]
```

is identical to

```haskell
(1 : 2 : 3 : []) ++ 4 : []
```

When talking of lists, some terms:


## "cons cells"

cons cells are the list datatype's second constructor, `a : [a]`, the result of recursively prepending a value to "more list". The cons cell is a conceptual space that values may inhabit.


## spine

spine is the connective structure that holds the cons cells together and in place


<a id="orgb17b6ad"></a>

# 9.5 Using ranges to construct lists

```haskell
[1,3..10]

-- is the same as

enumFromThenTo 1 3 10
```

for all instances of the Enum typeclass


## Exercise: EnumFromTo

I think I probably misunderstood what this question was asking for. They wanted functions for all four types, Bool, Ordering, Int, Char, but they're all instances of the Enum and Eq typeclasses, so the eftEnumEq function seems to do what I think they're asking for, but then I don't understand why they asked for all four. I assume I misunderstood.

```haskell
eftEnumEq :: (Enum a, Eq a) => a -> a -> [a]
eftEnumEq start stop = go start stop []
  where go curr stop retlist
	 | curr == stop  = retlist ++ [curr]
	 | otherwise     = go (succ curr) stop (retlist ++ [curr])

eftBool :: Bool -> Bool -> [Bool]
eftBool  = eftEnumEq

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd  = eftEnumEq

eftInt :: Int -> Int -> [Int]
eftInt =  eftEnumEq

eftChar :: Char -> Char -> [Char]
eftChar  = eftEnumEq
```


<a id="orgc7916b9"></a>

# 9.6 Extracting portions of lists

`take n a` returns the first n elements of List a as a list

`drop n a` returns the last (length a) - n elements of List a as a list (i.e. drops the first n elements and returns the remaining ones)

`splitat n a` returns two-tuple of lists from list a, split at the nth position

takeWhile and dropWhile do similar things, but as higher-order functions with `a -> Bool` "selection" functions as arguments:

    Prelude> takeWhile (=='a') [a..z]
    "a"


## Exercises: Thy Fearful Symmetry


### 1.

My solution seems needlessly complicated. There's probably a solution that involves not having to use both dropWhile and takeWhile in the same go statement

```haskell
myWords :: [Char] -> [[Char]]
myWords sentence = go sentence []
  where go sentence retwords
	 | length sentence > 0 = go (drop 1 $ dropWhile (/=' ') sentence)
				    (retwords ++ [takeWhile (/=' ') sentence])
	 | otherwise           = retwords
```


### 2.

```haskell
module PoemLines where

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful\
	    \ symmetry?"
sentences = firstSen ++ secondSen
	 ++ thirdSen ++ fourthSen

-- putStrLn sentences -- should print
-- Tyger Tyger, burning bright
-- In the forests of the night
-- What immortal hand or eye
-- Could frame thy fearful symmetry?


-- Implement this
myLines :: String -> [String]
myLines longstring = go longstring []
  where go longstring lines
	 | length longstring > 0 = go (drop 1 $ dropWhile (/='\n') longstring)
				      (lines ++ [takeWhile (/='\n') longstring])
	 | otherwise             = lines

-- What we want 'myLines sentences' to equal
shouldEqual =
  [ "Tyger Tyger, burning bright"
  , "In the forests of the night"
  , "What immortal hand or eye"
  , "Could frame thy fearful symmetry?"
  ]

-- The main function here is a small test to ensure you've written your function
-- correctly.
main :: IO ()
main =
  print $
  "Are they equal? "
  ++ show (myLines sentences
	   == shouldEqual)
```


### 3. Left as an exercise to the reader's reader.


<a id="orgc93c753"></a>

# 9.7 List comprehensions

    [ x^2 | x <- [1..10]]

or with predicates:

    [x^2 | x <- [1..10], rem x 2 == 0]

multiple generators:

    [x^y | x <- [1..5], y <- [2,3]]

multiple predicates!:

    [x^y |
     x <- [1..5],
     y <- [2, 3],
     x^y < 200]

it can zip up multiple generators of different lengths and types into tuples:

    Prelude> :{
    Prelude| [(x, y) |
    Prelude| x <- [1, 2, 3],
    Prelude| y <- [6, 7]]
    Prelude| :}
    [(1,6),(1,7),(2,6),(2,7),(3,6),(3,7)]


## Exercises: Comprehend Thy Lists

    -- let mySqr = [x^2 | x <- [1..10]]    == [1,4,9,16,25,36,49,64,81,100]
    
    [x | x <- mySqr, rem x 2 == 0] == [4,16,36,64,100]
    [(x, y) | x <- mySqr, y <- mySqr, x < 50, y > 50]
    ...


## Exercises: Square Cube

```haskell
mySqr  = [x^2 | x <- [1..5]]
myCube = [x^3 | x <- [1..5]]

myTuples = [(x, y) | x <- mySqr, y <- myCube]

myTuplesLtFifty = [(x, y) | x <- mySqr, y <- myCube, x < 50 && y < 50]
```


<a id="org676de12"></a>

# 9.8 Spines and nonstrict evaluation


## Exercises: Bottom Madness


### 1. `[x^y | x <- [1..5], y <- [2, undefined]]`

will bottom, as x<sup>undefined</sup> is evaluated


### 2. `take 1 $ [x^y | x <- [1..5], y <- [2, undefined]]`

will return `[1]`, because only the first cons cell is evaluated, which is 1<sup>2</sup>=1


### 3. `sum [1, undefined, 3]`

will bottom since all the cons cells are evaluated in the summation


### 4. `length [1, 2, undefined]`

will return 3 because only the spine is evaluated (is "evaluated" the right word?)


### 5. `length $ [1, 2, 3] ++ undefined`

will bottom, I think because you can't add an element to a list. adding [undefined] to this would make it work.


### 6. `take 1 $ filter even [1, 2, 3, undefined]`

will return `[2]` because the filter evaluation stops when the first even number, 2 is found


### 7. `take 1 $ filter even [1, 3, undefined]`

will bottom as all cons cells are evaluated trying to find the not present even value


### 8. `take 1 $ filter odd [1, 3, undefined]`

will return `[1]`. See (6) above


### 9. `take 2 $ filter odd [1, 3, undefined]`

will return `[1, 3]` for the same reason as (6) and (8) above


### 10. `take 3 $ filter odd [1, 3, undefined]`

will bottom. see (7) above


## Intermission: Is it in normal form?

Are the following in normal form (NF), weak head normal form (WHNF), or nothing


### 1. `[1, 2, 3, 4, 5]`

normal form


### 2. `1 : 2 : 3 : 4 : _`

whnf. the spine is fully evaluated, but the last cons cell is still unevaluated


### 3. `enumFromTo 1 10`

nothing. the outermost component of this expression is an unapplied function evaluation


### 4. `length [1, 2, 3, 4, 5]`

nothing. same as (3)


### 5. `sum (enumFromTo 1 10)`

nothing. same as (3) and (4)


### 6. `['a'..'m'] ++ ['n'..'z']`

nothing. same as (3), (4), and (5)


### 7 `(_, b)`

I think it's whnf, but @larrybotha thinks it's nf and he's smarter than me. TODO - look into this


<a id="org2567afc"></a>

# 9.9 Transforming lists of values


## Exercises: More Bottoms:


### 1

```haskell
take 1 $ map (+1) [undefined, 2, 3]
```

Will bottom because it will evaluate (+) 1 undefined


### 2

```haskell
take 1 $ map (+1) [1, undefined, 3]
```

Will return 2


### 3

```haskell
take 2 $ map (+1) [1, undefined, 3]
```

Will bottom, for the same reason as (1)


### 4

```haskell
itIsMystery xs =
  map (\x -> elem x "aeiou") xs
```

Maps a function that does a boolean check for whether an element of the list `xs` is in the list "aeiou" over xs. (returns [Bool])


### 5

-   a

    ```haskell
    map (^2) [1..10]
    ```

-   b

    ```haskell
    map minimum [[1..10], [10..20], [20..30]]
    ```

-   c

    ```haskell
    map sum [[1..5], [1..5], [1..5]]
    ```


### 6

```haskell
-- the bool funciton lives in Data.Bool
import Data.Bool

map (\x -> bool x (-x) (x == 3)) [1..10]
```


<a id="orgc83ea5f"></a>

# 9.10 Filtering lists of values

note filter's definition:

```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter pred (x:xs)
  | pred x = x : filter pred xs
  | otherwise = filter pred xs
```

```haskell
filter (== 'a') "abracadabra"
```

```haskell
filter (\x -> (rem x 2) == 0) [1..20]
```

*note*: I wonder why they use `rem x 2 == 0` so consistently in this book as opposed to `mod x 2 == 0` which I feel like is more common. Is rem more efficient? That seems unlikely.


## Exercises: filtering


### 1

give all multiples of 3 out of a list from 1 to 30:

```haskell
filter (\x -> (mod x 3) == 0) [1..30]
```


### 2

how many multiples of three are there in (1) above? answer using (.)

```haskell
length . filter (\x -> (mod x 3) == 0) $ [1..30]
```


### 3

remove all articles from sentences

```haskell
-- start with a list of articles we can check words against
let articles = ["the", "a", "an"]

filter (\x -> not (elem x articles)) $ words "the brown dog was a goof"
```


<a id="orgd28b0e9"></a>

# 9.11 Zipping lists

Note: zip always ends with the exhaustion of the shorter list

`zip :: [a] -> [b] -> [(a, b)]`

`zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]`

zipWith examples:

```haskell
zipWith (+) [1, 2, 3] [10, 11, 12]
```

```haskell
zipWith (==) ['a'..'f'] ['a'..'z']
```


## Zipping exercises


### 1

Write your own version of zip

```haskell
myZip :: [a] -> [b] -> [(a, b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys
```


### 2

same with zipWith

```haskell
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ _      []     = []
myZipWith _ []     _      = []
myZipWith f (x:xs) (y:ys) = (f x y) : myZipWith f xs ys
myZipWith (+) [1..3] [11..13]
```


### 3

rewrite myZip with myZipWith

```haskell
someNums = [1..10]
someLetts = ['a'..'d']

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ _      []     = []
myZipWith _ []     _      = []
myZipWith f (x:xs) (y:ys) = (f x y) : myZipWith f xs ys

myZip :: [a] -> [b] -> [(a, b)]
myZip xs ys = myZipWith (,) xs ys

myZip someNums someLetts
```


<a id="org8330dc7"></a>

# 9.12 Chapter Exercises


## Data.Char


### 1

```haskell
import Data.Char
:t isUpper
```

```haskell
import Data.Char
:t toUpper
```


### 2

use isUpper for a filter statement


### 3

```haskell
import Data.Char

capString :: String -> String
capString (x:xs) = toUpper x : xs

capString "julie"
```


### 4

make a recursive case of (3) above to change all letters to caps

```haskell
import Data.Char

capAllString :: String -> String
capAllString []     = []
capAllString (x:xs) = toUpper x : capAllString xs

capAllString "woot"
```


### 5

```haskell
:t head
```

Simple function:

```haskell
import Data.Char

capHead :: String -> Char
capHead s = toUpper (head s)

capHead "julie"
```


### 6

With function composition:

```haskell
import Data.Char

capHead :: String -> Char
capHead s = toUpper . head $ s

capHead "julie"
```

As pointfree:

```haskell
import Data.Char

capHead = toUpper . head

capHead "julie"
```


## Ciphers

Todo: this should handle caps

```haskell
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
```


## Writing your own standard functions

```haskell
import Data.Bool
```


### 1. myOr

```haskell
myOr :: [Bool] -> Bool
myOr []     = False
myOr (x:xs) = x || myOr xs
```


### 2. myAny

```haskell
myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f xs = or (map f xs)
```


### 3. myElem

```haskell
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (y:ys)
  | x == y    = True
  | otherwise = myElem x ys
```

```haskell
myElem' :: Eq a => a -> [a] -> Bool
myElem' _ [] = False
myElem' x ys = any (== x) ys
```


### 4. myReverse

```haskell
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]
```


### 5. squish

```haskell
squish :: [[a]] -> [a]
squish []     = []
squish (x:xs) = x ++ squish xs
```

How the hell does that work? The "x" in (x:xs) reaches "into" the nested lists?


### 6. squishMap

```haskell
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f (x:xs) = f x ++ squishMap f xs
```


### 7 squishAgain

```haskell
squishAgain :: [[a]] -> [a]
squishAgain xs = squishMap id xs
```


### 8 myMaximumBy

```haskell
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ []         = error "empty list"
myMaximumBy _ (x0:[])    = x0
myMaximumBy f (x0:x1:[]) = bool x0 x1 (f x0 x1 == LT)
myMaximumBy f (x0:x1:xs)
  | f x0 x1 == GT = myMaximumBy f (x0:xs)
  | otherwise     = myMaximumBy f (x1:xs)
```


### 9 myMinimumBy

```haskell
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ []         = error "empty list"
myMinimumBy _ (x0:[])    = x0
myMinimumBy f (x0:x1:[]) = bool x0 x1 (f x0 x1 == GT)
myMinimumBy f (x0:x1:xs)
  | f x0 x1 == LT = myMinimumBy f (x0:xs)
  | otherwise     = myMinimumBy f (x1:xs)
```


### 10 myMaximum/myMinimum

```haskell
myMaximum :: (Ord a) => [a] -> a
myMaximum xs = myMaximumBy compare xs

myMinimum :: (Ord a) => [a] -> a
myMinimum xs = myMinimumBy compare xs
```
