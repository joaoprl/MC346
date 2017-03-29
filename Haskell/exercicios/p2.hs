

decodifica :: [(Char, Int)] -> [Char]
decodifica [] = []
decodifica ((c,n):xs)
	   | n == 0 = decodifica xs
	   | otherwise = c : decodifica ((c,n-1):xs)

maiorDupla :: (Ord a,Num a) => [(a,a)] -> (a,a)
maiorDupla [] = undefined
maiorDupla l = foldl1 (\(a,b) (c,d) -> if (a + b > c + d) then (a, b) else (c, d)) l

amostra :: [a] -> Int -> [a]
amostra l n
	| n <= length(l) = l !! (n-1): (amostra (drop n l) n)
	| otherwise = []

main = do
    putStr "Entre com um numero: "
    s <- getLine
    let i = read s :: Int
    putStrLn $ "Quadrado: " ++ show(i^2)
    return ()



