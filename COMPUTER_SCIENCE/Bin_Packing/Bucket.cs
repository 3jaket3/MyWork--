using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment3
{
	class Bucket
	{
		public int capacity;
		public int fill_level;
		public Bucket next;

		public Bucket(int cap)
		{
			capacity = cap;
			fill_level = 0;
			next = null;
		}


		


	}
}
