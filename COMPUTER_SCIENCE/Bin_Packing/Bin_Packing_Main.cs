using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment3
{
	class Program
	{
		static void Main(string[] args)
		{
			Random rand = new Random();
			int num_items = 100;
			int num_trials = 100;
			int bucket_capacity = 100;
			int sum_of_buckets =0;
			BucketChain myBuckets = new BucketChain(bucket_capacity);


			// first fit apporach

			for (int i = 0; i <= num_trials; i++)
			{
				myBuckets = new BucketChain(bucket_capacity);
				for (int j = 0; j < num_items; j++)
				{
					myBuckets.AddFirstFit(rand.Next(bucket_capacity), myBuckets.head);
				}
				sum_of_buckets += myBuckets.num_buckets;
			}
			Console.WriteLine("first fit used on average " + sum_of_buckets/num_trials);


			// best fit approach
		
			sum_of_buckets = 0;

			for (int j = 0; j < num_trials; j++)
			{
				myBuckets = new BucketChain(bucket_capacity);
				for (int i = 0; i < num_items; i++)
				{
					myBuckets.AddBestFit(rand.Next(bucket_capacity), myBuckets.head);
				}
				sum_of_buckets += myBuckets.num_buckets;
			}
			Console.WriteLine("best fit used on average " + myBuckets.num_buckets);

			// first fit decreasing
			int[] items = new int[100];
			sum_of_buckets =0 ;

			for (int i = 0; i < num_trials; i++)
			{
				for (int j = 0; j < num_items; j++)
				{
					items[j] = rand.Next(bucket_capacity);
				}

				items = items.OrderByDescending(c => c).ToArray();

				myBuckets = new BucketChain(bucket_capacity);

				for (int j = 0; j < num_items; j++)
				{
					myBuckets.AddFirstFit(items[j], myBuckets.head);
				}
				sum_of_buckets += myBuckets.num_buckets;
			}

			Console.WriteLine("First fit decreasing used on average " + sum_of_buckets / num_trials);

			Console.Read();


		}
	}
}
