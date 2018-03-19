  module Arith4 where

  -- id :: a -> a
  -- id x = x

  roundTrip :: (Show a, Read a) => a -> a
  roundTrip a = read (show a)

  roundTripPf :: (Show a, Read a) => a -> a
  roundTripPf = read . show

  roundTripTwoType :: (Show a, Read b) => a -> b
  roundTripTwoType = read . show

  main = do
    print (roundTrip 4)
    print (roundTripPf 4)
    print (roundTripTwoType 4 :: Integer)
    print (id 4)
