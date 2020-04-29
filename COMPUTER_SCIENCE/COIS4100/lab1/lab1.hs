import Data.List
import System.IO

numlessthan20 = takeWhile(<= 20) [1,2..]
{-- this is a lazy instance because it does not actually create the infinite list 
  it just creates what is needed when needed 
  --}


x = 5

{-- x = hello world 
would result in a error because x is staticly typed and 
cannot become a string now that its already a int 
--}


main = print(numlessthan20)