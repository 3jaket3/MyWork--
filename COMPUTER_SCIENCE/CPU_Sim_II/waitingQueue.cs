using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
	public class waitingQueue<T>
	{
		private T[] A;
		private int capacity { get; set; }
		private int count { get; set; }
		private int head;
		private int tail;
		public waitingQueue(int size)
		{
			capacity = size;
			A = new T[size];
			count = 0;
			head = 0;
			tail = 0;
		}

		public void Remove()
		{

			count--;
			if (head == capacity-1)
			{
				head = 0;
			}
			else
			{
				head++;
			}
		}

		public void Add(T item)
		{
			if (count < capacity)
			{
				count++;
				if (tail == capacity)
				{
					tail = 0;
					A[tail] = item;
					tail++;
				}
				else
				{
					A[tail] = item;
					tail++;
				}

			}
			else
			{
				Console.WriteLine(" queue size exceeded ");
			}

		}

		public T Front()
		{
			if (count > 0)
				return A[head];
			else
				return default(T);
		}

		public Boolean IsEmpty()
		{
			return count == 0;
		}
	}
}
