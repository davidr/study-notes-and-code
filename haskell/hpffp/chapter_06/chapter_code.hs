module Chap06 where

-- Section 6.5

data Trivial =
  Trivial'

instance Eq Trivial where
  (==) Trivial' Trivial' = True



data DayOfWeek =
  Mon | Tue | Weds | Thu | Fri | Sat | Sun
  deriving (Ord, Show)
  -- Added in 6.8

instance Eq DayOfWeek where
  (==) Mon Mon = True
  (==) Tue Tue = True
  (==) Weds Weds = True
  (==) Thu Thu = True
  (==) Fri Fri = True
  (==) Sat Sat = True
  (==) Sun Sun = True
  (==) _ _ = False


data Date =
  Date DayOfWeek Int

instance Eq Date where
  (==) (Date weekday dayOfMonth)
       (Date weekday' dayOfMonth') =
    weekday == weekday'
    && dayOfMonth == dayOfMonth'


-- playing around with non-exhaustive Eq

f :: Int -> Bool
f 1 = True
f 2 = True
f 3 = True
f _ = False


--

data Identity a =
  Identity a

instance Eq a => Eq (Identity a) where
  (==) (Identity v) (Identity v') = v == v'


-- Section 6.6, Num

-- divMod 7 3 = (2, 1)
-- quotRem 7 3 = (2, 1)


-- Gives error that / implies Fractional and Num is not Fractional
--   divideThenAdd :: Num a => a -> a -> a

divideThenAdd :: Fractional a => a -> a -> a
divideThenAdd x y = (x / y) + 1


-- Section 6.7, Type-defaulting typeclasses
-- Section 6.8, Ord
--   (mostly made changes to previous work)
-- Section 6.9, Enum
-- Section 6.10, Show
