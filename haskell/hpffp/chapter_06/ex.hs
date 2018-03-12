-- Section 6.5, Eq Instances

data TisAnInteger =
  TisAn Integer

instance Eq TisAnInteger where
  (==) (TisAn int) (TisAn int') =
    int == int'


data TwoIntegers =
  Two Integer Integer

instance Eq TwoIntegers where
  (==) (Two a b) (Two a' b') =
    a == a' &&
    b == b'


data StringOrInt =
    TisAnInt Int
  | TisAString String

instance Eq StringOrInt where
  (==) (TisAnInt x) (TisAnInt x') = x == x'
  (==) (TisAString x) (TisAString x') = x == x'
  (==) _ _ = False


data Pair a =
  Pair a a

instance Eq a => Eq (Pair a) where
  (==) (Pair x y) (Pair x' y') =
    x == x' &&
    y == y'


data Tuple a b =
  Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
  (==) (Tuple x y) (Tuple x' y') =
    x == x' &&
    y == y'


data Which a =
    ThisOne a
  | ThatOne a

instance Eq a => Eq (Which a) where
  (==) (ThisOne x) (ThisOne x') = x == x'
  (==) (ThisOne x) (ThatOne x') = x == x'
  (==) (ThatOne x) (ThatOne x') = x == x'
  (==) _ _ = False


data EitherOr a b =
    Hello a
  | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
  (==) (Hello x) (Hello x') = x == x'
  (==) (Goodbye x) (Goodbye x') = x == x'
  (==) _ _ = False



-- Section 6.8 (Ord)

-- Given:
-- max (length [1, 2, 3])
--     (length [8, 9, 10, 11, 12])
--
-- Returns:
-- 5

-- Given:
-- compare (3 * 4) (3 * 5)
-- Returns:
-- LT

-- Given:
-- compare "Julie" True
-- Returns:
-- type error

-- Given:
-- (5 + 3) > (3 + 6)
-- Returns:
-- False
