  -- Remember: Tuples have the same syntax for their
  -- type constructors and
  -- their data constructors.

  f :: (a, b, c)
    -> (d, e, f)
    -> ((a, d), (c, f))

  f (a, b, c) (d, e, f) =
    ((a, d), (c, f))
