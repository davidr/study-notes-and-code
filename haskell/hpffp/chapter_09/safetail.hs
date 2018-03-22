safeTail         :: [a] -> Maybe [a]
safeTail []      = Nothing
safeTail (x:[])  = Nothing
safeTail (_:xs)  = Just xs
