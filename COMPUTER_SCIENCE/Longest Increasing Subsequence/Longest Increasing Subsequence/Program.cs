using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Longest_Increasing_Subsequence
{
	/*
	 *		Longest Increasing Subsequence
	 *		Dynamic Programing
	 *		
	 *		11/2/2018	Jake Tully
	 *		
	 *		This program determines the Longest Increasing Subsequence of a list using dynamic programming
	 */

	class Program
	{
		public int LIS(int[] seq)
		{
			int[] length = new int[seq.Length]; // current length of subsequence
			int[] subseq = new int[seq.Length]; // keeping track of subsequence numbers

			for (int i = 0; i < seq.Length; i++) // initialization
			{
				length[i] = 1;
			}

			for (int i = 1; i < seq.Length; i++) // iteration over length of array
			{
				for (int j = 0; j < i; j++) // iteration from start to current i
				{

					// if the seq value at i is greater then at j && the length of the sequence at i is equal 
					// or less then at j then update such that the new longest subsequence is the current sequence found
					if (seq[i] > seq[j] && length[i] < length[j] + 1) 
					{
						length[i] = length[j] + 1;
						subseq[i] = j;
					}
				}
			}
			 int lis = 1;
			int last = 0;
			for (int i = 0; i < seq.Length; i++) // iterate over length of array
			{
				if (length[i] > lis) // if the value at i is greater then lis a longer subsequence is present
				{
					lis = length[i]; // update the value of this longest sub sequence
					last = i; // record the location of the last value in the longest subsequence
				}
			}

			int[] temp = new int[lis];
			int k = lis-1;
			while (k >= 0) // backtrack to write out the longest subsequence in proper order
			{
				temp[k] = seq[last];
				k--;
				last = subseq[last];
			}

			for (int i = 0; i < temp.Length; i++) // print longest subsequence
			{
				Console.Write(temp[i] + " ");
			}

			return lis; // return the length of the longest subsequence
		}

		static void Main(string[] args)
		{
			Program A = new Program();
			int[] a = { 1, 4, 7, 10, 2, 70, 9, 13, 15, 12 };
			
			Console.WriteLine(": is the longest subsequence it's length is: " + A.LIS(a));
			Console.WriteLine();

			int[] b = { 100, 90, 200, 74, 32, 231, 12, 4, 5432, 234, 523, 123, 534, 324, 234, 645, 765 };
			Console.WriteLine(": is the longest subsequence it's length is: " + A.LIS(b));
			Console.Read();
		}
	}
}
