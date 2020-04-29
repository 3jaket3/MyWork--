using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
	/*
		Jake Tully
		10/31/2018

		simulation of first in first out queue, shortest job first , round robin and shortest job first with pre emption

		Job1 all jobs are of same time length
		Job2 80% 20% short- long 
		job3 20% 80% short long
		impliments priority queue and circular array data structures

	*/
	class Program
	{
		

		static void Main(string[] args)
		{

			// initial variables and queues
			double time = 0;
			Random r = new Random();
			int numjobs = 1000;
			waitingQueue<Job1> FIFO = new waitingQueue<Job1>(numjobs);
			waitingQueue<Job1> SJF = new waitingQueue<Job1>(numjobs);
			waitingQueue<Job1> STCF = new waitingQueue<Job1>(numjobs);
			waitingQueue<Job1> RoundRobin50 = new waitingQueue<Job1>(numjobs);
			waitingQueue<Job1> RoundRobin75 = new waitingQueue<Job1>(numjobs);
			Job1 current;

			// create 1000 arrival times with guassian dist
			for (int i = 0; i < numjobs; i++)
			{
				double u1 = 1.0 - r.NextDouble(); //uniform(0,1] random doubles
				double u2 = 1.0 - r.NextDouble();
				double randStdNormal = Math.Sqrt(-2.0 * Math.Log(u1)) *
							 Math.Sin(2.0 * Math.PI * u2); //random normal(0,1)
				double randNormal =
							 160 + 15 * randStdNormal; //random normal(mean,stdDev^2)

				time = time + randNormal;
				Job1 a = new Job1(time, r); // new job with arrival time and random nummber generator
				FIFO.Add(a); // add jobs to queues
				SJF.Add(a);
				STCF.Add(a.Clone());
				RoundRobin75.Add(a.Clone());
				RoundRobin50.Add(a);
			}


			// FIFO QUEUE
			time = FIFO.Front().arrivalTime; // set time to first arrival time
			double avgResponse = 0;
			double turnAround = 0;

			while (FIFO.IsEmpty() == false) // while the queue isnt empty process the jobs in the queue
			{
				current = FIFO.Front(); // set current job to the front of the queue

				if (time >= current.arrivalTime) // if the time is greater then the current then the job waited
				{
					avgResponse += time - current.arrivalTime; // time the job waited
					time = time + current.jobTime; // advance the clock to when the job completes
					turnAround += time - current.arrivalTime; // turn around time is current time - when it arrived
					FIFO.Remove(); // remove the job from the queue
				}
				else // job did not wait
				{
					time = current.arrivalTime; // set time to current time
					avgResponse += time - current.arrivalTime; // = 0
					time = time + current.jobTime; //advance time to when job completes
					turnAround += time - current.arrivalTime; // turn around time should be job time
					FIFO.Remove(); // remove job from the queue
				}
			}

			// output results
			Console.WriteLine(" The Results for the FIFO Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / numjobs);
			Console.WriteLine(" the average turn around time is: " + turnAround / numjobs);
			Console.WriteLine();


			// SJF Processing
			// priority queue that sorts jobs based on job length
			PriorityQueue<Job1> priorityQueueSJF = new PriorityQueue<Job1>(numjobs);

			time = 0;
			avgResponse = 0;
			turnAround = 0;
			while (SJF.IsEmpty() == false || priorityQueueSJF.Empty() == false) // while neither queue is empty process jobs
			{
				if (!SJF.IsEmpty()) // so SJF.Front() is not null
				{
					while (SJF.Front().arrivalTime <= time) // add all jobs that arrived during the last job to the priority queue
					{
						priorityQueueSJF.Add(SJF.Front());
						SJF.Remove();
						if (SJF.IsEmpty() == true) // SJF could become empty before while loop exicutes break if this happens
							break;

					}
				}
				if (priorityQueueSJF.Empty() == false) // if the priority queue isnt empty jobs are waiting
				{
					current = priorityQueueSJF.Front(); // set current to the shortest job
					avgResponse += time - current.arrivalTime; //calculate parameters 
					time = time + current.jobTime; // advance the clock to when the job finishes
					turnAround += time - current.arrivalTime;
					priorityQueueSJF.Remove(); // remove the job from the queue
				}
				else // no jobs are waiting
				{
					if (SJF.IsEmpty() == false) // insure that the job queue isnt empty
					{ 
						current = SJF.Front(); // set the current to the front of the queue
						// process the job and remove it from the queue
							time = current.arrivalTime;
							avgResponse += time - current.arrivalTime;
							time = time + current.jobTime;
							turnAround += time - current.arrivalTime;
							SJF.Remove();
						
					}

				}

			}

			// output results
			Console.WriteLine(" The Results for the SJF Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / numjobs);
			Console.WriteLine(" the average turn around time is: " + turnAround / numjobs);
			Console.WriteLine();

			// Round Robin 50 time units 

			// waiting queue for jobs waiting to be run
			waitingQueue<Job1> RoundRobinProccessing = new waitingQueue<Job1>(numjobs);

			// initialize variables
			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current = RoundRobin50.Front();
			time = current.arrivalTime;
			RoundRobinProccessing.Add(current);

			while (!RoundRobin50.IsEmpty() || !RoundRobinProccessing.IsEmpty()) // while neither queue is empty process jobs
			{

				if (RoundRobinProccessing.IsEmpty()) // if round robin processing is empty no job is waiting
				{
					
					current = RoundRobin50.Front(); // set current to the next job to arrive
					time = current.arrivalTime; // update time to the arrival
					RoundRobin50.Remove(); // remove job from queue
					RoundRobinProccessing.Add(current); // add job to processing queue
				}
				else // jobs are waiting to be processed
				{
					current = RoundRobinProccessing.Front(); // set current to front of processing queue
				}

				if (!RoundRobin50.IsEmpty()) // if the job quueue isnt empty
				{
					while (time >= RoundRobin50.Front().arrivedAt) // jobs arrived durring process
					{
						RoundRobinProccessing.Add(RoundRobin50.Front()); // add jobs to end of queue
						RoundRobin50.Remove(); // 
						if (RoundRobin50.IsEmpty())
							break;
					}
				}

				if (current.jobTime < 50) // job will finish before 50 time units
				{
					if (current.respondedTO == false) // has the job been in the processor already if it hasnt 
					{
						avgResponse += time - current.arrivedAt; // calculate response time
					}
					time = time + current.jobTime; // update time to when the job finishes
					RoundRobinProccessing.Remove(); // remove it from the processing queue
					turnAround += time - current.arrivedAt; // calcualte turn around time
				}
				else // job time is longer than 50 units
				{
					if (current.respondedTO == false) // has the job been responded to if it has
					{
						avgResponse += time - current.arrivedAt; // calcualte response time
						current.respondedTO = true; // update that the job has been responded to
					}

					current.jobTime = current.jobTime - 50; // process the job for 50 time units
					time = time + 50;
					current.arrivalTime = time; // update time to when it was placed back in the queue
					RoundRobinProccessing.Remove(); // remove job from queue 
					RoundRobinProccessing.Add(current); // add job back to end of the queue


				}
				
				


			}
			// output results
			Console.WriteLine(" The Results for the Round Robin Queue 50 with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();

			// same logic as round robind 50 but 75 time units instead
			RoundRobinProccessing = new waitingQueue<Job1>(numjobs);
			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current = RoundRobin75.Front();
			time = current.arrivalTime;
			RoundRobinProccessing.Add(current);

			while (!RoundRobin75.IsEmpty() || !RoundRobinProccessing.IsEmpty())
			{

				if (RoundRobinProccessing.IsEmpty())
				{
					current = RoundRobin75.Front();
					time = current.arrivalTime;
					RoundRobin75.Remove();
					RoundRobinProccessing.Add(current);
				}
				else
				{
					current = RoundRobinProccessing.Front();
				}
				if (!RoundRobin75.IsEmpty())
				{
					while (time >= RoundRobin75.Front().arrivedAt)
					{
						RoundRobinProccessing.Add(RoundRobin75.Front());
						RoundRobin75.Remove();
						if (RoundRobin75.IsEmpty())
							break;
					}
				}
				if (current.jobTime < 75)
				{
					if (current.respondedTO == false)
					{
						avgResponse += time - current.arrivedAt;
					}
					time = time + current.jobTime;
					RoundRobinProccessing.Remove();
					turnAround += time - current.arrivedAt;
				}
				else
				{
					if (current.respondedTO == false)
					{
						avgResponse += time - current.arrivedAt;
						current.respondedTO = true;
					}

					current.jobTime = current.jobTime - 75;
					time = time + 75;
					current.arrivalTime = time;
					RoundRobinProccessing.Remove();
					RoundRobinProccessing.Add(current);


				}
				



			}
			Console.WriteLine(" The Results for the Round Robin Queue 75 with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / numjobs);
			Console.WriteLine(" the average turn around time is: " + turnAround / numjobs);
			Console.WriteLine();




			// STCF schedguling

			PriorityQueue<Job1> STCFProccessing = new PriorityQueue<Job1>(numjobs); // priority queue to sort jobs with lowest jobtime first


			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current = STCF.Front();
			time = current.arrivalTime;
			STCFProccessing.Add(current);

			while (STCF.IsEmpty() == false || STCFProccessing.Empty() == false)
			{

				if (STCFProccessing.Empty()) // if no jobs are wating
				{
					current = STCF.Front(); // set next job to current
					time = current.arrivalTime; // advance clock to when that job arrives
					STCF.Remove(); // remove it from the queue
					STCFProccessing.Add(current);  // add job to proccessing queue
				}
				else // jobs are waiting
				{
					current = STCFProccessing.Front(); // assign shortest job to current
				}
				if (current.jobTime < 40) //  process job for forty time units before checking if their is a shorter job
				{// job finishes before 40 units
					if (current.respondedTO == false) // check if job has been responded to before
					{
						avgResponse += time - current.arrivedAt; // calculate response time
					}
					time = time + current.jobTime; // update clock
					STCFProccessing.Remove(); // remove job from queue
					turnAround += time - current.arrivedAt; // calculate turn around time
				}
				else // job is longer than 40 units
				{
					if (current.respondedTO == false) // check if job has been responded to
					{
						avgResponse += time - current.arrivedAt; // calculate response time
						current.respondedTO = true; // set responded to to true
					}

					current.jobTime = current.jobTime - 40; // remove 4o time units from job
					time = time + 40; // advance clock 40 units
					current.arrivalTime = time; // change arrival time to when its placed back in the queue
					STCFProccessing.Remove(); // remove from proccessing queue
					STCFProccessing.Add(current); // add it back ---- so it is placed in the proper location
				}
				if (!STCF.IsEmpty()) // add any jobs that arrived during the 40 units in the processing queue
				{
					while (time >= STCF.Front().arrivedAt)
					{
						STCFProccessing.Add(STCF.Front());
						STCF.Remove();
						if (STCF.IsEmpty())
							break;
					}
				}
			}
			// output results
			Console.WriteLine(" The Results for the STCF Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / numjobs);
			Console.WriteLine(" the average turn around time is: " + turnAround / numjobs);
			Console.WriteLine();




			//////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Console.WriteLine("For the second type of Job");
			Console.WriteLine();

			time = 0;

			waitingQueue<Job2> FIFO2 = new waitingQueue<Job2>(1000);
			waitingQueue<Job2> SJF2 = new waitingQueue<Job2>(1000);
			waitingQueue<Job2> STCF2 = new waitingQueue<Job2>(1000);
			waitingQueue<Job2> RoundRobin502 = new waitingQueue<Job2>(1000);
			waitingQueue<Job2> RoundRobin752 = new waitingQueue<Job2>(1000);
			Job2 current2;

			for (int i = 0; i < 1000; i++)
			{
				double u1 = 1.0 - r.NextDouble(); //uniform(0,1] random doubles
				double u2 = 1.0 - r.NextDouble();
				double randStdNormal = Math.Sqrt(-2.0 * Math.Log(u1)) *
							 Math.Sin(2.0 * Math.PI * u2); //random normal(0,1)
				double randNormal =
							 160 + 15 * randStdNormal; //random normal(mean,stdDev^2)

				time = time + randNormal;
				Job2 a = new Job2(time, r);
				FIFO2.Add(a);
				SJF2.Add(a);
				STCF2.Add(a.Clone());
				RoundRobin752.Add(a.Clone());
				RoundRobin502.Add(a);
			}

			time = FIFO2.Front().arrivalTime;
			avgResponse = 0;
			turnAround = 0;

			while (FIFO2.IsEmpty() == false)
			{
				current2 = FIFO2.Front();

				if (time >= current2.arrivalTime)
				{
					avgResponse += time - current2.arrivalTime;
					time = time + current2.jobTime;
					turnAround += time - current2.arrivalTime;
					FIFO2.Remove();
				}
				else
				{
					time = current2.arrivalTime;
					avgResponse += time - current2.arrivalTime;
					time = time + current2.jobTime;
					turnAround += time - current2.arrivalTime;
					FIFO2.Remove();
				}
			}
			Console.WriteLine(" The Results for the FIFO Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();

			PriorityQueue<Job2> priorityQueueSJF2 = new PriorityQueue<Job2>(1000);

			time = 0;
			avgResponse = 0;
			turnAround = 0;
			while (SJF2.IsEmpty() == false || priorityQueueSJF2.Empty() == false)
			{
				if (!SJF2.IsEmpty())
				{
					while (SJF2.Front().arrivalTime <= time)
					{
						priorityQueueSJF2.Add(SJF2.Front());
						SJF2.Remove();
						if (SJF2.IsEmpty() == true)
							break;

					}
				}
				if (priorityQueueSJF2.Empty() == false)
				{
					current2 = priorityQueueSJF2.Front();
					avgResponse += time - current2.arrivalTime;
					time = time + current2.jobTime;
					turnAround += time - current2.arrivalTime;
					priorityQueueSJF2.Remove();
				}
				else
				{
					if (SJF2.IsEmpty() == false)
					{
						current2 = SJF2.Front();
						if (time >= current2.arrivalTime)
						{
							avgResponse += time - current2.arrivalTime;
							time = time + current2.jobTime;
							turnAround += time - current2.arrivalTime;
							SJF2.Remove();
						}
						else
						{
							time = current2.arrivalTime;
							avgResponse += time - current2.arrivalTime;
							time = time + current2.jobTime;
							turnAround += time - current2.arrivalTime;
							SJF2.Remove();
						}
					}

				}

			}

			Console.WriteLine(" The Results for the SJF Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();


			waitingQueue<Job2> RoundRobinProccessing2 = new waitingQueue<Job2>(2000);
			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current2 = RoundRobin502.Front();
			time = current2.arrivalTime;
			RoundRobinProccessing2.Add(current2);

			while (!RoundRobin502.IsEmpty() || !RoundRobinProccessing2.IsEmpty())
			{

				if (RoundRobinProccessing2.IsEmpty())
				{
					current2 = RoundRobin502.Front();
					time = current2.arrivalTime;
					RoundRobin502.Remove();
					RoundRobinProccessing2.Add(current2);
				}
				else
				{
					current2 = RoundRobinProccessing2.Front();
				}
				if (!RoundRobin502.IsEmpty())
				{
					while (time >= RoundRobin502.Front().arrivedAt)
					{
						RoundRobinProccessing2.Add(RoundRobin502.Front());
						RoundRobin502.Remove();
						if (RoundRobin502.IsEmpty())
							break;
					}
				}
				if (current2.jobTime < 50)
				{
					if (current2.respondedTO == false)
					{
						avgResponse += time - current2.arrivedAt;
					}
					time = time + current2.jobTime;
					RoundRobinProccessing2.Remove();
					turnAround += time - current2.arrivedAt;
				}
				else
				{
					if (current2.respondedTO == false)
					{
						avgResponse += time - current2.arrivedAt;
						current2.respondedTO = true;
					}

					current2.jobTime = current2.jobTime - 50;
					time = time + 50;
					current2.arrivalTime = time;
					RoundRobinProccessing2.Remove();
					RoundRobinProccessing2.Add(current2);


				}
				



			}

			Console.WriteLine(" The Results for the Round Robin Queue 50 with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();


			RoundRobinProccessing2 = new waitingQueue<Job2>(2000);
			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current2 = RoundRobin752.Front();
			time = current2.arrivalTime;
			RoundRobinProccessing2.Add(current2);

			while (!RoundRobin752.IsEmpty() || !RoundRobinProccessing2.IsEmpty())
			{

				if (RoundRobinProccessing2.IsEmpty())
				{
					current2 = RoundRobin752.Front();
					time = current2.arrivalTime;
					RoundRobin752.Remove();
					RoundRobinProccessing2.Add(current2);
				}
				else
				{
					current2 = RoundRobinProccessing2.Front();
				}
				if (!RoundRobin752.IsEmpty())
				{
					while (time >= RoundRobin752.Front().arrivedAt)
					{
						RoundRobinProccessing2.Add(RoundRobin752.Front());
						RoundRobin752.Remove();
						if (RoundRobin752.IsEmpty())
							break;
					}
				}
				if (current2.jobTime < 75)
				{
					if (current2.respondedTO == false)
					{
						avgResponse += time - current2.arrivedAt;
					}
					time = time + current.jobTime;
					RoundRobinProccessing2.Remove();
					turnAround += time - current2.arrivedAt;
				}
				else
				{
					if (current2.respondedTO == false)
					{
						avgResponse += time - current2.arrivedAt;
						current2.respondedTO = true;
					}

					current2.jobTime = current2.jobTime - 75;
					time = time + 75;
					current2.arrivalTime = time;
					RoundRobinProccessing2.Remove();
					RoundRobinProccessing2.Add(current2);


				}
				



			}
			Console.WriteLine(" The Results for the Round Robin Queue 75 with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();

			PriorityQueue<Job2> STCFProccessing2 = new PriorityQueue<Job2>(1000);


			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current2 = STCF2.Front();
			time = current2.arrivalTime;
			STCFProccessing2.Add(current2);

			while (STCF2.IsEmpty() == false || STCFProccessing2.Empty() == false)
			{

				if (STCFProccessing2.Empty())
				{
					current2 = STCF2.Front();
					time = current2.arrivalTime;
					STCF2.Remove();
					STCFProccessing2.Add(current2);
				}
				else
				{
					current2 = STCFProccessing2.Front();
				}
				if (current2.jobTime < 40)
				{
					if (current2.respondedTO == false)
					{
						avgResponse += time - current2.arrivedAt;
					}
					time = time + current2.jobTime;
					STCFProccessing2.Remove();
					turnAround += time - current2.arrivedAt;
				}
				else
				{
					if (current2.respondedTO == false)
					{
						avgResponse += time - current2.arrivedAt;
						current2.respondedTO = true;
					}

					current2.jobTime = current2.jobTime - 40;
					time = time + 40;
					current2.arrivalTime = time;
					STCFProccessing2.Remove();
					STCFProccessing2.Add(current2);
				}
				if (!STCF2.IsEmpty())
				{
					while (time >= STCF2.Front().arrivedAt)
					{
						STCFProccessing2.Add(STCF2.Front());
						STCF2.Remove();
						if (STCF2.IsEmpty())
							break;
					}
				}
			}

			Console.WriteLine(" The Results for the STCF Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();
			
			///////////////////////////////////////////////////////////////////////////////////////////////////////
			Console.WriteLine("For the third type of Job");
			Console.WriteLine();

			time = 0;

			waitingQueue<Job3> FIFO3 = new waitingQueue<Job3>(1000);
			waitingQueue<Job3> SJF3 = new waitingQueue<Job3>(1000);
			waitingQueue<Job3> STCF3 = new waitingQueue<Job3>(1000);
			waitingQueue<Job3> RoundRobin503 = new waitingQueue<Job3>(1000);
			waitingQueue<Job3> RoundRobin753 = new waitingQueue<Job3>(1000);
			Job3 current3;

			for (int i = 0; i < 1000; i++)
			{
				double u1 = 1.0 - r.NextDouble(); //uniform(0,1] random doubles
				double u2 = 1.0 - r.NextDouble();
				double randStdNormal = Math.Sqrt(-2.0 * Math.Log(u1)) *
							 Math.Sin(2.0 * Math.PI * u2); //random normal(0,1)
				double randNormal =
							 160 + 15 * randStdNormal; //random normal(mean,stdDev^2)

				time = time + randNormal;
				Job3 a = new Job3(time, r);
				FIFO3.Add(a);
				SJF3.Add(a);
				STCF3.Add(a.Clone());
				RoundRobin753.Add(a.Clone());
				RoundRobin503.Add(a);
			}

			time = FIFO3.Front().arrivalTime;
			avgResponse = 0;
			turnAround = 0;

			while (FIFO3.IsEmpty() == false)
			{
				current3 = FIFO3.Front();

				if (time >= current3.arrivalTime)
				{
					avgResponse += time - current3.arrivalTime;
					time = time + current3.jobTime;
					turnAround += time - current3.arrivalTime;
					FIFO3.Remove();
				}
				else
				{
					time = current3.arrivalTime;
					avgResponse += time - current3.arrivalTime;
					time = time + current3.jobTime;
					turnAround += time - current3.arrivalTime;
					FIFO3.Remove();
				}
			}
			Console.WriteLine(" The Results for the FIFO Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();

			PriorityQueue<Job3> priorityQueueSJF3 = new PriorityQueue<Job3>(1000);

			time = 0;
			avgResponse = 0;
			turnAround = 0;
			while (SJF3.IsEmpty() == false || priorityQueueSJF3.Empty() == false)
			{
				if (!SJF3.IsEmpty())
				{
					while (SJF3.Front().arrivalTime <= time)
					{
						priorityQueueSJF3.Add(SJF3.Front());
						SJF3.Remove();
						if (SJF3.IsEmpty() == true)
							break;

					}
				}
				if (priorityQueueSJF3.Empty() == false)
				{
					current3 = priorityQueueSJF3.Front();
					avgResponse += time - current3.arrivalTime;
					time = time + current3.jobTime;
					turnAround += time - current3.arrivalTime;
					priorityQueueSJF3.Remove();
				}
				else
				{
					if (SJF3.IsEmpty() == false)
					{
						current3 = SJF3.Front();
						if (time >= current3.arrivalTime)
						{
							avgResponse += time - current3.arrivalTime;
							time = time + current3.jobTime;
							turnAround += time - current3.arrivalTime;
							SJF3.Remove();
						}
						else
						{
							time = current3.arrivalTime;
							avgResponse += time - current3.arrivalTime;
							time = time + current3.jobTime;
							turnAround += time - current3.arrivalTime;
							SJF3.Remove();
						}
					}

				}

			}

			Console.WriteLine(" The Results for the SJF Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();


			waitingQueue<Job3> RoundRobinProccessing3 = new waitingQueue<Job3>(2000);
			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current3 = RoundRobin503.Front();
			time = current3.arrivalTime;
			RoundRobinProccessing3.Add(current3);

			while (!RoundRobin503.IsEmpty() || !RoundRobinProccessing3.IsEmpty())
			{

				if (RoundRobinProccessing3.IsEmpty())
				{
					current3 = RoundRobin503.Front();
					time = current3.arrivalTime;
					RoundRobin503.Remove();
					RoundRobinProccessing3.Add(current3);
				}
				else
				{
					current3 = RoundRobinProccessing3.Front();
				}
				if (!RoundRobin503.IsEmpty())
				{
					while (time >= RoundRobin503.Front().arrivedAt)
					{
						RoundRobinProccessing3.Add(RoundRobin503.Front());
						RoundRobin503.Remove();
						if (RoundRobin503.IsEmpty())
							break;
					}
				}
				if (current3.jobTime < 50)
				{
					if (current3.respondedTO == false)
					{
						avgResponse += time - current3.arrivedAt;
					}
					time = time + current3.jobTime;
					RoundRobinProccessing3.Remove();
					turnAround += time - current3.arrivedAt;
				}
				else
				{
					if (current3.respondedTO == false)
					{
						avgResponse += time - current3.arrivedAt;
						current3.respondedTO = true;
					}

					current3.jobTime = current3.jobTime - 50;
					time = time + 50;
					current3.arrivalTime = time;
					RoundRobinProccessing3.Remove();
					RoundRobinProccessing3.Add(current3);


				}
				



			}

			Console.WriteLine(" The Results for the Round Robin Queue 50 with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();


			RoundRobinProccessing3 = new waitingQueue<Job3>(2000);
			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current3 = RoundRobin753.Front();
			time = current3.arrivalTime;
			RoundRobinProccessing3.Add(current3);

			while (!RoundRobin753.IsEmpty() || !RoundRobinProccessing3.IsEmpty())
			{

				if (RoundRobinProccessing3.IsEmpty())
				{
					current3 = RoundRobin753.Front();
					time = current3.arrivalTime;
					RoundRobin753.Remove();
					RoundRobinProccessing3.Add(current3);
				}
				else
				{
					current3 = RoundRobinProccessing3.Front();
				}
				if(!RoundRobin753.IsEmpty())
				{
					while (time >= RoundRobin753.Front().arrivedAt)
					{
						RoundRobinProccessing3.Add(RoundRobin753.Front());
						RoundRobin753.Remove();
						if (RoundRobin753.IsEmpty())
							break;
					}
				}
				if (current3.jobTime < 75)
				{
					if (current3.respondedTO == false)
					{
						avgResponse += time - current3.arrivedAt;
					}
					time = time + current.jobTime;
					RoundRobinProccessing3.Remove();
					turnAround += time - current3.arrivedAt;
				}
				else
				{
					if (current3.respondedTO == false)
					{
						avgResponse += time - current3.arrivedAt;
						current3.respondedTO = true;
					}

					current3.jobTime = current3.jobTime - 75;
					time = time + 75;
					current3.arrivalTime = time;
					RoundRobinProccessing3.Remove();
					RoundRobinProccessing3.Add(current3);


				}
				

			}
			Console.WriteLine(" The Results for the Round Robin Queue 75 with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();

			PriorityQueue<Job3> STCFProccessing3 = new PriorityQueue<Job3>(1000);


			time = 0;
			avgResponse = 0;
			turnAround = 0;

			current3 = STCF3.Front();
			time = current3.arrivalTime;
			STCFProccessing3.Add(current3);

			while (STCF3.IsEmpty() == false || STCFProccessing3.Empty() == false)
			{

				if (STCFProccessing3.Empty())
				{
					current3 = STCF3.Front();
					time = current3.arrivalTime;
					STCF3.Remove();
					STCFProccessing3.Add(current3);
				}
				else
				{
					current3 = STCFProccessing3.Front();
				}
				if (current3.jobTime < 40)
				{
					if (current3.respondedTO == false)
					{
						avgResponse += time - current3.arrivedAt;
					}
					time = time + current3.jobTime;
					STCFProccessing3.Remove();
					turnAround += time - current3.arrivedAt;
				}
				else
				{
					if (current3.respondedTO == false)
					{
						avgResponse += time - current3.arrivedAt;
						current3.respondedTO = true;
					}

					current3.jobTime = current3.jobTime - 40;
					time = time + 40;
					current3.arrivalTime = time;
					STCFProccessing3.Remove();
					STCFProccessing3.Add(current3);
				}
				if (!STCF3.IsEmpty())
				{
					while (time >= STCF3.Front().arrivedAt)
					{
						STCFProccessing3.Add(STCF3.Front());
						STCF3.Remove();
						if (STCF3.IsEmpty())
							break;
					}
				}
			}

			Console.WriteLine(" The Results for the STCF Queue with Job allocation 1 are:");
			Console.WriteLine(" this average response time is: " + avgResponse / 1000);
			Console.WriteLine(" the average turn around time is: " + turnAround / 1000);
			Console.WriteLine();
			Console.Read();



		}
	}
}

