using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    // square class holds a character or a code for black square white square or clue number initialized to white square
    public class Square
    {
        public char Value { set; get; }
        public int Number { set; get; } // -1 black
        
        public Square()
        {
            this.Number = 0;
        } 
    }

    // Puzzle class 2-D array of squares to represent puzzle sections and a int N to determine the size
    public class Puzzle
    {
        private Square[,] grid;
        private int N;

        //constructor method
        public Puzzle(int size)
        {
            this.N = size;
            this.grid = new Square[size, size];
            for (int i = 0; i < this.N; i++) // looping through the 2-D array and creating all the nessacary instances of the square class
            {
                for (int j = 0; j < this.N; j++)
                {
                    grid[i, j] = new Square();
                }
            }
        }

        // method to set the game boards black squares randomly
        public void Initialize( int numBlackSquares)
        {

            int k =0;
            Random Rnd = new Random();
            int x, y;
            while( k < numBlackSquares)
            {
                x = Rnd.Next(0, N);
                y = Rnd.Next(0, N);

                if(grid[x,y].Number == 0)
                {
                    k++;
                    grid[x, y].Number = -1; // -1 for black square
                }
                 
            }
        }

        // method to check if the square is a location of a word across
        public bool CheckWordAcross(int x,int y)
        {
            if (y == N-1) // if in the rightmost collom there can be no across words
            {
                return false;
            }

            if (y == 0) // if in the leftmost collum
            {
                if (grid[x,y].Number != -1 && grid[x,y+1].Number != -1) // if the location is not a black square and one below is not a black square
                {
                    return true;
                }
                return false;
            }
            // at this point not in leftmost or rightmost collum
            // the square to the left is black and the square looked at is currently blank and the square to the right is blank
            if(grid[x,y-1].Number == -1 && grid[x,y].Number != -1 && grid[x,y+1].Number != -1)
            {
                return true;
            }

            return false; // 

        }

        public bool CheckWordDown(int x,int y)
        {
            if (x == N-1)
            {
                return false;
            }

            if (x == 0)
            {
                if (grid[x, y].Number != -1 && grid[x+1, y].Number != -1)
                {
                    return true;
                }
                return false;
            }
            if (grid[x-1, y].Number == -1 && grid[x, y].Number != -1 && grid[x+1, y].Number != -1)
            {
                return true;
            }

            return false;
        }
        public void Number()
        {
           

            int k = 1;

            for (int i = 0; i < N; i++)
            {
                for(int j = 0; j < N; j++)
                {
                    if (this.CheckWordAcross(i,j) || this.CheckWordDown(i,j))
                    {

                        grid[i, j].Number = k;
                        k++;
                    }
                }   
            }

        }

        public void PrintClues()
        {
            List<int> acrossClues = new List<int>();
            List<int> downClues = new List<int>();

            for (int i = 0; i < N; i++)
            {
                for(int j = 0; j < N; j++)
                {
                    if (grid[i,j].Number > 0)
                    {
                        if(this.CheckWordAcross(i,j))
                        {
                            acrossClues.Add(grid[i, j].Number);
                        }
                        if (this.CheckWordDown(i, j))
                        {
                            downClues.Add(grid[i, j].Number);
                        }

                        
                    }
                }
            }
            Console.Write("across clues");
            acrossClues.ForEach(Console.WriteLine);
            Console.Write("down clues");
            downClues.ForEach(Console.WriteLine);
        }

        public void PrintGrid()
        {
            for(int i = 0; i < this.N; i++)
            {
                for (int j = 0; j < this.N; j++)
                {
                    if(grid[i,j].Number > 0)
                    {
                        Console.Write("["+grid[i, j].Number + "]");
                    }
                    if (grid[i, j].Get() == 0)
                    {
                        System.Console.Write("[■]");
                    }
                    if (grid[i,j].Get() == -1)
                    {
                        System.Console.Write("[ ]");
                    }
                }
                Console.WriteLine();
            }

            return;
        }

        public bool IsSymmetric()
        {
            Puzzle P = new Puzzle(this.N);

            for(int i=0; i<N; i++)
            {
                for(int j=0; j<N; j++)
                {
                    P.grid[(N-1) - i, (N-1) - j] = this.grid[i, j];
                }
            }

            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    if((P.grid[i,j].Number != this.grid[i, j].Number) && P.grid[i,j].Number == -1)
                    {
                        return false;
                    }
                }
            }

            return true;
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Puzzle P = new ConsoleApplication1.Puzzle(5);
            P.Initialize(4);
                P.PrintGrid();
            P.Number();
            P.PrintClues();
            P.PrintGrid();
            int i = 0;
            while(!P.IsSymmetric())
            {
                P = new ConsoleApplication1.Puzzle(5);
                P.Initialize(10);
                i++;
            }
            Console.WriteLine();
            P.PrintGrid();
            Console.Write(i);
            Console.Write(P.CheckWordDown(2, 0));
            Console.WriteLine("press enter to close...");
            Console.ReadLine();
        }
    }
}
