-- Unicamp 2016 - MC346A
-- Joao Pedro Ramos Lopes - ra139546 


-- The problem
-- Given a list of rectangles, find the maximum total size of compatible rectangles
-- Two rectangles are compatible if one of them is completly on the upper left conner of the other

-- The solution
-- From the right side (using xmin as parameter) run the following recursion
-- The SIZE of a rectangle is its size plus the biggest already calculated SIZE of an rectangle on the right bottom corner of it


-- Profiling
-- $ ghc -prof -auto-all desafio.hs
-- $ ./desafio +RTS -p
-- Output file: desafio.prof


import System.IO
import Data.List


--'main' runs the main program
main :: IO ()

main = do
     contents <- getContents
     let min = minBound :: Int; l = listQuicksort((min, min, min, min, min) : (process $ map (map (\a -> read a :: Int)) (map (words) (lines contents)))); (v,str) = (process2 [] l) in
     	 putStrLn $ (show $ v) ++ "; [" ++ createIDList str ++ "]"


-- Take out of the int stack, creating a string
createIDList :: [Int] -> [Char]

createIDList [h] = show h
createIDList (h:t) = do
     createIDList t ++ "," ++ show h
     
	 
-- Process input to a list of tuples of integers (id, xmin, xmax, ymin, ymax)
process :: [[Int]] -> [(Int, Int, Int, Int, Int)]

process list = [(id, x1, x2, y1, y2) | (id:x1:x2:y1:y2:_) <- list]


-- Process given list of already calculated rectangles and a list of to be calculated rectangles it returns the total sum of compatible rectangles
-- If starting, the first list should be empty and the second should have every rectangle
-- Returns a tuple of total size and a list with the rectangles used to get that size
process2 :: [(Int, Int, Int, Int, Int, Int, [Int])] -> [(Int, Int, Int, Int, Int)] -> (Int, [Int])

process2 list [] = let (_, _, _, _, _, v, str) = head list in (v, str)
process2 calc (rect@(id, xmin, xmax, ymin, ymax):list) =
	 let rect = getValue $ find (\ (_,x,_,y,_,_,_) -> x > xmax && y > ymax) calc; size = (abs $ (xmax - xmin) * (ymax - ymin))+ (getSize $ rect) in
	 process2 (insertT (id, xmin, xmax, ymin, ymax, size, id : (getIDList rect)) calc) list


-- Insert a new tuple value in a decreasing list of tuples
insertT :: (Int, Int, Int, Int, Int, Int, [Int]) -> [(Int, Int, Int, Int, Int, Int, [Int])] -> [(Int, Int, Int, Int, Int, Int, [Int])]

insertT v [] = [v]
insertT v@(_,xmin1,xmax1,ymin1,ymax1,s1,str1) (h@(_,xmin2, xmax2, ymin2, ymax2, s2,str2):t)
	| s2 >= s1 && ymin1 < ymin2 = h:t -- Speedup: should not insert if there is a rectangle under the given one that has a greater SIZE
	| s2 <= s1 = v:h:t
	| otherwise = h:(insertT v t)


-- Get the size of a tuple
getSize :: (Int, Int, Int, Int, Int, Int, [Int]) -> Int
getSize (_,_,_,_,_,s,_) = s

getIDList (_,_,_,_,_,_,list) = list


-- Get value of a given rectangle
getValue (Just a) = a
getValue Nothing = (0,0,0,0,0,0,[])


-- Sort a list of tuples in decreasing order using xmin a parameter
-- The implemented quicksort uses the average between the first and the last elem of the list as pivot to get some speedup from the standard simple implementation
listQuicksort :: [(Int, Int, Int, Int, Int)] -> [(Int, Int, Int, Int, Int)]

listQuicksort [] = []
listQuicksort l =
	let x = getX l in
	listQuicksort [a | a <- l, gRect a x] ++
	[a | a <- l, eRect a x] ++
	listQuicksort [a | a <- l, lRect a x]

-- Return the average between the first and the last element of the list of tuples
getX :: [(Int, Int, Int, Int, Int)] -> Float
getX [(_,x,_,_,_)] = fromIntegral x
getX l =
     let (_,x1,_,_,_) = head l; (_,x2,_,_,_) = last l in
     (fromIntegral x1 + fromIntegral x2)/ fromIntegral 2

-- Return true if the first'xmin is greater than a given x
gRect :: (Int, Int, Int, Int, Int) -> Float -> Bool
gRect (_, xmin, _, _, _) x =
       x < fromIntegral xmin

-- Return true if the first'xmin is equal to a given x
eRect :: (Int, Int, Int, Int, Int) -> Float -> Bool
eRect (_, xmin, _, _, _) x =
      fromIntegral xmin == x

-- Return true if the first'xmin is equal to a given x
lRect :: (Int, Int, Int, Int, Int) -> Float -> Bool
lRect (_, xmin, _, _, _) x =
      fromIntegral xmin < x
