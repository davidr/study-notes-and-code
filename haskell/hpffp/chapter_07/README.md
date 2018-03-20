- [7.3 Anonymous Functions](#orgcb4fc33)
  - [Grab bag](#org2d8ac03)
    - [1](#org3c9545f)
    - [2](#org931aa84)
    - [3](#org0a32d55)
- [7.4 Pattern Matching](#org19ae873)
  - [Notes](#org22ae72a)
  - [Grab bag](#org7bfa35f)
    - [1](#org0ec8602)
    - [2.](#org8b98282)
- [7.5 Case Expressions](#org0bab463)
  - [Ex, Case Practice](#org6155771)
    - [1.](#org1a05eb1)
    - [2.](#orgedf0c4f)
    - [3.](#orgf4b4d81)
- [7.6 Higher-order functions](#org2ce17ee)
  - [Ex: Artful Dodgy](#org76171f6)
    - [2.](#org54a8190)
    - [3.](#orgf9d2c87)
    - [4.](#org52a53cb)
    - [5.](#orgeaf73a8)
    - [6.](#orgd728d8c)
    - [7.](#org1ac5dae)
    - [8.](#org58092dd)
    - [9.](#orgd00e267)
    - [&#x2026;](#orgbbe73ac)
- [7.7 Guards](#org941d1d6)
  - [Ex: Guard Duty](#org0b153cd)
    - [1.](#orgc5d5a9c)
    - [2.](#org708e993)
    - [3.](#orge251250)
    - [4/5.](#org81ed4b0)
    - [6/7/8.](#org120048a)
- [7.8 Function Composition](#org9f570d1)
- [7.9 Pointfree](#orgcb6a83b)
- [7.10 Demonstrating Composition](#org867d4df)
- [Chapter Exercises](#orgd0f9098)
  - [Multiple Choice](#org4f12d70)
    - [1.](#org0ba767c)
    - [2.](#orgfb69907)
    - [3.](#org87f702d)
    - [4.](#orgb0454a8)
    - [5.](#org013303f)
  - [Let's write code](#org27b342b)
    - [1.](#org579ef02)
    - [2.](#org12268af)
    - [3.](#orgc75fe41)
    - [4.](#org189a2c2)
    - [5.](#org430c7bd)
    - [6.](#org2989e48)


<a id="orgcb4fc33"></a>

# 7.3 Anonymous Functions


<a id="org2d8ac03"></a>

## Grab bag


<a id="org3c9545f"></a>

### 1

These are all equivalent

```haskell
mTh x y z = x * y * z
mTh x y = \z -> x * y * z
mTh x = \y -> \z -> x * y * z
mTh = \x -> \y -> \z -> x * y * z
```


<a id="org931aa84"></a>

### 2

`mTh 3` is of type `Num a => a -> a -> a`


<a id="org0a32d55"></a>

### 3

1.  a)

    Given:
    
    ```haskell
    addOneIfOdd n = case odd n of
      True -> f n
      False -> n
      where f n = n + 1
    ```
    
    Rewrite to:
    
    ```haskell
    addOneIfOdd n = case odd n of
      True -> f n
      False -> n
      where f = \x -> x + 1
    ```

2.  b)

    Given:
    
    ```haskell
    addFive x y = (if x > y then y else x) + 5
    ```
    
    Rewrite to:
    
    ```haskell
    addFive = \x -> \y -> (if x > y then y else x) + 5
    ```

3.  c)

    Given:
    
    ```haskell
    mflip f = \x -> \y -> f y x
    ```
    
    Rewrite to:
    
    ```haskell
    mflip f x y = f y x
    ```


<a id="org19ae873"></a>

# 7.4 Pattern Matching


<a id="org22ae72a"></a>

## Notes

Pattern matching in data constructors:

```haskell
data WherePenguinsLive =
    Galapagos
  | Antarctica
  | Australia
  | SouthAfrica
  | SouthAmerica
  deriving (Eq, Show)

data Penguin =
  Peng WherePenguinsLive
  deriving (Eq, Show)

isSouthAfrica' :: WherePenguinsLive -> Bool
isSouthAfrica' SouthAfrica = True
isSouthAfrica' _           = False

gimmeWhereTheyLive :: Penguin -> WherePenguinsLive
gimmeWhereTheyLive (Peng whereitlives) =
  whereitlives

galapagosPenguin :: Penguin -> Bool
galapagosPenguin (Peng Galapagos) = True
galapagosPenguin _                = False

antarcticPenguin :: Penguin -> Bool
antarcticPenguin (Peng Antarctica) = True
antarcticPenguin _                 = False

antarcticOrGalapagos :: Penguin -> Bool
antarcticOrGalapagos p =
     (galapagosPenguin p)
  || (antarcticPenguin p)

```

Pattern matching tuples

recall this from earlier type-kwon-do exercises:

```haskell
f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f x y = ((snd x, snd y), (fst x, fst y))
```

this can be rewritten more cleanly as:

```haskell
f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f (a, b) (c, d) = ((b, d), (a, c))
```


<a id="org7bfa35f"></a>

## Grab bag


<a id="org0ec8602"></a>

### 1

Given:

```haskell
k (x, y) = x
k1 = k ((4-1), 10)
k2 = k ("three", (1 + 2))
k3 = k (3, True)
```

1.  a)

    k is of type `k :: (a, b) -> a`

2.  b)

    k2 is of type `[Char]`

3.  c)

    k3 = 3


<a id="org8b98282"></a>

### 2.

```haskell
-- Remember: Tuples have the same syntax for their
-- type constructors and
-- their data constructors.

f :: (a, b, c)
  -> (d, e, f)
  -> ((a, d), (c, f))

f (a, b, c) (d, e, f) =
  ((a, d), (c, f))
```


<a id="org0bab463"></a>

# 7.5 Case Expressions


<a id="org6155771"></a>

## Ex, Case Practice


<a id="org1a05eb1"></a>

### 1.

Given:

```haskell
functionC x y = if (x > y) then x else y
```

Rewrite to:

```haskell
functionC' x y = case x > y of
  True  -> x
  False -> y
```


<a id="orgedf0c4f"></a>

### 2.

Given:

```haskell
ifEvenAdd2 n = if even n then (n + 2) else n
```

Rewrite to:

```haskell
ifEvenAdd2' n = case even n of
  True  -> n + 2
  False -> n
```


<a id="orgf4b4d81"></a>

### 3.

Given:

```haskell
nums x = case compare x 0 of
  LT -> -1
  GT -> 1
```

Rewrite to:

```haskell
nums' x = case compare x 0 of
  LT -> -1
  GT -> 1
  _  -> 0
```

to cover all cases


<a id="org2ce17ee"></a>

# 7.6 Higher-order functions

Higher-order functions are functions that accept functions as arguments


<a id="org76171f6"></a>

## Ex: Artful Dodgy

Given:

```haskell
dodgy x y = x + y * 10
oneIsOne = dodgy 1
oneIsTwo = (flip dodgy) 2
```

Adding types, we get:

```haskell
dodgy :: Num a => a -> a -> a
dodgy x y = x + y * 10

oneIsOne = dodgy 1
oneIsTwo = (flip dodgy) 2
```


<a id="org54a8190"></a>

### 2.

dodgy 1 1 = 11


<a id="orgf9d2c87"></a>

### 3.

dodgy 2 2 = 22


<a id="org52a53cb"></a>

### 4.

dodgy 1 2 = 21


<a id="orgeaf73a8"></a>

### 5.

dodgy 2 1 = 12


<a id="orgd728d8c"></a>

### 6.

oneIsOne 1 = 11


<a id="org1ac5dae"></a>

### 7.

oneIsOne 2 = 21


<a id="org58092dd"></a>

### 8.

oneIsTwo 1 = 21


<a id="orgd00e267"></a>

### 9.

oneIsTwo 2 = 22


<a id="orgbbe73ac"></a>

### &#x2026;


<a id="org941d1d6"></a>

# 7.7 Guards


<a id="org0b153cd"></a>

## Ex: Guard Duty


<a id="orgc5d5a9c"></a>

### 1.

If we take the given avgGrade:

```haskell
avgGrade :: (Fractional a, Ord a) => a -> Char
avgGrade x
  | y >= 0.9  = 'A'
  | y >= 0.8  = 'B'
  | y >= 0.7  = 'C'
  | y >= 0.59 = 'D'
  | y <  0.59 = 'F'
  where y = x / 100
```

and stick an 'otherwise' at the top, everything will be an A. We can rewrite it like this, though:

```haskell
avgGrade :: (Fractional a, Ord a) => a -> Char
avgGrade x
  | y >= 0.9  = 'A'
  | y >= 0.8  = 'B'
  | y >= 0.7  = 'C'
  | y >= 0.59 = 'D'
  | otherwise = 'F'
  where y = x / 100
```


<a id="org708e993"></a>

### 2.

If we reorder it, as we expect, whatever matches first is returned


<a id="orge251250"></a>

### 3.

Given:

```haskell
pal xs
    | xs == reverse xs = True
    | otherwise        = False
```

b) pal returns true when xs is a palindrome


<a id="org81ed4b0"></a>

### 4/5.

```haskell
pal :: Eq a => [a] -> Bool
```


<a id="org120048a"></a>

### 6/7/8.

Given:

```haskell
numbers :: (Num a, Ord a) => a -> Integer
numbers x
    | x < 0   = -1
    | x == 0  = 0
    | x > 0   = 1
```


<a id="org9f570d1"></a>

# 7.8 Function Composition


<a id="orgcb6a83b"></a>

# 7.9 Pointfree

```haskell
-- arith2.hs
module Arith2 where

add :: Int -> Int -> Int
add x y = x + y

addPF :: Int -> Int -> Int
addPF = (+)

addOne :: Int -> Int
addOne = \x -> x + 1

addOnePF :: Int -> Int
addOnePF = (+1)

main :: IO ()
main = do
  print (0 :: Int)
  print (add 1 0)
  print (addOne 0)
  print (addOnePF 0)
  print ((addOne . addOne) 0)
  print ((addOnePF . addOne) 0)
  print ((addOne . addOnePF) 0)
  print ((addOnePF . addOnePF) 0)
  print (negate (addOne 0))
  print ((negate . addOne) 0)
  print ((addOne . addOne . addOne
    . negate . addOne) 0)
```


<a id="org867d4df"></a>

# 7.10 Demonstrating Composition


<a id="orgd0f9098"></a>

# Chapter Exercises


<a id="org4f12d70"></a>

## Multiple Choice


<a id="org0ba767c"></a>

### 1.

a polymorphic function d) may resolve to values of different types, depending on inputs


<a id="orgfb69907"></a>

### 2.

Two functions names `f` and `g` have types `Char -> String` and `String -> [String]` respectively. The composed function `g . f` has type b) `Char -> [String]`


<a id="org87f702d"></a>

### 3.

A function `f` has type `Ord a = a -> a -> Bool` and we apply it to one numeric value. The type is now d) `(Ord a, Num a) => a -> Bool`


<a id="orgb0454a8"></a>

### 4.

A function with the type `(a -> b) -> c` b) is an HOF


<a id="org013303f"></a>

### 5.

Given the following definition of f:

```haskell
f :: a -> a
f x = x
```

the type of `f True` is `f True :: Bool`


<a id="org27b342b"></a>

## Let's write code


<a id="org579ef02"></a>

### 1.

Given:

```haskell
tensDigit :: Integral a => a -> a
tensDigit x = d
  where xLast = x `div` 10
	d     = xLast `mod` 10
```

1.  a)

    rewritten with `divMod`, we get:
    
    ```haskell
    tensDigit' :: Integral a => a -> a
    tensDigit' x = d
      where (y, _) = divMod x 10
    	(_, d) = divMod y 10
    ```

2.  b)

    which is the same type as what was given

3.  c)

    ```haskell
    hunsDigit :: Integral a => a -> a
    hunsDigit x = d
      where (y, _) = divMod x 100
    	(_, d) = divMod y 10
    ```


<a id="org12268af"></a>

### 2.

Implement `foldBool` to be a sort of "if Bool then a else a'" sort of thing

Using case:

```haskell
foldBool :: a -> a -> Bool -> a
foldBool x y b = case b of
  True -> x
  _    -> y
```

Using guard:

```haskell
foldBool' :: a -> a -> Bool -> a
foldBool' x y b
  | b == True   = x
  | otherwise   = y
```


<a id="orgc75fe41"></a>

### 3.

```haskell
g :: (a -> b) -> (a, c) -> (b, c)
g f (x, y) = (f x, y)
```


<a id="org189a2c2"></a>

### 4.

```haskell
module Arith4 where

-- id :: a -> a
-- id x = x

roundTrip :: (Show a, Read a) => a -> a
roundTrip a = read (show a)

main = do
  print (roundTrip 4)
  print (id 4)
```


<a id="org430c7bd"></a>

### 5.

```haskell
module Arith4 where

-- id :: a -> a
-- id x = x

roundTrip :: (Show a, Read a) => a -> a
roundTrip a = read (show a)

roundTripPf :: (Show a, Read a) => a -> a
roundTripPf = read . show

main = do
  print (roundTrip 4)
  print (roundTripPf 4)
  print (id 4)
```


<a id="org2989e48"></a>

### 6.

```haskell
module Arith4 where

-- id :: a -> a
-- id x = x

roundTrip :: (Show a, Read a) => a -> a
roundTrip a = read (show a)

roundTripPf :: (Show a, Read a) => a -> a
roundTripPf = read . show

roundTripTwoType :: (Show a, Read b) => a -> b
roundTripTwoType = read . show

main = do
  print (roundTrip 4)
  print (roundTripPf 4)
  print (roundTripTwoType 4 :: Integer)
  print (id 4)

```
