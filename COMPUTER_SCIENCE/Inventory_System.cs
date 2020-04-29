using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventorySystem
{
	class Program
	{

		class InventorySim
		{
			public InventorySim(double S, double s)
			{
				System.IO.StreamReader Demands = new System.IO.StreamReader(@"C:InventoryDemands.txt");

				double index = 0;
				double MAXIMUM = S;
				double MINIMUM = s;
				double demand = 0;
				double order;
				double Sumsetup = 0;
				double Sumholding = 0;
				double Sumshortage = 0;
				double Sumorder = 0;
				double Sumdemand = 0;
				double inventory = MAXIMUM;


				while (Demands.Peek() != -1)
				{
					index++;
					if (inventory < MINIMUM)
					{
						order = MAXIMUM - inventory;
						Sumsetup++;
						Sumorder += order;
					}
					else
					{
						order = 0;
					}
					inventory += order;
					demand = Convert.ToDouble(Demands.ReadLine());
					Sumdemand += demand;
					if (inventory > demand)
					{
						Sumholding += inventory - 0.5*demand;
					}
					else
					{
						Sumholding += Math.Pow(inventory, 2) / (2 * demand);
						Sumshortage += Math.Pow((demand - inventory),2) / (2*demand);
					}
					inventory -= demand;

				}
				if (inventory < MAXIMUM)
				{
					order = MAXIMUM - inventory;
					Sumsetup++;
					Sumorder += order;
					inventory += order;
				}
				double sumOfCosts = (Sumsetup / index) * 1000 + (Sumholding / index) * 25 + (Sumshortage / index) * 700;
				System.Console.WriteLine("For " + index + " time intervals");
				System.Console.WriteLine("with an average demand of " + Sumdemand / index);
				System.Console.WriteLine(" and policy parameters (" + MINIMUM + "," + MAXIMUM + ")");
				System.Console.WriteLine(" average order cost " + (Sumorder / index) * 8000);
				System.Console.WriteLine(" setup cost average " + (Sumsetup / index) * 1000);
				System.Console.WriteLine(" average holding level cost " + (Sumholding / index) * 25);
				System.Console.WriteLine(" average shortage level cost " + (Sumshortage / index) * 700);
				System.Console.WriteLine(" average total cost " + sumOfCosts);
				System.Console.WriteLine();
			}
		}

		class InventorySimUniform
			{
			public InventorySimUniform(double S, double s)
			{
				MyUniform Rand = new MyUniform(48,17);
				double index = 0;
				double MAXIMUM = S;
				double MINIMUM = s;
				double demand = 0;
				double order;
				double Sumsetup = 0;
				double Sumholding = 0;
				double Sumshortage = 0;
				double Sumorder = 0;
				double Sumdemand = 0;
				double inventory = MAXIMUM;


				while (index < 100)
				{
					index++;
					if (inventory < MINIMUM)
					{
						order = MAXIMUM - inventory;
						Sumsetup++;
						Sumorder += order;
					}
					else
					{
						order = 0;
					}
					inventory += order;
					demand = (double)Rand.Next();
					Sumdemand += demand;
					if (inventory > demand)
					{
						Sumholding += inventory - 0.5*demand;
					}
					else
					{
						Sumholding += Math.Pow(inventory, 2) / (2 * demand);
						Sumshortage += Math.Pow((demand - inventory),2) / (2 * demand);
					}
					inventory -= demand;

				}
				if (inventory < MAXIMUM)
				{
					order = MAXIMUM - inventory;
					Sumsetup++;
					Sumorder += order;
					inventory += order;
				}
				double sumOfCosts = (Sumsetup / index) * 1000 + (Sumholding / index) * 25 + (Sumshortage / index) * 700;
				System.Console.WriteLine("For " + index + " time intervals");
				System.Console.WriteLine("with an average demand of " + Sumdemand / index);
				System.Console.WriteLine(" and policy parameters (" + MINIMUM + "," + MAXIMUM + ")");
				System.Console.WriteLine(" average order cost " + (Sumorder / index) * 8000);
				System.Console.WriteLine(" setup cost average " + (Sumsetup / index) * 1000);
				System.Console.WriteLine(" average holding level cost " + (Sumholding / index) * 25);
				System.Console.WriteLine(" average shortage level cost " + (Sumshortage / index) * 700);
				System.Console.WriteLine(" average total cost " + sumOfCosts);
				System.Console.WriteLine();
			}

			}

		class InventorySimGeometric
		{
			public InventorySimGeometric(double S, double s)
			{
				MyGeometric Rand = new MyGeometric(29.29);

				double index = 0;
				double MAXIMUM = S;
				double MINIMUM = s;
				double demand = 0;
				double order;
				double Sumsetup = 0;
				double Sumholding = 0;
				double Sumshortage = 0;
				double Sumorder = 0;
				double Sumdemand = 0;
				double inventory = MAXIMUM;


				while (index < 100)
				{
					index++;
					if (inventory < MINIMUM)
					{
						order = MAXIMUM - inventory;
						Sumsetup++;
						Sumorder += order;
					}
					else
					{
						order = 0;
					}
					inventory += order;
					demand = Rand.Next();
					Sumdemand += demand;
					if (inventory > demand)
					{
						Sumholding += inventory - 0.5 * demand;
					}
					else
					{
						Sumholding += Math.Pow(inventory, 2) / (2 * demand);
						Sumshortage += Math.Pow((demand - inventory), 2) / (2 * demand);
					}
					inventory -= demand;

				}
				if (inventory < MAXIMUM)
				{
					order = MAXIMUM - inventory;
					Sumsetup++;
					Sumorder += order;
					inventory += order;
				}
				double sumOfCosts = (Sumsetup / index) * 1000 + (Sumholding / index) * 25 + (Sumshortage / index) * 700;
				System.Console.WriteLine("For " + index + " time intervals");
				System.Console.WriteLine("with an average demand of " + Sumdemand / index);
				System.Console.WriteLine(" and policy parameters (" + MINIMUM + "," + MAXIMUM + ")");
				System.Console.WriteLine(" average order cost " + (Sumorder / index) * 8000);
				System.Console.WriteLine(" setup cost average " + (Sumsetup / index) * 1000);
				System.Console.WriteLine(" average holding level cost " + (Sumholding / index) * 25);
				System.Console.WriteLine(" average shortage level cost " + (Sumshortage / index) * 700);
				System.Console.WriteLine(" average total cost " + sumOfCosts);
				System.Console.WriteLine();
			}
		}

		class MyUniform
		{
			int x;
			int a;
			int c;
			int m;
			int Max;
			int Min;
			public MyUniform(int max, int min)
			{
				x = 1232;
				a = 123;
				c = 1231;
				m = 9084;
				Max = max;
				Min = min;

			}

			public int Next()
			{
				int myRand;
				x = (a * x + c) % m;
				myRand =(x *(Max-Min+1))/m;
				return (int)myRand + Min;
			}
		}

		class MyGeometric
		{
			private Random rand = new Random();
			double Avg;
			public MyGeometric(double avg)
			{
				Avg = avg;
			}

			public int Next()
			{
				return (int)(Math.Log(1 - rand.NextDouble()) / Math.Log(Avg / (Avg + 1)));
			}
		}

		static void Main(string[] args)
		{
			MyUniform rand = new MyUniform(48,17);
			int x;
			for (int i = 0; i < 2000; i++) 
			{
			    x = rand.Next();
				Console.WriteLine(x);
			}
			Console.WriteLine("geometric random");
			Console.WriteLine();
			
			MyGeometric rand1 = new MyGeometric(29.29);
			
			for (int i = 0; i < 2000; i++)
			{
				x = rand1.Next();
				Console.WriteLine(x);
			}

			System.Console.WriteLine("Results using txt file");
			for (double i = 0; i <= 40; i += 5)
			{
				InventorySim sim = new InventorySim(80, i);
			}
			System.Console.WriteLine();
			System.Console.WriteLine("Results using uniform random distribution");
			for (double i = 0; i <= 40; i += 5)
			{
				InventorySimUniform sim = new InventorySimUniform(80, i);
			}

			System.Console.WriteLine();
			System.Console.WriteLine("Results using geometric random distribution");
			for (double i = 0; i <= 40; i += 5)
			{
				InventorySimGeometric sim = new InventorySimGeometric(80, i);
			}

			System.Console.ReadLine();
		}
	}
}
