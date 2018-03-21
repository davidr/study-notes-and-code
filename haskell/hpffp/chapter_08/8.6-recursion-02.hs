recurseSum :: (Eq a, Num a) => a -> a
recurseSum n
  | n == 1    = 1
  | otherwise = n + recurseSum (n - 1)
