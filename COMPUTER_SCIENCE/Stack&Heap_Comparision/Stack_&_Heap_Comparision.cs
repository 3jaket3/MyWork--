using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;

namespace stackAndheap
{
	class Program
	{
		static void Main(string[] args)
		{
			stack<int> mystack = new stack<int>();
			Random r = new Random();
			Stopwatch watch = new Stopwatch();

			watch.Start();
			watch.Stop();
			watch.Reset();

			Console.WriteLine("stack timing for 10,100,1000,10000 operations");
			watch.Start();
			for (int i = 0; i < 64; i++)
			{
				mystack.Push(r.Next(100000));
			}
			for (int i = 0; i < 64; i++)
			{
				mystack.Pop();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);

			watch.Reset();
			watch.Start();
			for (int i = 0; i <256 ; i++)
			{
				mystack.Push(r.Next(100000));
			}
			for (int i = 0; i < 256; i++)
			{
				mystack.Pop();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);


			watch.Reset();
			watch.Start();
			for (int i = 0; i < 1024; i++)
			{
				mystack.Push(r.Next(100000));
			}
			for (int i = 0; i < 1024; i++)
			{
				mystack.Pop();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);


			watch.Reset();
			watch.Start();
			for (int i = 0; i < 4096; i++)
			{
				mystack.Push(r.Next(100000));
			}
			for (int i = 0; i < 4096; i++)
			{
				mystack.Pop();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);


			watch.Reset();
			watch.Start();
			for (int i = 0; i < 16384; i++)
			{
				mystack.Push(r.Next(100000));
			}
			for (int i = 0; i < 16384; i++)
			{
				mystack.Pop();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);



			watch.Reset();
			watch.Start();
			for (int i = 0; i < 32768; i++)
			{
				mystack.Push(r.Next(100000));
			}
			for (int i = 0; i < 32768; i++)
			{
				mystack.Pop();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);

			watch.Reset();
			watch.Start();
			for (int i = 0; i < 65536; i++)
			{
				mystack.Push(r.Next(100000));
			}
			for (int i = 0; i < 65536; i++)
			{
				mystack.Pop();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);



			binaryheap<int> myheap = new binaryheap<int>(100000000);

			Console.WriteLine("heap timiming");
			watch.Reset();
			watch.Start();
			for (int i = 0; i < 64; i++)
			{
				myheap.Add(r.Next(10000000));
			}
			for (int i = 0; i < 10; i++)
			{
				myheap.Remove();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);


			watch.Reset();
			watch.Start();
			for (int i = 0; i < 256; i++)
			{
				myheap.Add(r.Next(10000000));
			}
			for (int i = 0; i < 256; i++)
			{
				myheap.Remove();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);

			watch.Reset();
			watch.Start();
			for (int i = 0; i < 1024; i++)
			{
				myheap.Add(r.Next(10000000));
			}
			for (int i = 0; i < 1024; i++)
			{
				myheap.Remove();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);

			watch.Reset();
			watch.Start();
			for (int i = 0; i < 4096; i++)
			{
				myheap.Add(r.Next(10000000));
			}
			for (int i = 0; i < 4096; i++)
			{
				myheap.Remove();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);

			watch.Reset();
			watch.Start();
			for (int i = 0; i < 16384; i++)
			{
				myheap.Add(r.Next(10000000));
			}
			for (int i = 0; i < 16384; i++)
			{
				myheap.Remove();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);

			watch.Reset();
			watch.Start();
			for (int i = 0; i < 32768; i++)
			{
				myheap.Add(r.Next(10000000));
			}
			for (int i = 0; i < 32768; i++)
			{
				myheap.Remove();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);

			watch.Reset();
			watch.Start();
			for (int i = 0; i < 65536; i++)
			{
				myheap.Add(r.Next(10000000));
			}
			for (int i = 0; i < 65536; i++)
			{
				myheap.Remove();
			}
			watch.Stop();
			Console.WriteLine("execution time: {0}", watch.ElapsedTicks);

			Console.Read();
		}
	}
}
