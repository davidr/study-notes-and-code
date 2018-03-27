
-- the bool funciton lives in Data.Bool
import Data.Bool

map (\x -> bool x (-x) (x == 3)) [1..10]
