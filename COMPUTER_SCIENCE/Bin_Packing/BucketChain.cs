using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment3
{
	class BucketChain
	{
		public Bucket head;
		public int capacity;
		public int num_buckets;
		public BucketChain(int cap)
		{
			capacity = cap;
			head = new Bucket(capacity);
		}


		public void AddFirstFit(int item,Bucket current)
		{

			if (current.fill_level + item <= capacity)
			{
				current.fill_level += item;
			}
			else if (current.next != null)
			{
				AddFirstFit(item, current.next);
			}
			else
			{
				current.next = new Bucket(capacity);
				num_buckets++;
				AddFirstFit(item, current.next);
			}

		}


		public void AddBestFit(int item, Bucket current)
		{
			Bucket best_fit = null;
			int best_fill_level = 0;

			while (current != null)
			{
				if (current.fill_level + item <= capacity && current.fill_level+item > best_fill_level)
				{
					best_fit = current;
					best_fill_level = current.fill_level + item;
				}
				current = current.next;
			}

			if (best_fit != null)
			{
				best_fit.fill_level += item;
			}
			else
			{
				Bucket temp = new Bucket(capacity);
				temp.next = head;
				head = temp;
				head.fill_level += item;
				num_buckets++;
			}


		}

	}
}
