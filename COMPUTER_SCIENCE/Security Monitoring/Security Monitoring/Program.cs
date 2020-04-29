using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security_Monitoring
{
	class Program
	{
		/*
		 *		Security Monitoring 
		 *		
		 *		11/4/2018	Jake Tully
		 *		
		 *		Finding the minimum number of times that a security gaurd would need to look at the cameras
		 *		in order to see all of the  activities at least once using a greedy approach
		 */

		public int MinMonitor(List<Activity> activities,int mblock)
		{
			// initial variables
			int maxOverlap = 0 , overlaps = 0;
			int monitored = 0;
			double start = activities[0].start;
			double finish = activities[activities.Count() - 1].finish;
			double time;
			double selectedTime = 0;

			while (activities.Count != 0) // while activities remain in the list
			{
				//  iterate i from 1 to 500 times the minimum time block for a guard
				for (double i = 1 ; i <= 500*mblock ; i++  ) 
				{
					time = (finish-start) / i;  // set time to end of length
					overlaps = 0;
					foreach( Activity A in activities) // find number of overlaps at that time
					{
							if (A.Overlaps(time,time+mblock))
							{
								overlaps++;
							}
					}
					if (maxOverlap < overlaps) // update the max overlaps
					{
						selectedTime = time;
						maxOverlap = overlaps;
					}
				}

				int count = activities.Count();
				for (int i = count-1; i > -1; i--) // remove the activities that have the most overlap at any time
				{
					if (activities[i].Overlaps(selectedTime,selectedTime + mblock))
					{
						activities.RemoveAt(i);
					}
				}
				monitored++; // update the number of times the guard has to look
				maxOverlap = 0; // reset max overlap count
			} // repeat until all activities monitored
				return monitored;
		}

		static void Main(string[] args)
		{
			// creatrion of activities
			Activity a = new Activity(1, 4);
			Activity b = new Activity(1.5, 5);
			Activity c = new Activity(2, 6);
			Activity d = new Activity(9, 11);
			Activity e = new Activity(8.5, 12);
			Activity f = new Activity(10.2, 30);
			Activity g = new Activity(10, 28);

			// add activities to list
			List<Activity> activities = new List<Activity>();
			activities.Add(a);
			activities.Add(b);
			activities.Add(c);
			activities.Add(d);
			activities.Add(e);
			activities.Add(f);
			activities.Add(g);
			
			// use algorithm to determine the times the guard needs to look
			Program A = new Program();

			Console.WriteLine("the min number of blocks is " + A.MinMonitor(activities,2));
			
			Console.Read();

		}
	}
}
