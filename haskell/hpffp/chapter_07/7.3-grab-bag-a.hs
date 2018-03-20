addOneIfOdd n = case odd n of
  True -> f n
  False -> n
  where f = \x -> x + 1
