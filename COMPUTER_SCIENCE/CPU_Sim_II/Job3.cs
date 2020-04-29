using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
	class Job3 : IComparable
	{
		public double Gaus(double mean, double std,Random rand)
		{
			
			double u1 = 1.0 - rand.NextDouble(); //uniform(0,1] random doubles
			double u2 = 1.0 - rand.NextDouble();
			double randStdNormal = Math.Sqrt(-2.0 * Math.Log(u1)) *
						 Math.Sin(2.0 * Math.PI * u2); //random normal(0,1)
			double randNormal =
						 mean + std * randStdNormal; //random normal(mean,stdDev^2)
			return randNormal;
		}

		public double arrivalTime, jobTime,arrivedAt;
		public bool respondedTO = false;
		public Job3 Clone()
		{
			Job3 b = new Job3(0, new Random());
			b.arrivalTime = b.arrivedAt = this.arrivedAt;
			b.jobTime = this.jobTime;
			return b;
		}

		public Job3(double time,Random r)
		{
			
			if (r.NextDouble() < 0.8)
			{
				jobTime = Gaus(250, 15,r);
			}
			else
			{
				jobTime = Gaus(50, 5,r);
			}
			arrivalTime = arrivedAt = time;
		}
		public int CompareTo(object obj) // compare to method based on when event occurs (could be further expressed for priority of job types not specified)
		{

			Job3 e = (Job3)obj;


			return (int)(e.jobTime - this.jobTime);

		}
	}
}
