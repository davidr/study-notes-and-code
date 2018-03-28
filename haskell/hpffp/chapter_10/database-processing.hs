import Data.Time

data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate UTCTime
                  deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase =
  [ DbDate (UTCTime (fromGregorian 1911 5 1) (secondsToDiffTime 34123))
  , DbNumber 9001
  , DbString "Hello, world!"
  , DbDate (UTCTime (fromGregorian 1921 5 1) (secondsToDiffTime 34123))
  ]

-- Write a function that filters for DbDate values and returns a list of the UTCTime values
-- inside them
--
-- so, I guess we want a foldr function that pattern matches for DbDates and returns a list of
-- UTCTimes, so:
--   if we want foldr to return [UTCTime], then we need an invocation like:
--     foldr f [UTCTime] [DatabaseItem] = [UTCTime]
--   where:
--     f :: (DatabaseItem -> [UTCTime] -> [UTCTime])

extractUTCTime :: DatabaseItem -> [UTCTime] -> [UTCTime]
extractUTCTime (DbDate a) b = a : b
extractUTCTime _          b = b

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate db = foldr extractUTCTime [] db


-- Write a function that filters for DbNumber values and returns a list of the Integer values
-- inside them
--
-- Similarly, since we want a foldr evaluation that returns [Integer], we need:
--   foldr f [Integer] [DatabaseItem] = [Integer]
-- where:
--   f :: DatabaseItem -> [Integer] -> [Integer]

extractInteger :: DatabaseItem -> [Integer] -> [Integer]
extractInteger (DbNumber a) b = a : b
extractInteger _            b = b

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber db = foldr extractInteger [] db
