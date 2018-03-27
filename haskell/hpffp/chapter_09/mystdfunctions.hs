
import Data.Bool

myOr :: [Bool] -> Bool
myOr []     = False
myOr (x:xs) = x || myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f xs = or (map f xs)

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (y:ys)
  | x == y    = True
  | otherwise = myElem x ys

myElem' :: Eq a => a -> [a] -> Bool
myElem' _ [] = False
myElem' x ys = any (== x) ys

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

squish :: [[a]] -> [a]
squish []     = []
squish (x:xs) = x ++ squish xs

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f (x:xs) = f x ++ squishMap f xs

squishAgain :: [[a]] -> [a]
squishAgain xs = squishMap id xs

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ []         = error "empty list"
myMaximumBy _ (x0:[])    = x0
myMaximumBy f (x0:x1:[]) = bool x0 x1 (f x0 x1 == LT)
myMaximumBy f (x0:x1:xs)
  | f x0 x1 == GT = myMaximumBy f (x0:xs)
  | otherwise     = myMaximumBy f (x1:xs)

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ []         = error "empty list"
myMinimumBy _ (x0:[])    = x0
myMinimumBy f (x0:x1:[]) = bool x0 x1 (f x0 x1 == GT)
myMinimumBy f (x0:x1:xs)
  | f x0 x1 == LT = myMinimumBy f (x0:xs)
  | otherwise     = myMinimumBy f (x1:xs)

myMaximum :: (Ord a) => [a] -> a
myMaximum xs = myMaximumBy compare xs

myMinimum :: (Ord a) => [a] -> a
myMinimum xs = myMinimumBy compare xs
