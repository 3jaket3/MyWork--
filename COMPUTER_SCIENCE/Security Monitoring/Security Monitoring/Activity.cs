using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Security_Monitoring
{
	public class Activity
	{
		public double start, finish;

		public bool Overlaps(double start,double finish)
		{
			return ((this.start <= start && this.finish >= start) || start <= this.start && finish >= this.start );
			
		}

		public Activity(double s, double f)
		{
			start = s;
			finish = f;
		}


	}
}
