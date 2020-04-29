using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;

namespace Assignment2Part2
{
	class Program
	{
		class CLCG
		{
			private double X1;
			private double X2;
			private double A1;
			private double A2;
			private double M1;
			private double M2;
			private int NUM;
			private double X;
			public double[] numbers;
			public CLCG(double a1, double m1, double a2, double m2, int num)
			{
				
				X1 = 7;
				X2 = 8;
				A1 = a1;
				A2 = a2;
				M1 = m1;
				M2 = m2;
				NUM = num;
				X = 0;
				numbers = new double[NUM];
				for (int i = 0; i < NUM; i++)
				{
					numbers[i] = this.Generate();
					System.Console.WriteLine(numbers[i]);
				}

			}

			private double Generate()
			{
				
					X1 = (X1 * A1 % M1);
					X2 = X2 * A2 % M2;
					X = mod((X1 - X2) , M1);

					if (X > 0)
					{
						return (X / M1);
					}
					else
					{
						return ((M1 - 1) / M1);
					}

				// % in C# is remainder need modulos function
				
			}
			private double mod(double x, double m)
			{
				x = x % m;
				if (x < 0)
				{
					x = x * -1;
				}
				return x;
			}

			private double[] FindGaps(double a, double b)
			{
				double[] gaps = new double[7];

				for (int k = 0; k < gaps.Length; k++)
				{
					gaps[k] = 0;
				}
				for (int i = 0; i < numbers.Length; i++)
				{
					if (numbers[i] > a && numbers[i] < b)
					{
						int j = i+1;
						Boolean flag = true;
						int gaplength = 0;
						
						do
						{
							if (j == numbers.Length)
								break;
							if (numbers[j] > a && numbers[j] < b)
							{
								if (gaplength > 5)
								{
									gaps[6]++;
									flag = false;
								}
								else
								{
									gaps[gaplength]++;
									flag = false;
								}
							}
							gaplength++;
							j++;
							
						} while (flag);
					}
				}
				return gaps;
			}

			public double GapTest(double a, double b)
			{
				double chi = 0;
				double[] Ogaps = FindGaps(a, b);
				double[] Egaps = new double[6];
				double NumGaps = 0;
				double sigma = b - a;
				for (int i = 0; i < Ogaps.Length; i++)
				{
					NumGaps += Ogaps[i];
				}
				for (int k = 0; k < Egaps.Length; k++)
				{
					if (k < 5)
					{
						Egaps[k] = sigma * Math.Pow(1 - sigma, k) * NumGaps;
					}
					else
					{
						Egaps[k] = (Math.Pow(1 - sigma, k) )* NumGaps;
					}
					chi += Math.Pow(Ogaps[k] - Egaps[k], 2) / Egaps[k];
				}

				return chi;
			}
		}

		class ExpDist
		{
			private static Random rand;
			double Mean;
			public ExpDist(double mean)
			{
				rand = new Random();
				Mean = mean;
			}

			public double Next()
			{
				return -Mean * (Math.Log(rand.NextDouble()));
			}

			public double NextFlip()
			{
				return Mean * (Math.Log(rand.NextDouble())+1);
			}

			

		}

		static void Main(string[] args)
		{
			CLCG rand = new CLCG(33,251,65,1021,100);
			Console.WriteLine("CLCG with a1=33. m1=251,a2=65,m2=1021");
			Console.WriteLine("the gap test chi^2 value is : " + rand.GapTest(0.2, 0.5));
			System.Console.WriteLine();

			CLCG rand1 = new CLCG(11, 16, 3, 32, 100);
			Console.WriteLine("CLCG with a1=11. m1=16,a2=3,m2=32");
			Console.WriteLine("the gap test chi^2 value is : " + rand1.GapTest(0.2, 0.5));
			System.Console.WriteLine();

			ExpDist exp1 = new ExpDist(1);
			for (int i = 0; i < 1000; i++)
			{
				System.Console.WriteLine(exp1.Next());
			}
			System.Console.WriteLine();
			ExpDist exp2 = new ExpDist(100);
			for (int i = 0; i < 1000; i++)
			{
				System.Console.WriteLine(exp2.Next());
			}

			System.Console.WriteLine("Flipped at vertical mean");
			for (int i = 0; i < 100; i++)
			{
				System.Console.WriteLine(exp1.NextFlip());
			}
			System.Console.WriteLine();
			
			for (int i = 0; i < 100; i++)
			{
				System.Console.WriteLine(exp2.NextFlip());
			}

			System.Console.ReadLine();
		}
		
	}
}
