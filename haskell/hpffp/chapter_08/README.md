- [8.1 Recursion](#org2bf9771)
- [8.2 Factorial](#orgdfb273b)
  - [Exercise:](#org650483a)
- [8.3 Bottom](#org927dbdf)
- [Fibonacci](#org0e2e8ce)
  - [Type](#orga3aad5d)
  - [Base case](#orgd174d18)
  - [Arguments](#orgebe0181)
  - [Consider the recursion](#orgfcef1b4)
- [8.5 Integer division from scratch](#orgc1d0498)
  - [Types](#org783d61d)
  - [Base case](#org6d28198)
- [8.6 Chapter Exercises](#org596b0a1)
  - [1.](#org70b357b)
  - [2.](#org9a15468)
  - [3.](#org2c45c58)
  - [4.](#org1b5607d)
  - [Reviewing currying](#orgc2b5e57)
    - [1.](#orgb41576a)
    - [2.](#org5da6823)
    - [3.](#org15a0c4d)
  - [Recursion](#org27b34b9)
    - [2.](#org69a4d23)
    - [3.](#orgb16aeb1)
  - [Fixing dividedBy](#org68d066d)


<a id="org2bf9771"></a>

# 8.1 Recursion


<a id="orgdfb273b"></a>

# 8.2 Factorial

Note the base case `n = 0` for this working factorial funciton

```haskell
module Factorial where

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

Another way to look at it is as self-referential function composition, `f . f . f, ..., f` for a function `f`


<a id="org650483a"></a>

## Exercise:

```haskell
applyTimes 5 (+1) 5
-- (+1) (applyTimes 4 (+1) 5)
-- (+1) ((+1) applyTimes 3 (+1) 5)
-- (+1) (((+1) applyTimes 2 (+1) 5 ))
...
```


<a id="org927dbdf"></a>

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


<a id="org0e2e8ce"></a>

# Fibonacci

Everyone's favorite interview question!

    fib 1 = 1
    fib 2 = 1
    fib n = fib n-2 + fib n-1


<a id="orga3aad5d"></a>

## Type

```haskell
fibonacci :: Integer -> Integer
-- or
fibonacci :: Integral a => a -> a
```


<a id="orgd174d18"></a>

## Base case

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
```


<a id="orgebe0181"></a>

## Arguments

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = (x - 1) (x - 2)
-- note: doesn't work yet
```


<a id="orgfcef1b4"></a>

## Consider the recursion

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 2) + fibonacci (n - 1)
```


<a id="orgc1d0498"></a>

# 8.5 Integer division from scratch

We'll make an integer division from subtraction operations


<a id="org783d61d"></a>

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


<a id="org6d28198"></a>

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


<a id="org596b0a1"></a>

# 8.6 Chapter Exercises


<a id="org70b357b"></a>

## 1.

The type of `[[True, False], [True, True], [False, True]]` is d) `[[Bool]]`


<a id="org9a15468"></a>

## 2.

The type of the above is the same as the type of b) `[[3 == 3], [6 > 5], [3 < 4]]`


<a id="org2c45c58"></a>

## 3.

Given:

```haskell
func    :: [a] -> [a] -> [a]
func x y = x ++ y
```

d) all of the above are true (x, y must be same type; x, y must be lists; if x is `String`, y must be `String`


<a id="org1b5607d"></a>

## 4.

only b) ~func "Hello" "World" is valid


<a id="orgc2b5e57"></a>

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


<a id="orgb41576a"></a>

### 1.

"woops mrow woohoo!"


<a id="org5da6823"></a>

### 2.

"1 mrow haha"


<a id="org15a0c4d"></a>

### 3.

"woops mrow 2 mrow haha" &#x2026;


<a id="org27b34b9"></a>

## Recursion


<a id="org69a4d23"></a>

### 2.

A function that recusively sums all numbers from 1 to n

```haskell
recurseSum :: (Eq a, Num a) => a -> a
recurseSum n
  | n == 1    = 1
  | otherwise = n + recurseSum (n - 1)
```


<a id="orgb16aeb1"></a>

### 3.

A function that multiplies two integral numbers using recursive summation

```haskell
multTheHardWay :: (Integral a) => a -> a -> a
multTheHardWay x y = go x y 0
  where go x y sum
	 | y == 0     = sum
	 | otherwise = go x (y - 1) (sum + x)
```


<a id="org68d066d"></a>

## Fixing dividedBy

to handle divisors <= 0, we need to make some changes

```haskell
dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go num denom 0
  where go n   d count
	 | n < d     = (count, n)
	 | otherwise = go (n - d) d (count + 1)
```
