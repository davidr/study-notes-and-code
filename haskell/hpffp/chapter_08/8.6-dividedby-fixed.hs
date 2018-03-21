data DividedResult = Result (Integer, Integer) | DividedByZero deriving Show

dividedBy :: Integer -> Integer -> DividedResult
dividedBy num denom = go num denom 0 1
  where go n d count sign
         | d == 0          = DividedByZero
         | n < 0 && d < 0  = go (abs n) (abs d) 0   1
         | n < 0 || d < 0  = go (abs n) (abs d) 0 (-1)
         | n < d           = Result (sign * count, sign * n)
         | otherwise       = go (n - d) d (count + 1) sign
