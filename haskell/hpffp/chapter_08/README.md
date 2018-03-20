- [8.1 Recursion](#orge8a5208)
- [8.2 Factorial](#org5eda6eb)
  - [Exercise:](#org6b31c9e)
- [8.3 Bottom](#org1ae32c6)
- [Fibonacci](#org1955861)
  - [Type](#org97c1325)
  - [Base case](#org8033a93)
  - [Arguments](#org6fb554b)
  - [Consider the recursion](#orgbe9511d)
- [8.5 Integer division from scratch](#org8abb820)
  - [Types](#org93a0ac9)
  - [Base case](#orge35f690)
- [8.6 Chapter Exercises](#orgbf0f28b)
  - [1.](#org0c4a33c)
  - [2.](#org1c230a6)
  - [3.](#org5fa232d)
  - [4.](#org72d6620)
  - [Reviewing currying](#orgc358799)


<a id="orge8a5208"></a>

# 8.1 Recursion


<a id="org5eda6eb"></a>

# 8.2 Factorial

Note the base case `n = 0` for this working factorial funciton

```haskell
module Factorial where

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

Another way to look at it is as self-referential function composition, `f . f . f, ..., f` for a function `f`


<a id="org6b31c9e"></a>

## Exercise:

```haskell
applyTimes 5 (+1) 5
-- (+1) (applyTimes 4 (+1) 5)
-- (+1) ((+1) applyTimes 3 (+1) 5)
-- (+1) (((+1) applyTimes 2 (+1) 5 ))
...
```


<a id="org1ae32c6"></a>

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


<a id="org1955861"></a>

# Fibonacci

Everyone's favorite interview question!

    fib 1 = 1
    fib 2 = 1
    fib n = fib n-2 + fib n-1


<a id="org97c1325"></a>

## Type

```haskell
fibonacci :: Integer -> Integer
-- or
fibonacci :: Integral a => a -> a
```


<a id="org8033a93"></a>

## Base case

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
```


<a id="org6fb554b"></a>

## Arguments

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = (x - 1) (x - 2)
-- note: doesn't work yet
```


<a id="orgbe9511d"></a>

## Consider the recursion

```haskell
fibonacci  :: Integral a => a -> a
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 2) + fibonacci (n - 1)
```


<a id="org8abb820"></a>

# 8.5 Integer division from scratch

We'll make an integer division from subtraction operations


<a id="org93a0ac9"></a>

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


<a id="orge35f690"></a>

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


<a id="orgbf0f28b"></a>

# 8.6 Chapter Exercises


<a id="org0c4a33c"></a>

## 1.

The type of `[[True, False], [True, True], [False, True]]` is d) `[[Bool]]`


<a id="org1c230a6"></a>

## 2.

The type of the above is the same as the type of b) `[[3 == 3], [6 > 5], [3 < 4]]`


<a id="org5fa232d"></a>

## 3.

Given:

```haskell
func    :: [a] -> [a] -> [a]
func x y = x ++ y
```

d) all of the above are true (x, y must be same type; x, y must be lists; if x is `String`, y must be `String`


<a id="org72d6620"></a>

## 4.

only b) ~func "Hello" "World" is valid


<a id="orgc358799"></a>

## Reviewing currying
