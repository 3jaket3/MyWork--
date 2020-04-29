using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace stackAndheap
{
	public interface IContainer<T>
	{
		void MakeEmpty();
		bool Empty();
		int Size();
	}

	public interface Ibinaryheap<T> : IContainer<T> where T : IComparable
	{
		void Add(T item);
		void Remove();
		T Front();
	}


	public class binaryheap<T> : Ibinaryheap<T> where T : IComparable
	{
		private int capacity { get; set; }
		private T[] A;
		private int count { get; set; }

		public binaryheap(int size)
		{
			capacity = size;
			A = new T[size + 1];
			count = 0;
		}

		private void PercolateUp(int i)
		{
			int child = i, parent;

			while (child > 1)
			{
				parent = child / 2;

				if (A[child].CompareTo(A[parent]) > 0)
				{
					T item = A[child];
					A[child] = A[parent];
					A[parent] = item;
					child = parent;
				}
				else
					return;
			}
		}

		private void PercolateDown(int i)
		{
			int parent = i, child;

			while (2 * parent <= count)
			{
				child = 2 * parent;

				if (child < count)
					if (A[child + 1].CompareTo(A[child]) > 0)
					{
						child++;
					}

				if (A[child].CompareTo(A[parent]) > 0)
				{
					T item = A[child];
					A[child] = A[parent];
					A[parent] = item;
					parent = child;
				}
				else
				{
					return;
				}
			}

			
		}

		public void Add(T item)
		{
			if (count < capacity)
			{
				A[++count] = item;
				PercolateUp(count);
			}

		}

		public void Remove()
		{
			if (!Empty())
			{
				A[1] = A[count--];

				PercolateDown(1);
			}
		}

		public T Front()
		{
			if (!Empty())
			{
				return A[1];
			}
			else
				return default(T);
		}

		public bool Empty()
		{
			return count == 0;
		}

		public int Size()
		{
			return count;
		}

		public void MakeEmpty()
		{
			count = 0;
		} 

	}
}
