-- normal order
-- jake tully

import Data.Time

increment 0 = 0
increment n = 1 + increment(n-1)

main = do
	start <- getCurrentTime
	print(increment(7000))
	end <- getCurrentTime
	print(diffUTCTime end start)