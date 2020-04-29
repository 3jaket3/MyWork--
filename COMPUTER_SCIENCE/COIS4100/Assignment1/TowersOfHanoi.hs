-- Towers of Hanoi 1/22/2019
-- Jake Tully
-- This program calculates the solution to the tower of Hanio problem
-- resources en.wikipedia.org/wiki/Tower_of_Hanoi

type Peg = String
type Move = (Peg, Peg)

hanio :: Integer -> Peg -> Peg -> Peg -> [Move]
hanio 0 _ _ _ = []
hanio n a b c =
    let
        step1 = hanio (n-1) a c b--move m-1 disks from source to the spare peg
        step2 = (a, c) -- move the disk m from the source to the target peg
        step3 = hanio (n-1) b a c -- move the m-1 disks that we have just placed on the spare, from the spare to the targe p
     
    in 
        step1 ++ [step2] ++ step3 



main = print(hanio 3 "A" "B" "C")