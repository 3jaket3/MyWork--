-- matrix multiply  wed, jan 23 2019
-- jake tully		
-- this program multiplies two matricies
import Control.Parallel
import Data.List
import Data.Time


mult :: Num a => [[a]] -> [[a]] -> [[a]]
mult a b = [[ sum $ zipWith (*) ar bc | bc <- (transpose b) ] | ar <- a]

main = do
	start <- getCurrentTime
	print([[2,2],[2,2]] `mult` [[2,2,2],[2,2,2]])
	end <- getCurrentTime
	print(diffUTCTime end start)