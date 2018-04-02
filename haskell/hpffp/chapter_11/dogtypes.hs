module Chap11Dogs where

data PugType           = PugData
--   [1]                 [2]
-- 1. PugType type constructor with no args
-- 2. sole data constructor for type PugType (constant value)

data HuskyType a       = HuskyData
--   [3]                 [4]
-- 3. type constructor, taking single parametrically polymorphic

data DogeBordeaux doge = DogeBordeaux doge
--   [5]                 [6]


data Doggies a =
    Husky a
  | Mastiff a
  deriving (Eq, Show)
