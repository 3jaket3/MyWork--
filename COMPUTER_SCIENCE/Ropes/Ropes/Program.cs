using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;




namespace Ropes
{

	class Program
	{
		





		static void Main(string[] args)
		{

			
			Console.WriteLine();
			Console.WriteLine("DELETE FROM MIDDLE");

			string y = "01234567890123456789012345678901234567890123456789012345678901234578901234567890123456789012345678901234567890123456789";
			string z = "0123456789";
			Rope R = new Rope(z);
			R = R.Delete(1, 9);
			R.Print();
			R = new Rope(z);
			R = R.Delete(2, 8);
			R.Print();
			R = new Rope(z);
			R = R.Delete(3, 7);
			R.Print();
			R = new Rope(z);
			R = R.Delete(4, 6);
			R.Print();
			R = new Rope(z);
			R = R.Delete(5, 5);
			R.Print();
			R = new Rope(y);
			R.Print();

			while (R.Root.Length > 0)
			{

				if (R.Root.Length / 2 -4 < 0)
				{
					R = R.Delete(0, R.Root.Length);
					R.Print();
				}
				else
				{
					R = R.Delete((R.Root.Length / 2)-4 , R.Root.Length / 2 );
					R.Print();
				}

			}
			Console.WriteLine();
			Console.WriteLine("DELETE FROM END");
			
			R = new Rope(y);

			while (R.Root.Length > 0)
			{

				if (R.Root.Length / 2 - 1 < 0)
				{
					R = R.Delete(0, R.Root.Length);
					R.Print();
				}
				else
				{
					R = R.Delete(R.Root.Length -1, R.Root.Length);
					R.Print();
				}

			}

			Console.WriteLine();
			Console.WriteLine("DELETE FROM START");

			R = new Rope(y);

			while (R.Root.Length > 0)
			{

				
					R = R.Delete(0, 1);
					R.Print();
				

			}

			//Part B:
			//Create string:
			string x = "0123456789";

			Console.WriteLine("STRING TEST");
			

			Stopwatch sw = new Stopwatch();

			sw.Start();

			
			for (int i = 0; i < 2000; i++)
			{
				x += "0123456789";
			}

			//delete everything from the string
			while (x.Length > 0)
			{
				if ((x.Length / 2) - 10 >= 0)
				{
					x = x.Remove((x.Length / 2) - 10, 20);
				}
				else
				{
					x = x.Remove(0, x.Length);
				}
			}
			sw.Stop();

			Console.WriteLine("Elapsed={0}", sw.ElapsedMilliseconds);
			Console.WriteLine();
			Console.WriteLine("ROPE TEST");
			
			x = "0123456789";
			Stopwatch sw1 = new Stopwatch();
			sw1.Start();
			Rope R1 = new Rope(x);
			Rope R2 = new Rope(x);
			for (int i = 0; i < 2000; i++)
			{
				R1 = R1.Insert(R1,x,R1.Root.Length);
				
			}
			
			while (R1.Root.Length > 0)
			{

				if (R1.Root.Length / 2 - 5 < 0)
				{
					R1 = R1.Delete(0, R1.Root.Length);
					
				}
				else
				{
					R1 = R1.Delete(R1.Root.Length / 2 -5 , R1.Root.Length / 2 + 5);
					
				}

			}

			sw1.Stop();
			Console.WriteLine("Elapsed={0}", sw1.ElapsedMilliseconds);

			Console.WriteLine();
			Console.WriteLine("STRING TEST");


			sw = new Stopwatch();

			sw.Start();


			for (int i = 0; i < 5000; i++)
			{
				x += "0123456789";
			}

			//delete everything from the string
			while (x.Length > 0)
			{
				if ((x.Length / 2) - 10 >= 0)
				{
					x = x.Remove((x.Length / 2) - 10, 20);
				}
				else
				{
					x = x.Remove(0, x.Length);
				}
			}
			sw.Stop();

			Console.WriteLine("Elapsed={0}", sw.ElapsedMilliseconds);
			Console.WriteLine();
			Console.WriteLine("ROPE TEST");

			x = "0123456789";
		    sw1 = new Stopwatch();
			sw1.Start();
			 R1 = new Rope(x);
			 R2 = new Rope(x);
			for (int i = 0; i < 5000; i++)
			{
				R1 = R1.Insert(R1, x, R1.Root.Length);

			}

			while (R1.Root.Length > 0)
			{

				if (R1.Root.Length / 2 - 5 < 0)
				{
					R1 = R1.Delete(0, R1.Root.Length);

				}
				else
				{
					R1 = R1.Delete(R1.Root.Length / 2 - 5, R1.Root.Length / 2 + 5);

				}

			}

			sw1.Stop();
			Console.WriteLine("Elapsed={0}", sw1.ElapsedMilliseconds);


			Console.WriteLine();
			Console.WriteLine("STRING TEST");


			sw = new Stopwatch();

			sw.Start();


			for (int i = 0; i < 10000; i++)
			{
				x += "0123456789";
			}

			//delete everything from the string
			while (x.Length > 0)
			{
				if ((x.Length / 2) - 10 >= 0)
				{
					x = x.Remove((x.Length / 2) - 10, 20);
				}
				else
				{
					x = x.Remove(0, x.Length);
				}
			}
			sw.Stop();

			Console.WriteLine("Elapsed={0}", sw.ElapsedMilliseconds);
			Console.WriteLine();
			Console.WriteLine("ROPE TEST");

			x = "0123456789";
			sw1 = new Stopwatch();
			sw1.Start();
			R1 = new Rope(x);
			R2 = new Rope(x);
			for (int i = 0; i < 10000; i++)
			{
				R1 = R1.Insert(R1, x, R1.Root.Length);

			}

			while (R1.Root.Length > 0)
			{

				if (R1.Root.Length / 2 - 5 < 0)
				{
					R1 = R1.Delete(0, R1.Root.Length);

				}
				else
				{
					R1 = R1.Delete(R1.Root.Length / 2 - 5, R1.Root.Length / 2 + 5);

				}

			}

			sw1.Stop();
			Console.WriteLine("Elapsed={0}", sw1.ElapsedMilliseconds);





			/*
            string x = "happy bear banana  123yjgyjhfyhghcghchhkjjnilfjbihosdfojsdhsdjoxgdjljdfjmbjksvjdxcvjksdjkxvsnkdzxcnxznvklsdvnkdfmfgrlmflfg;lfdlkmfglkghlgmddfflkdlkjgrsflmkfzdlmk;fdmlfdlk;l;flkmzsgflmkzvflmkfzlmkfzslsdflmsdzflmksfzmlkdsfmlklmkflmvffv4567897654321234567841012345678901234567890123456789539876543231234564567876987654345678765432104654rygrdyv54rcegdvdfhgaecdsfsnhbfgsdhbtrdfxgfvfdcgvdssgvkdfnbgvjshdbzvbguskrjhfe4ruethfue4rhguisgr";
            
            Rope R1 = new Rope(x);
            Console.WriteLine(R1.GetLength());
            R1.Print();
            Console.WriteLine();

            Console.WriteLine("DELETE TEST");
            Console.WriteLine();
            R1 = new Rope(x);
            while (R1.Root.Length > 0)
            {

                R1 = R1.Delete2((R1.GetLength()/2)-10, (R1.GetLength()/2)+10);
                Console.WriteLine();
                R1.Print();
            }
            Console.WriteLine("INSERT AT EVERY INDEX");
            Console.WriteLine();

            x="Tesing insert at every index";
            R1 = new Rope(x);
            for (int i = 0; i < R1.GetLength()-2; i++)
            {
                R1 = new Rope(x);
                R1 = R1.Insert(R1, "FIN", i);
                R1.Print();
            }
                        
            R1 = new Rope("Please");
            R1= R1.Insert(R1," Work", 6);
            R1.Print();
            //Console.WriteLine();

            /*
            for (int i = 0; i < 20; i++)
            {

                R1 = R1.Delete2(R1.Root.Length/2, (R1.Root.Length/2)+1);
                R1.Print();
            }
            Console.WriteLine();
            R1 = new Rope(x);
            for (int i = 0; i < 10; i++)
            {

                R1 = R1.Delete2(R1.Root.Length - 5, R1.Root.Length);
                R1.Print();
            }

            /*
            R1 = R1.Delete2(6, 18);
            R1.Print();
            Console.WriteLine("test");
            R1 = R1.Delete(8, 12);
            R1.Print();

            //R1.Insert("Some ", 1);

            R1 = R1.Split2(20).Item1;
            R1.Print();
            R1 = R1.Split2(18).Item1;
            R1.Print();
            R1 = R1.Split2(15).Item1;
            R1.Print();
            R1 = R1.Split2(12).Item1;
            R1.Print();





            /*for (int i = 0; i < R1.GetLength() - 1; i++)
            {
                //R1 = new Rope(x);
                R1 = R1.Split2(i).Item2;
                R1.Print();
            }

            
            Console.WriteLine("INSERT AT EVERY INDEX");
            Console.WriteLine();
            Rope R1 = new Rope(x);
            for (int i = 0; i < 86; i++)
            {
                R1 = new Rope(x);
                R1 = R1.Insert(R1, "FIN", i);
                R1.Print();
            }


            Console.WriteLine("DELETE TEST");
            Console.WriteLine();
            R1 = new Rope(x);
            for (int i = 0; i < 10; i++)
            {

                R1 = R1.Delete(0, 5);
                R1.Print();
            }
            R1 = new Rope(x);
            for (int i = 0; i < 10; i++)
            {

                R1 = R1.Delete(R1.Root.Length - 5, R1.Root.Length);
                R1.Print();
            }

            R1 = new Rope(x);
            for (int i = 0; i < 6; i++)
            {

                if (R1.Root.Length / 2 - 10 < 0)
                {
                    R1 = R1.Delete(0, R1.Root.Length);
                    R1.Print();
                }
                else
                {
                    R1 = R1.Delete(R1.Root.Length / 2 - 10, R1.Root.Length / 2 + 10);
                    R1.Print();
                }
            }
            */
			Console.Read();

		}

	}
}