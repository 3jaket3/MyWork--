using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment3part2
{
	class Program
	{

		public bool Matching(char[,] Pattern, char[,] String)
		{
			int PatternInt = calculateValue(Pattern,0,0,Pattern.GetUpperBound(0));
			int WindowInt = calculateValue(String, 0, 0, Pattern.GetUpperBound(0));
			int tempWindowInt = 0;

			for (int i = 0; i < String.GetUpperBound(0) - Pattern.GetUpperBound(0)+1; i++)
			{
				tempWindowInt = WindowInt;
				for (int j = 0; j < String.GetUpperBound(0) - Pattern.GetUpperBound(0)+1; j++)
				{
					
					
					if (tempWindowInt == PatternInt)
					{
						if (Validate(String, Pattern, i, j))
						{
							Console.WriteLine(i + " " + j);
							return true;
						}
					}

					tempWindowInt = ShiftRight(String, i, j, Pattern.GetUpperBound(0),tempWindowInt);

				}
				WindowInt = ShiftDown(String, i, 0, Pattern.GetUpperBound(0), WindowInt);

			}




			return false;
		}

		public bool Validate(char[,] String, char[,] Pattern, int startrow, int startcolumn)
		{

			for (int i = 0; i < Pattern.GetUpperBound(0); i++)
			{
				for (int j = 0; j < Pattern.GetUpperBound(0); j++)
				{
					if (Pattern[i, j] != String[startrow + i, startcolumn + j])
						return false;
				}
			}
			return true;

		}

		public int ShiftRight(char[,] window, int startrow, int startcolumn, int size, int value)
		{
			int k = 0;
			for (int i = startrow; i < size + startrow; i++)
			{
				value -= Convert.ToInt32(window[i, startcolumn]) ;
				value +=  Convert.ToInt32(window[i, startcolumn + size]);
				
			}
			return value;
		}


		public int ShiftDown(char[,] window, int startrow, int startcolumn, int size, int value)
		{
		
			for (int i = startcolumn; i < size + startcolumn; i++)
			{
				value -= Convert.ToInt32(window[startrow, i]);
				value += Convert.ToInt32(window[startrow + size, i]);
			}
			
			return value;
		}


		public int calculateValue(char[,]window ,int startrow,int startcolumn, int size)
		{
			int value = 0;
			for (int i = startcolumn; i < startcolumn+size; i++)
			{
				for (int j = startrow; j < startrow+size; j++)
				{
					value +=Convert.ToInt32(window[i, j]);
				}

			}
			 return value;



		}

		static void Main(string[] args)
		{

			char[,] String = new char[5, 5]
				{
					{ 'q','w','e','r','t' },
					{ 'a','s','d','f','g'},
					{ 'z','x','c','v','b'},
					{ 'o','i','u','y','t'},
					{ 'l','k','j','h','g'},

				};

			char[,] Pattern1 = new char[2, 2]
			{
				{ 'y','t'},
				{ 'h','g'}
			};

			char[,] Pattern2 = new char[2, 2]
				{
					{'p','l' },
					{'k','v' }
				};

			char[,] Pattern3 = new char[3, 3]
				{
					{'a','s','d' },
					{'z','x','c' },
					{'o','i','u' },
				};

			Program A = new Program();
			Console.WriteLine("Pattern 1");
			Console.WriteLine(A.Matching(Pattern1, String));
			Console.WriteLine("Pattern 2");
			Console.WriteLine(A.Matching(Pattern2, String));
			Console.WriteLine("Pattern 3");
			Console.WriteLine(A.Matching(Pattern3, String));
			Console.Read();

		}
	}
}
