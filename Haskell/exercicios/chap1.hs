
-- Find the penultimate element in list l
penultimate xs = last $ init xs

-- Find the element at index k in list l
-- For example: "findK 2 [0,0,1,0,0,0]" returns 1
findK n l = l !! n

-- Determine if list l is a palindrome
palindrome l = l == reverse l

{-
- Duplicate the elements in list xs, for example "duplicate [1,2,3]" would give the list [1,1,2,2,3,3]
- Hint: The "concat [l]" function flattens a list of lists into a single list.
- (You can see the function definition by typing ":t concat" into the interpreter. Perhaps try this with other variables and functions)
-
- For example: concat [[1,2,3],[3,4,5]] returns [1,2,3,3,4,5]
-}
duplicate [] = []
duplicate (x:xs) = [x,x] ++ duplicate xs

{-
- Imitate the functinality of zip
- The function "min x y" returns the lower of values x and y
- For example "ziplike [1,2,3] ['a', 'b', 'c', 'd']" returns [(1,'a'), (2, 'b'), (3, 'c')]
-}
zipLike [] _ = []
zipLike _ [] = []
zipLike (a:as) (b:bs) = (a,b) : zipLike as bs

-- Split a list l at element k into a tuple: The first part up to and including k, the second part after k
-- For example "splitAtIndex 3 [1,1,1,2,2,2]" returns ([1,1,1],[2,2,2])
splitAtIndex n l = (take n l, drop n l)

-- Drop the element at index k in list l
-- For example "dropK 3 [0,0,0,1,0,0,0]" returns [0,0,0,0,0,0]
dropK n l = take n l ++ drop (n+1) l

-- Extract elements between ith and kth element in list l. Including i, but not k
-- For example, "slice 3 6 [0,0,0,1,2,3,0,0,0]" returns [1,2,3]
slice a b l = take (b-a) (drop a l)

-- Insert element x in list l at index k
-- For example, "insertElem 2 5 [0,0,0,0,0,0]" returns [0,0,0,0,0,2,0]
insertElem e n l = take n l ++ [e] ++ drop n l

-- Rotate list l n places left.
-- For example, "rotate 2 [1,2,3,4,5]" gives [3,4,5,1,2]
rotate n l = drop n l ++ take n l