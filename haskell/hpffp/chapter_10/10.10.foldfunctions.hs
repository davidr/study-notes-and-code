myOr :: [Bool] -> Bool
myOr = foldr (\a b -> if a == True then True else b) False

-- or

myOr' :: [Bool] -> Bool
myOr' = foldr (||) False

myAny :: (a -> Bool) -> [a] -> Bool
myAny f = myOr . map f

myElem :: Eq a => a -> [a] -> Bool
myElem x = foldr (\a b -> if x == a then True else b) False

myElemAny :: Eq a => a -> [a] -> Bool
myElemAny = any (==)
