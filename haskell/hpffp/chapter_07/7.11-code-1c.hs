  hunsDigit :: Integral a => a -> a
  hunsDigit x = d
    where (y, _) = divMod x 100
          (_, d) = divMod y 10
