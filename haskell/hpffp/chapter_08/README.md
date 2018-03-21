- [8.1 Recursion](#org839c52a)
- [8.2 Factorial](#orgf1e41fe)
  - [Exercise:](#org8e90df3)
- [8.3 Bottom](#orga390bb6)
- [Fibonacci](#org6311e62)
  - [Type](#orgc903775)
  - [Base case](#org42fb846)
  - [Arguments](#orge9f27c8)
  - [Consider the recursion](#orgf40ba06)
- [8.5 Integer division from scratch](#orge58d978)
  - [Types](#org0da6392)
  - [Base case](#orgc967196)
- [8.6 Chapter Exercises](#org066ce58)
  - [1.](#org9123297)
  - [2.](#org3c14495)
  - [3.](#org6354053)
  - [4.](#orgf8919b3)
  - [Reviewing currying](#orgefa7091)
    - [1.](#org889186e)
    - [2.](#org48f80e0)
    - [3.](#orgfdfded0)
  - [Recursion](#org910dab3)
    - [2.](#org93c69f4)
    - [3.](#orgb53b042)
  - [Fixing dividedBy](#orgfbd80ae)
  - [McCarthy 91 function](#orgacf6608)
  - [Numbers into words](#orgce66c64)


<a id="org839c52a"></a>

# 8.1 Recursion


<a id="orgf1e41fe"></a>

# 8.2 Factorial

Note the base case `n = 0` for this working factorial funciton

```haskell
module Factorial where

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

Another way to look at it is as self-referential function composition, `f . f . f, ..., f` for a function `f`


<a id="org8e90df3"></a>

## Exercise:

```haskell
applyTimes 5 (+1) 5
-- (+1) (applyTimes 4 (+1) 5)
-- (+1) ((+1) applyTimes 3 (+1) 5)
-- (+1) (((+1) applyTimes 2 (+1) 5 ))
...
```


<a id="orga390bb6"></a>

# 8.3 Bottom

note: they say that \`let x = x in x\` should give an exception, but it doesn't in my 8.2.2 version, although it doesn't consume any resources either

If we take a partial function like:

```haskell
f :: Bool -> Int
f False = 0
```

It will throw an exception (or "bottom"?) when run with `f True`, but we can turn it into a total function with `Maybe` and `Just`:

```haskell
f :: Bool -> Maybe Int
f False = Just 0
f _     = Nothing
```

which are provided without explanation, though is promised later


<a id="org6311e62"></a>

# Fibonacci

Everyone's favorite interview question!

    fib 1 = 1
    fib 2 = 1
    fib n = fib n-2 + fib n-1


<a id="orgc903775"></a>

## Type

```haskell
fibonacci :: Integer -> Integer
-- or
fibonacci :: Integral a => a -> a
```


<a id="org42fb846"></a>

## Base case

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
```


<a id="orge9f27c8"></a>

## Arguments

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = (x - 1) (x - 2)
-- note: doesn't work yet
```


<a id="orgf40ba06"></a>

## Consider the recursion

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 2) + fibonacci (n - 1)
```


<a id="orge58d978"></a>

# 8.5 Integer division from scratch

We'll make an integer division from subtraction operations


<a id="org0da6392"></a>

## Types

```haskell
dividedBy :: Integral a => a -> a -> a
dividedBy = div
```

or

```haskell
type Numerator   = Integer
type Denominator = Integer
type Quotient    = Integer

dividedBy :: Numerator -> Denominator -> Quotient
dividedBy  = div
```

(We expect this to change as we examine base case, etc.)


<a id="orgc967196"></a>

## Base case

For even division, we'll know when to stop because subtracting denominator from numerator quotient times will yield 0

For division with remainder, subtracting denominator from numerator quotient times will yield sum number smaller than denominator, so returning a 2-tuple is what we want if we don't want to implement floor division

```haskell
dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go num denom 0
  where go n   d count
	 | n < d     = (count, n)
	 | otherwise = go (n - d) d (count + 1)
```

note: we've started using a `go/where` function.


<a id="org066ce58"></a>

# 8.6 Chapter Exercises


<a id="org9123297"></a>

## 1.

The type of `[[True, False], [True, True], [False, True]]` is d) `[[Bool]]`


<a id="org3c14495"></a>

## 2.

The type of the above is the same as the type of b) `[[3 == 3], [6 > 5], [3 < 4]]`


<a id="org6354053"></a>

## 3.

Given:

```haskell
func    :: [a] -> [a] -> [a]
func x y = x ++ y
```

d) all of the above are true (x, y must be same type; x, y must be lists; if x is `String`, y must be `String`


<a id="orgf8919b3"></a>

## 4.

only b) ~func "Hello" "World" is valid


<a id="orgefa7091"></a>

## Reviewing currying

filling in the types:

```haskell
cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow " ++ y

flippy :: String -> String -> String
flippy = flip cattyConny

appedCatty :: String -> String
appedCatty = cattyConny "woops"

frappe :: String -> String
frappe = flippy "haha"
```


<a id="org889186e"></a>

### 1.

"woops mrow woohoo!"


<a id="org48f80e0"></a>

### 2.

"1 mrow haha"


<a id="orgfdfded0"></a>

### 3.

"woops mrow 2 mrow haha" &#x2026;


<a id="org910dab3"></a>

## Recursion


<a id="org93c69f4"></a>

### 2.

A function that recusively sums all numbers from 1 to n

```haskell
recurseSum :: (Eq a, Num a) => a -> a
recurseSum n
  | n == 1    = 1
  | otherwise = n + recurseSum (n - 1)
```


<a id="orgb53b042"></a>

### 3.

A function that multiplies two integral numbers using recursive summation

```haskell
multTheHardWay :: (Integral a) => a -> a -> a
multTheHardWay x y = go x y 0
  where go x y sum
	 | y == 0     = sum
	 | otherwise = go x (y - 1) (sum + x)
```


<a id="orgfbd80ae"></a>

## Fixing dividedBy

to handle divisors <= 0, we need to make some changes

```haskell
data DividedResult = Result (Integer, Integer) | DividedByZero deriving Show

dividedBy :: Integer -> Integer -> DividedResult
dividedBy num denom = go num denom 0 1
  where go n d count sign
	 | d == 0          = DividedByZero
	 | n < 0 && d < 0  = go (abs n) (abs d) 0   1
	 | n < 0 || d < 0  = go (abs n) (abs d) 0 (-1)
	 | n < d           = Result (sign * count, sign * n)
	 | otherwise       = go (n - d) d (count + 1) sign
```


<a id="orgacf6608"></a>

## McCarthy 91 function

```haskell
mc91 :: Integral a => a -> a
mc91 n
  | n >  100  = n - 10
  | otherwise = mc91 . mc91 $ n + 11
```


<a id="orgce66c64"></a>

## Numbers into words

```haskell
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

```

Keeping track of the stuff in that dense wordnumber line:

    ns                                             - [1, 2, 3]
    wordlist = map digitToWord ns                  - ["one", "two", "three"]
    wordswithhyphen = intersperse "-" wordlist     - ["one", "-", "two", "-", "three"]
    concat wordswithhyphen                         - "one-two-three"
