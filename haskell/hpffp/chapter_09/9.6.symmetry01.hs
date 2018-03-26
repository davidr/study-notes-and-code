
myWords :: [Char] -> [[Char]]
myWords sentence = go sentence []
  where go sentence retwords
         | length sentence > 0 = go (drop 1 $ dropWhile (/=' ') sentence)
                                    (retwords ++ [takeWhile (/=' ') sentence])
         | otherwise           = retwords
