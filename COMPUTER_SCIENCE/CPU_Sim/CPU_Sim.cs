using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Jake_Tully_A3
{
	class Program
	{
		

		public void LRU(Excel data)
		{
			// simulation variables
			Block current;
			int END_OF_FILE = -1;
			int i = 0;
			int TerminateApplication = -999;
			int First_Page_Loads = 0;
			int Page_Hits = 0;
			int Page_Faults = 0;
			bool Added_Succesfully;
			List<int> TerminatedApplications = new List<int>();

			Memory MyMemory = new Memory(10, 15); 

			while (data.ReadCell(i, 0) != END_OF_FILE)
			{
				current = new Block(i, data.ReadCell(i, 1), data.ReadCell ( i, 0));

				if (!TerminatedApplications.Contains(current.application))
				{
					if (current.page == TerminateApplication)
					{
						MyMemory.RemoveApplication(current.application);
					}
					else if (MyMemory.InPages(current))
					{
						MyMemory.UpdateUsageInPages(current, i);
						Page_Hits++;
					}
					else if (MyMemory.InSwap(current))
					{
						MyMemory.RecallFromSwap(current);
						Page_Faults++;
					}
					else
					{
						Added_Succesfully = MyMemory.AddLRU(current);
						if (!Added_Succesfully)
						{
							Console.WriteLine("system out of memory terminating process " + current.application);
							MyMemory.RemoveApplication(current.application);
							TerminatedApplications.Add(current.application);
						}
						else
						{
							First_Page_Loads++;
						}

					}
				}



				i++;
			}

			Console.WriteLine("First_Page_Loads = " + First_Page_Loads + " Page_Faults = " 
				+ Page_Faults + " Page_Hits = " + Page_Hits);

		}

		public void Random(Excel data)
		{
			Block current;
			int END_OF_FILE = -1;
			int i = 0;
			int TerminateApplication = -999;
			int First_Page_Loads = 0;
			int Page_Hits = 0;
			int Page_Faults = 0;
			bool Added_Succesfully;
			List<int> TerminatedApplications = new List<int>();

			Memory MyMemory = new Memory(10, 15);

			while (data.ReadCell(i, 0) != END_OF_FILE)
			{
				current = new Block(i, data.ReadCell(i, 1), data.ReadCell(i, 0));

				if (!TerminatedApplications.Contains(current.application))
				{
					if (current.page == TerminateApplication)
					{
						MyMemory.RemoveApplication(current.application);
					}
					else if (MyMemory.InPages(current))
					{
						MyMemory.UpdateUsageInPages(current, i);
						Page_Hits++;
					}
					else if (MyMemory.InSwap(current))
					{
						MyMemory.RecallFromSwap(current);
						Page_Faults++;
					}
					else
					{
						Added_Succesfully = MyMemory.AddRandom(current);
						if (!Added_Succesfully)
						{
							Console.WriteLine("system out of memory terminating process " + current.application);
							MyMemory.RemoveApplication(current.application);
							TerminatedApplications.Add(current.application);
						}
						else
						{
							First_Page_Loads++;
						}

					}
				}



				i++;
			}

			Console.WriteLine("First_Page_Loads = " + First_Page_Loads + " Page_Faults = "
				+ Page_Faults + " Page_Hits = " + Page_Hits);

		}


		static void Main(string[] args)
		{
			Console.WriteLine("Jake_Tully_A3.exe");



			Excel job_data_1 = new Excel(@"job_data.xlsx", 1);
			Excel job_data_2 = new Excel(@"job_data.xlsx", 2);
			Excel job_data_3 = new Excel(@"job_data.xlsx", 3);
			Excel job_data_4 = new Excel(@"job_data.xlsx", 4);
			Excel job_data_5 = new Excel(@"job_data.xlsx", 5);
			Excel job_data_6 = new Excel(@"job_data.xlsx", 6);

			
			Program A = new Program();

			Console.WriteLine("Job Data 1");
			Console.WriteLine("Least recently used replacement");
			A.LRU(job_data_1);
			Console.WriteLine("Random replacement");
			A.Random(job_data_1);
			Console.WriteLine();

			Console.WriteLine("Job Data 2");
			Console.WriteLine("Least recently used replacement");
			A.LRU(job_data_2);
			Console.WriteLine("Random replacement");
			A.Random(job_data_2);
			Console.WriteLine();

			Console.WriteLine("Job Data 3");
			Console.WriteLine("Least recently used replacement");
			A.LRU(job_data_3);
			Console.WriteLine("Random replacement");
			A.Random(job_data_3);
			Console.WriteLine();

			Console.WriteLine("Job Data 4");
			Console.WriteLine("Least recently used replacement");
			A.LRU(job_data_4);
			Console.WriteLine("Random replacement");
			A.Random(job_data_4);
			Console.WriteLine();

			Console.WriteLine("Job Data 5");
			Console.WriteLine("Least recently used replacement");
			A.LRU(job_data_5);
			Console.WriteLine("Random replacement");
			A.Random(job_data_5);
			Console.WriteLine();

			Console.WriteLine("Job Data 6");
			Console.WriteLine("Least recently used replacement");
			A.LRU(job_data_6);
			Console.WriteLine("Random replacement");
			A.Random(job_data_6);
			Console.WriteLine();


			Console.Read();

		}
	}
}
