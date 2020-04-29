using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Drawing.Imaging;
using System.Windows.Forms;
using System.Windows.Forms.ComponentModel;
using System.IO;


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
            N = size;
            grid = new Square[size, size];
            for (int i = 0; i < this.N; i++) // looping through the 2-D array and creating all the nessacary instances of the square class
            {
                for (int j = 0; j < this.N; j++)
                {
                    grid[i, j] = new Square();
                }
            }
        }

        // method to set the game boards black squares randomly
        public void Initialize(int numBlackSquares)
        {

            int k = 0;
            Random Rnd = new Random();
            int x, y;
            while (k < numBlackSquares) // when k = numblack square exit
            {
                x = Rnd.Next(0, N);
                y = Rnd.Next(0, N);

                if (grid[x, y].Number == 0) // if not already a black square
                {
                    k++;
                    grid[x, y].Number = -1; // -1 for black square
                }

            }
        }
        public void InitializeSymetric(int numBlackSquares)// may result in 1 more black square than input gives
        {

            int k = 0;
            Random Rnd = new Random();
            int x, y;
            while (k < numBlackSquares) // when k = numblack square exit
            {
                x = Rnd.Next(0, N);
                y = Rnd.Next(0, N);

                if (grid[x, y].Number == 0) // if not already a black square
                {
                    k=k+1;
                    grid[N - 1 - x, N - 1 - y].Number = -1;
                    grid[x, y].Number = -1; // -1 for black square
                }

            }
        }

        // method to check if the square is a location of a word across
        public bool CheckWordAcross(int x, int y)
        {
            if (y == N - 1) // if in the rightmost collom there can be no across words
            {
                return false;
            }

            if (y == 0) // if in the leftmost collum
            {
                if (grid[x, y].Number != -1 && grid[x, y + 1].Number != -1) // if the location is not a black square and one below is not a black square
                {
                    return true;
                }
                return false;
            }
            // at this point not in leftmost or rightmost collum
            // the square to the left is black and the square looked at is currently blank and the square to the right is blank
            if (grid[x, y - 1].Number == -1 && grid[x, y].Number != -1 && grid[x, y + 1].Number != -1)
            {
                return true;
            }

            return false; // 

        }
        // method to check if a word is down same logic as checkword down but for columns
        public bool CheckWordDown(int x, int y)
        {
            if (x == N - 1)
            {
                return false;
            }

            if (x == 0)
            {
                if (grid[x, y].Number != -1 && grid[x + 1, y].Number != -1)
                {
                    return true;
                }
                return false;
            }
            if (grid[x - 1, y].Number == -1 && grid[x, y].Number != -1 && grid[x + 1, y].Number != -1)
            {
                return true;
            }

            return false;
        }
        // method to Number the clue locations
        public void Number()
        {


            int k = 1;

            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    if (this.CheckWordAcross(i, j) || this.CheckWordDown(i, j)) // clue location
                    {

                        grid[i, j].Number = k;
                        k++;
                    }
                }
            }

        }

        public void PrintClues() // method to print clues creates list and outputs list
        {
            List<int> acrossClues = new List<int>();
            List<int> downClues = new List<int>();

            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    if (grid[i, j].Number > 0)
                    {
                        if (this.CheckWordAcross(i, j))
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
            Console.WriteLine();
            acrossClues.ForEach(Console.WriteLine);
            Console.WriteLine();
            Console.Write("down clues");
            downClues.ForEach(Console.WriteLine);
        }

        public void PrintGrid() // method to pring grid if board is large allignment goes off
        {
            // i dont know of a good way to do this in console application
            for (int i = 0; i < this.N; i++)
            {
                for (int j = 0; j < this.N; j++)
                {
                    if (grid[i, j].Number > 0)
                    {
                        Console.Write("[" + grid[i, j].Number + "]");

                    }
                    if (grid[i, j].Number == 0)
                    {
                        System.Console.Write("[■]");


                    }
                    if (grid[i, j].Number == -1)
                    {
                        System.Console.Write("[ ]");

                    }
                }
                Console.WriteLine();

            }




        }



        public bool IsSymmetric()// method to check for symetry
        {
           for(int i=0; i<N;i++)
            {
                for(int j= 0; j <N;j++)
                {
                    if(grid[i,j].Number == -1 && grid[N-1-i,N-1-j].Number != grid[i,j].Number)// for all black squares check to see if correspoding is also black
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
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;

                Puzzle P = new ConsoleApplication1.Puzzle(5);
                P.Initialize(4);
                P.PrintGrid();
                Console.WriteLine("Properly initilized Grid");
                Console.WriteLine();
                P.Number();
                P.PrintClues();
                P.PrintGrid();
                Console.WriteLine("Properly Numbered Grid");

                Console.Write("is this grid Symetric Result: " + P.IsSymmetric().ToString());
                Console.WriteLine();
                P = new ConsoleApplication1.Puzzle(7);
                P.InitializeSymetric(15);
                 
            
                Console.WriteLine();
                P.PrintGrid();
                
                Console.Write("is this grid Symetric Result: "+ P.IsSymmetric().ToString());
                Console.WriteLine();

                P = new ConsoleApplication1.Puzzle(5);
                P.Initialize(0);
                Console.Write("is the no black grid Symetric Result: " + P.IsSymmetric().ToString());
                Console.WriteLine();
                P = new ConsoleApplication1.Puzzle(5);
                P.Initialize(25);
                Console.Write("is the all black grid Symetric Result: " + P.IsSymmetric().ToString());
                Console.WriteLine();
                Console.WriteLine("press enter to close...");
                Console.ReadLine();
            }

        }

    }

