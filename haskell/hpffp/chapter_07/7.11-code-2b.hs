  foldBool' :: a -> a -> Bool -> a
  foldBool' x y b
    | b == True   = x
    | otherwise   = y
