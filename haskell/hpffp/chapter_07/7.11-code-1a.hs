tensDigit' :: Integral a => a -> a
tensDigit' x = d
  where (y, _) = divMod x 10
        (_, d) = divMod y 10
