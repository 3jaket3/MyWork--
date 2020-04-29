using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Investments
{
	class Program
	{
		/*	Dynamic Programming Investment Example	
		 *	
		 *	11/2/2018	Jake Tully
		 *	
		 *	This Program uses dynamic programing techniques to determine the best way
		 *	to invest a sum of money based on intereast rates
		 * 
		 *  The matrix used are as follows
		 *  
		 *  term in years 0  1    2    3 
		 *            0 { 1  1.6  1.3  1.2 }   
					  1	{ 0  1    1.5  1.2 }  ex. 1->1.6 = I01
					  2	{ 0  0    1    1.4 }
					  3	{ 0  0    0    1   }
		 * 
		 *  ex. best = 1.6*1.5*1.4
		 */

		public double INV(double[,] inv) // This Creates a investment given a matrix of intereast rates
		{
			double[,] bestInv = new double[inv.GetUpperBound(0)+1,inv.GetUpperBound(0)+1];
			int[,] s = new int[inv.GetUpperBound(0) + 1, inv.GetUpperBound(0) + 1];


			for (int i = 0; i < inv.GetLength(0); i++) // create best investment matrix assuming no possible lose
			{
				bestInv[i, i] = 1;
			}

			for (int c = 2; c <= inv.GetLength(0); c++) // iteration used to build table of best investment at each point in time
			{
				
				for (int i = 0; i < inv.GetLength(0) -c +1; i++)
				{
					int j = i + c - 1;
					
					
					for (int p = i ; p <= j; p++)
					{
						// equation to determine the best possible investments curretly
						double q = Math.Max(Math.Pow(inv[i, j], j - i), bestInv[i, p] * bestInv[p, j]); 
						if (q > bestInv[i, j]) // comparasion to best investment stored
						{
							bestInv[i, j] = q; // update
							s[i, j] = p; // store where it came from
						}
					}


					
					

				}
				
			}
			Describe(s,0,s.GetLength(0)-1); // call to function used to trace what investments made best investment
			



			return bestInv[0, bestInv.GetLength(0)-1]; // return value of upper right corner IE. the best investment possible
		}

		public void Describe(int[,] s, int i, int j) // recursive function used to back trace the investments
		{
			if (s[i, j] == i)
			{
				Console.Write("(I" + i + j + ")");
				
			}
			else
			{
				Describe(s, i ,s[i, j]);
				Describe(s,s[i,j],j);
			}
		}


		static void Main(string[] args)
		{

			double[,] a = new double[,] // input test 1
			{
				{ 1, 1.6,1.3, 1.2 },
				{ 0,1,1.5,1.2},
				{0,0,1,1.4 },
				{0,0,0,1 },
			};
			double[,] b = new double[,] // input test 2
				{
				{ 1,1,1.3,1.07,1.2 },
				{0,1,1,1.3,1.09 },
				{0,0,1,1.2,1.2 },
				{0,0,0,1,1.3 },
				{0,0,0,0,1 },
				};

			double[,] c = new double[,] // input test 3
				{
				{ 1,1,1.3,1.07,1.2 },
				{0,1,1,1.3,1.09 },
				{0,0,1,1.2,1.5 },
				{0,0,0,1,1.3 },
				{0,0,0,0,1 },
				};

			// calling INV method to determine best investment for the investment matrice and displaying results
			Program A = new Program();
			Console.WriteLine(" = " + A.INV(a));
			Console.WriteLine();
			Console.WriteLine(" = "+A.INV(b));
			Console.WriteLine();
			Console.WriteLine(" = " + A.INV(c));
			Console.Read();
		}
	}
}
