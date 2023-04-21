module War (deal, changeones) where

import Data.List
   
deal :: [Int] -> [Int]
deal shuf =  gametime (shuffle shuf [] []) --gametime returns the winning list 

shuffle :: [Int] -> [Int] -> [Int] -> ([Int], [Int]) --creates a tuple of two decks 
shuffle [x, y] player1 player2 = (changeones [x] ++ player1, changeones [y] ++ player2) -- base case,  one card left
shuffle shuf player1 player2 = shuffle (tail (tail shuf)) ( changeones [head shuf] ++ player1 ) ( changeones [head (tail shuf)] ++ player2)
-- does recursive call with both decks added to

gametime :: ([Int], [Int]) -> [Int]
--checks emtpy lists for winners 
gametime ([], player2) = changeback player2
gametime (player1, []) = changeback player1

--main check, checks first card to determine winner, then calls recursively with edited decks
gametime (x : player1, y : player2) | x > y = gametime (player1 ++ [x, y], player2)
gametime (x : player1, y : player2) | y > x = gametime (player1, player2 ++ [y,x])
gametime (x : player1, y : player2) | x == y = war (player1 , player2, [x,y]) --calls war!

-- reverse (sort warchest) sorts the warchest in descending order, changeback changes 14's back into 1's 
war :: ([Int], [Int], [Int]) -> [Int]

--tests for empty decks 
war ([], player2, warchest) = changeback (player2 ++ reverse (sort warchest))
war (player1, [], warchest) = changeback (player1 ++ reverse (sort warchest)) 

--test for 1 card left in deck (can't play war)
war ([x], y:player2, warchest) = changeback (player2 ++ reverse (sort (warchest ++ [x] ++ [y]))) 
war (x:player1, [y], warchest) = changeback (player1 ++ reverse (sort (warchest ++ [y] ++ [x]))) 

--first card goes down, second card is checked
war (down1 : up1 : player1, down2 : up2 : player2, warchest) --winning player gets all warchest added, and returns back to gametime function
    | up1 > up2 = gametime (player1 ++ reverse (sort (warchest ++ [up2] ++ [up1] ++ [down1] ++ [down2])), player2)
    | up1 < up2 = gametime (player1 , player2 ++ reverse (sort (warchest ++ [up2] ++ [up1] ++ [down1] ++ [down2])))
    | up1 == up2 = war (player1, player2, reverse (sort (warchest ++ [up2] ++ [up1] ++ [down1] ++ [down2]))) --war goes on, cards added to chest

--function to change 1's into 14's
changeones :: [Int] -> [Int]
changeones [1] = [14] 
changeones [] = [] 
changeones (1:rest) = 14:changeones rest
changeones (x:rest) = x:changeones rest

--function to change 14's back into 1's
changeback :: [Int] -> [Int]
changeback [14] = [1] 
changeback [] = [] 
changeback (14:rest) = 1:changeback rest
changeback (x:rest) = x:changeback rest