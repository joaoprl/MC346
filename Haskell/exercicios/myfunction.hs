

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
      | even n =  n:chain (n `div` 2)
      | odd n  =  n:chain (n*3 + 1)

numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
	      where isLong xs = length xs > 15  

replicate' _ [] = []
replicate' 0 _ = []
replicate' n (x:xs) =
	   [x] ++ replicate' (n-1) [x] ++ replicate' n xs

zip1 xs ys = [ (x,y) | a<-[1..min(length ys) (length xs)], x <- [(xs!!(a-1))], y <- [(ys!!(a-1))]]


doubleUs x y = doubleMe x + doubleMe y

doubleMe x = 2 * x

doubleSmallNumber x =
		  if x > 100
		  then x
		  else x * 2
