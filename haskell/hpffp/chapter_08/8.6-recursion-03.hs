multTheHardWay :: (Integral a) => a -> a -> a
multTheHardWay x y = go x y 0
  where go x y sum
         | y == 0     = sum
         | otherwise = go x (y - 1) (sum + x)
