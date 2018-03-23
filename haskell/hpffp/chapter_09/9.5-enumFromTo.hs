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
