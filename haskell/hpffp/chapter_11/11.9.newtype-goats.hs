{-# LANGUAGE GeneralizedNewtypeDeriving #-}

class TooMany a where
  tooMany :: a -> Bool

instance TooMany Int where
  tooMany n = n > 42

newtype Goats = Goats Int deriving (Eq, Show, TooMany)

newtype Goats' = Goats' (Int, String) deriving (Eq, Show)

instance TooMany Goats' where
  tooMany (Goats' (n, _)) = n > 42

newtype Goats'' = Goats'' (Int, Int) deriving (Eq, Show)

instance TooMany Goats'' where
  tooMany (Goats'' (n, m)) = n + m > 42

-- newtype WatGoats = WatGoats (Num a, TooMany a) deriving (Eq, Show)
