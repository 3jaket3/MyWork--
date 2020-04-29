using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace stackAndheap
{
	class stack<T>
	{
		static readonly int Max = 1000000;
		int head;

		T[] myStack = new T[Max];

		public stack()
		{
			head = -1;
		}

		public bool Push(T item)
		{
			if (head > Max)
			{
				Console.WriteLine("stack overflow");
				return false;
			}
			else
			{
				myStack[++head] = item;
				return true;
			}
		}

		public T Pop()
		{
			if (head < 0)
			{
				Console.WriteLine("stack underflow");
				return default(T);
			}
			else
			{
				return myStack[head--];
			}
		}

		public T Peak()
		{
			if (head < 0)
			{
				Console.WriteLine("stack underflow");
				return default(T);
			}
			else
			{
				return myStack[head];
			}
		}


	}




	
}
