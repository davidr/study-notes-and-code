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
  , DbNumber 42
  ]

extractUTCTime :: DatabaseItem -> [UTCTime] -> [UTCTime]
extractUTCTime (DbDate a) b = a : b
extractUTCTime _          b = b

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate db = foldr extractUTCTime [] db

extractInteger :: DatabaseItem -> [Integer] -> [Integer]
extractInteger (DbNumber a) b = a : b
extractInteger _            b = b

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber db = foldr extractInteger [] db

extractMostRecent :: DatabaseItem -> UTCTime -> UTCTime
extractMostRecent (DbDate a) b = if a > b then a else b
extractMostRecent _          b = b

myIdDate = (UTCTime (fromGregorian 0 1 1) (secondsToDiffTime 34123))

mostRecent' :: [DatabaseItem] -> UTCTime
mostRecent' db = foldr extractMostRecent myIdDate db

mostRecent :: [DatabaseItem] -> UTCTime
mostRecent = maximum . filterDbDate

sumDb :: [DatabaseItem] -> Integer
sumDb = sum . filterDbNumber

avgDb' :: [DatabaseItem] -> Double
avgDb' db = (fromIntegral . sumDb $ db) / (fromIntegral . length . filterDbNumber $ db)

-- slightly prettier:

avgDb :: [DatabaseItem] -> Double
avgDb db = sumDbNumbers / numDbNumbers
  where
    sumDbNumbers = (fromIntegral . sumDb $ db)
    numDbNumbers = (fromIntegral . length . filterDbNumber $ db)
