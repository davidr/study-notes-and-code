module Chap116DataTypes where

data Price = Price Integer deriving (Eq, Show)
--   (a)     (b)   [1]
--
-- For: a - type constructor
--      b - data constructor
--      1 - type argument

data Manufacturer = Mini | Mazda | Tata deriving (Eq, Show)
--                  (a)    (b)     (c)
--
-- For: a, b, c - data constructors

data Airline = PapuAir | CatapultsR'Us | TakeYourChancesUnited deriving (Eq, Show)

data Vehicle = Car Manufacturer Price | Plane Airline deriving (Eq, Show)
--             (a) [1]          [2]     (b)   [3]
--
-- For: 1, 2, 3 - type arguments

myCar    = Car Mini (Price 14000)
urCar    = Car Mazda (Price 20000)
clownCar = Car Tata (Price 7000)
doge     = Plane PapuAir

isCar :: Vehicle -> Bool
isCar (Car _ _) = True
isCar _         = False

isPlane :: Vehicle -> Bool
isPlane (Plane _) = True
isPlane _         = False

areCars :: [Vehicle] -> [Bool]
areCars = map isCar

getManu :: Vehicle -> Manufacturer
getManu (Plane _) = error "Plane has no manufacturer"
getManu (Car x _) = x
