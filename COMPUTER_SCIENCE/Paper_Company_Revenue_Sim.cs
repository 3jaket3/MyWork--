using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace A1Question1
{
    class Program
    {

        public class paperSale
        {

          public  double paperPurchased;
          public  double Cost;
          public  double Price;
          public  double Recycle;
          public double[] demandM;
          public double[,] dist;



            public paperSale(double paperPurchased, double cost,double price, double recycle)
            {

                this.paperPurchased = paperPurchased;
                Cost = cost;
                Recycle = recycle;
                Price = price;


                demandM = new double[7] {40,50,60,70,80,90,100 };
                dist = new double[8, 3] {
                    { 0, 0, 0 },
                    {3,10,44 },
                    {8,28,66 },
                    {23,68,82 },
                    {43,88,94 },
                    {78,96,100 },
                    {93,100,101 },
                    {100,101,101 }
                };

            }

            public int dayType(Random r)
            {
                
                double typeOfDay = r.NextDouble() * 100;
                int typeOfDayNum;
                if(typeOfDay <= 35)
                {
                    typeOfDayNum = 0;
                }
                else if ( typeOfDay > 35 && typeOfDay <= 80)
                {
                    typeOfDayNum = 1;
                }
                else
                {
                    typeOfDayNum = 2;
                }



                return typeOfDayNum;
            }


            public double getDemand(Random r)
            {
                
                double demandProb = r.NextDouble() * 100;
                int typeOfDay = this.dayType(r);

                for( int j = 0; j < demandM.Length -1; j++ )
                {

                    if( dist[j,typeOfDay] < demandProb && dist[j+1,typeOfDay] >= demandProb)
                    {
                        return demandM[j];

                    }

                }

                return 0;
            }

            public double getProfit(Random r)
            {
                double profit = 0;

                double Demand = this.getDemand(r);

                if( paperPurchased < Demand)
                {
                     profit = Demand* (Price -Cost) + (paperPurchased-Demand) * Recycle;
                }
                else
                {
                    profit = Demand * (Price - Cost); 
                }
                return profit;
            }


            public void Simulation(long Numdays)
            {
                Random r = new Random();
                double profit = 0;
                for (int i = 0; i < Numdays; i++)
                {

                    profit = profit + this.getProfit(r);

                }

                System.Console.WriteLine(" after a " + Numdays + " simulation the total profit is: " + profit);

            }


        }

        static void Main(string[] args)
        {

            // Demand 40
            System.Console.WriteLine("Demand 40");
            System.Console.WriteLine();
            paperSale myPaper = new A1Question1.Program.paperSale(40,0.33,0.5,0.05);
            myPaper.Simulation(1000);
            myPaper.Simulation(10000);
            myPaper.Simulation(1000000);
            System.Console.WriteLine();
            // Demand 50
            System.Console.WriteLine("Demand 50");
            System.Console.WriteLine();
            myPaper = new A1Question1.Program.paperSale(50, 0.33, 0.5, 0.05);
            myPaper.Simulation(1000);
            myPaper.Simulation(10000);
            myPaper.Simulation(1000000);
            System.Console.WriteLine();
            // Demand 60
            System.Console.WriteLine("Demand 60");
            System.Console.WriteLine();
            myPaper = new A1Question1.Program.paperSale(60, 0.33, 0.5, 0.05);
            myPaper.Simulation(1000);
            myPaper.Simulation(10000);
            myPaper.Simulation(1000000);
            System.Console.WriteLine();
            // Demand 70
            System.Console.WriteLine("Demand 70");
            System.Console.WriteLine();
            myPaper = new A1Question1.Program.paperSale(70, 0.33, 0.5, 0.05);
            myPaper.Simulation(1000);
            myPaper.Simulation(10000);
            myPaper.Simulation(1000000);
            System.Console.WriteLine();
            // Demand 80
            System.Console.WriteLine("Demand 80");
            System.Console.WriteLine();
            myPaper = new A1Question1.Program.paperSale(80, 0.33, 0.5, 0.05);
            myPaper.Simulation(1000);
            myPaper.Simulation(10000);
            myPaper.Simulation(1000000);
            System.Console.WriteLine();
            // Demand 90
            System.Console.WriteLine("Demand 90");
            System.Console.WriteLine();
            myPaper = new A1Question1.Program.paperSale(90, 0.33, 0.5, 0.05);
            myPaper.Simulation(1000);
            myPaper.Simulation(10000);
            myPaper.Simulation(1000000);
            System.Console.WriteLine();
            // Demand 100
            System.Console.WriteLine("Demand 100");
            System.Console.WriteLine();
            myPaper = new A1Question1.Program.paperSale(100, 0.33, 0.5, 0.05);
            myPaper.Simulation(1000);
            myPaper.Simulation(10000);
            myPaper.Simulation(1000000);
            System.Console.WriteLine();
            Console.ReadLine();

        }
    }
}
