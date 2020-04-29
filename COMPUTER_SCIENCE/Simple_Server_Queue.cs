using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;
using System.IO;

namespace A1Question3P2
{
    class Program
    {

        class serverQueue
        {

           public double[] waitTime;
           public double[] departureTime;
            public double[] arrivalTime;
            public double[] serviceTime;
           public double maxDelay;
            private myData Data;

           public serverQueue()
            {
                waitTime = new double[999];
                departureTime = new double[999];
                Data = new myData();
                arrivalTime = Data.arrivalTime;
                serviceTime = Data.serviceTime;
                
            } 

            public void Simulation()
            {
                
                double maxDelay = 0;
                int jobsDelayed = 0;
                 waitTime[0] = 0;
                departureTime[0] = serviceTime[0] +arrivalTime[0];
                for(int i = 1; i < 999; i++)
                {

                    if(departureTime[i-1] > arrivalTime[i])
                    {
                        waitTime[i] = departureTime[i - 1] - arrivalTime[i];
                        jobsDelayed++;
                    }
                    else
                    {
                        waitTime[i] = 0;
                    }
                    departureTime[i] = departureTime[i - 1] + serviceTime[i];
                    if (waitTime[i] > maxDelay)
                    {
                        maxDelay = waitTime[i];
                    }
                }

                System.Console.WriteLine(" enter a time to find how many items are in queue: ");

                double time = Convert.ToDouble(System.Console.ReadLine());
                int inSystem = 0;
                
                for(int j = 0; j < 999; j++)
                {
                    if(departureTime[j] > time && arrivalTime[j] < time)
                    {
                        inSystem++;
                    }
                }

                System.Console.WriteLine("The max delay is: " + maxDelay);
                System.Console.WriteLine("The number of jobs delayed out of 999 is : " + jobsDelayed);
                System.Console.WriteLine("The Number of Jobs in system at time " + time + " is " + inSystem);
                return;
            }

        }


        class myData
        {
            public double[] serviceTime;
            public double[] arrivalTime;
            public myData()
            {
                string filePath = @"C:book2.txt";
                string line;
                string num1;
                
                
                System.IO.StreamReader lines = new System.IO.StreamReader(filePath);

                serviceTime = new double[999];
                arrivalTime = new double[999];
                int j, k;
                j = k = 0;
                for(int i = 0; i < 1998; i++)
                {
                    line = lines.ReadLine();

                    if (i % 2 == 0)
                    {
                        arrivalTime[j] = Convert.ToDouble(line);
                        j++;
                    }
                    else
                    {
                        serviceTime[k] = Convert.ToDouble(line);
                        k++;
                    }
                }
                k = k + 1;

            }
        }


        static void Main(string[] args)
        {

            serverQueue server = new serverQueue();
            server.Simulation();
            Console.ReadLine();
        }
    }
}
