using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Cios2020Assignment2;

namespace Cios2020Assignment2
{

    public class Job
    {
        public int number { get; set; } // job number 0 if inturupt
        public int processors { get; set; } // number or proccessors needed / processor to be inturrupted if inturupt
        public int time { get; set; } // time it takes to exicute the proccess


        public Job(int n, int T, int P, Random r) // job constructor
        {
           
            number = n;
            processors = r.Next(1, P+1);
            time = Convert.ToInt32(-(T ) * Math.Log(r.NextDouble()));

        }

    }

    public class Pevent : IComparable 
    {
        public enum Jobtype { Arrival, Departure, IArrival, IDeparture }; // job types

        public Job job { get; set; } // job corresponding to the event
        public Jobtype type { get; set; } // type of event
        public int time { get; set; } // time the event occors
        public int processor { get; set; } // processor to be assigned to / 0 if unassigned

        public Pevent(Job job, Jobtype type, int time) // constructor unassigned processor
        {
            this.job = job;
            this.type = type;
            this.time = time;
            processor = 0;
        }
        public Pevent(Job job, Jobtype type, int time, int proccessor) // constructor assigned processor
        {
            this.job = job;
            this.type = type;
            this.time = time;
            this.processor = proccessor;
        }

        public int CompareTo(object obj) // compare to method based on when event occurs (could be further expressed for priority of job types not specified)
        {

            Pevent e = (Pevent)obj;


            return   e.time - this.time;

        }

        public override bool Equals(Object obj) // equals method only needed to find departure events exicuting on a certian processor
        {
            Pevent P = (Pevent)obj;
            if( P.type == Pevent.Jobtype.Departure)
            {
                return this.job.processors == P.processor;
            }
            return false;



        }

        public String getTime() // get time method convers seconds to hours minutes seconds
        {
            double h = Math.Floor(Convert.ToDouble( time/ 3600 ));
            double m = Math.Floor(Convert.ToDouble((time - (h*3600)) / 60 ));
            double s = Math.Floor(Convert.ToDouble(time % 60)) ;
            if(s < 10 && m < 10)
            {
                return "time: " + h + ":0" + m + ":0" + s;
            }
            else if( s < 10)
            {
                return "time: " + h + ":" + m + ":0" + s;
            }
            else if (m < 10)
            {
                return "time: " + h + ":0" + m + ":" + s;
            }
            return "time: " + h + ":" +m+ ":" + s;
        }
    }

    public class waitingQueue<T>
    {
        private T[] A;
        private int capacity { get; set; }
        private int count { get; set; }
        private int head;
        private int tail;
        public waitingQueue(int size)
        {
            capacity = size;
            A = new T[size];
            count = 0;
            head = 0;
            tail = 0;
        }

        public void Remove()
        {
            head++;
            count--;
        }

        public void Add(T item)
        {
            if (count < capacity)
            {
                count++;
                if (tail == capacity)
                {
                    tail = 0;
                    A[tail] = item;
                    tail++;
                }
                else
                {
                    A[tail] = item;
                    tail++;
                }
                
            }
            else
            {
                Console.WriteLine(" queue size exceeded "); 
            }

        }

        public T Front()
        {
            return A[head];
        }

        public Boolean IsEmpty()
        {
            return count == 0;
        }
    }


    public class Proccessor // processor class to keep track of processor activity
    {
        public enum Status { Active, Inactive, Interrupted } // states processor can be in
        public Status[] A; 
        public int cores;
        public int count {get; set;}

        public Proccessor(int cores) // constructor
        {
            this.cores = cores;
            A = new Status[cores+1]; // processor starting from array element 1
            count = 0;
            for(int i = 0; i <= cores; i++)
            {
                A[i] = Proccessor.Status.Inactive;
            }
        }

        public int NextAvailable() // method to find first avaiable processor
        {
            for(int i = 1; i < cores+1; i++)
            {
                if(A[i] == Proccessor.Status.Inactive)
                {
                    return i;
                }
            }
            return -1;
        }

        public void Activate(int core) // activate a processor
        {
            A[core] = Proccessor.Status.Active;
            count++;
        }
        public void DeActivate(int core) // deactivate a processor
        {
            A[core] = Proccessor.Status.Inactive;
            count--;
        }
        public void Inturupt(int core) // inturput a processor
        {
            if (A[core] == Proccessor.Status.Inactive)
            {
                A[core] = Proccessor.Status.Interrupted;
                count++;
            }
            else
            {
                A[core] = Proccessor.Status.Interrupted;
            }
        }

        public bool IsFull() // are all processors exicuting a event
        {
            return count == cores;
        }
        public Status getStatus(int i) // status of a processor
        {
            return A[i];
        }
        public void Print() // dispaly status of a processor (0 inactive) (1 active) (// inturpted)
        {
            for(int i = 1; i < cores+1; i ++)
            {
                if (A[i] == Status.Active)
                    Console.Write(1 + " ");

                if (A[i] == Status.Inactive)
                    Console.Write(0+ " ");
                if (A[i] == Status.Interrupted)
                    Console.Write("// ");
            }
            Console.WriteLine();
        }

    }
    public interface IContainer<T>
    {
        void MakeEmpty();  // Reset an instance to empty
        bool Empty();      // Test if an instance is empty
        int Size();        // Return the number of items in an instance
    }

    //-----------------------------------------------------------------------------

    public interface IPriorityQueue<T> : IContainer<T> where T : IComparable
    {
        void Add(T item);  // Add an item to a priority queue
        void Remove();     // Remove the item with the highest priority
        T Front();         // Return the item with the highest priority
    }

    //-------------------------------------------------------------------------

    // Priority Queue
    // Implementation:  Binary heap

    public class PriorityQueue<T> : IPriorityQueue<T> where T : IComparable // prolly should have IEquatable too but for the specific task..
    {
        private int capacity { get; set; }  // Maximum number of items in a priority queue
        private T[] A;         // Array of items
        private int count { get; set; }     // Number of items in a priority queue

        public PriorityQueue(int size)
        {
            capacity = size;
            A = new T[size + 1];  // Indexing begins at 1
            count = 0;
        }

        // Percolate up from position i in a priority queue

        private void PercolateUp(int i)
        // (Worst case) time complexity: O(log n)
        {
            int child = i, parent;

            while (child > 1)
            {
                parent = child / 2;
                if (A[child].CompareTo(A[parent]) > 0)
                // If child has a higher priority than parent
                {
                    // Swap parent and child
                    T item = A[child];
                    A[child] = A[parent];
                    A[parent] = item;
                    child = parent;  // Move up child index to parent index
                }
                else
                    // Item is in its proper position
                    return;
            }
        }

        public void Add(T item)
        // Time complexity: O(log n)
        {
            if (count < capacity)
            {
                A[++count] = item;  // Place item at the next available position
                PercolateUp(count);
            }
        }

        

        // Percolate down from position i in a priority queue

        private void PercolateDown(int i)
        // Time complexity: O(log n)
        {
            int parent = i, child;

            while (2 * parent <= count)
            // while parent has at least one child
            {
                // Select the child with the highest priority
                child = 2 * parent;    // Left child index
                if (child < count)  // Right child also exists
                    if (A[child + 1].CompareTo(A[child]) > 0)
                        // Right child has a higher priority than left child
                        child++;

                if (A[child].CompareTo(A[parent]) > 0)
                // If child has a higher priority than parent
                {
                    // Swap parent and child
                    T item = A[child];
                    A[child] = A[parent];
                    A[parent] = item;
                    parent = child;  // Move down parent index to child index
                }
                else
                    // Item is in its proper place
                    return;
            }
        }

        public void Remove()
        // Time complexity: O(log n)
        {
            if (!Empty())
            {
                // Remove item with highest priority (root) and
                // replace it with the last item
                A[1] = A[count--];

                // Percolate down the new root item
                PercolateDown(1);
            }
        }

        public T RemoveItem(T item) // method to remove a element
        {


            int j = 1;
            T myitem = default(T);
            while (j < count)
            {
                if (item.Equals(A[j])) // when item is found
                {
                    myitem = A[j]; // set myitem 
                    A[j] = A[count]; // replace element with last element
                    count--; // reduce count
                    PercolateDown(j); // percalate both up and down because the one will return and do nothing so no need to check 
                    PercolateUp(j);
                    return myitem; // return the item to be removed
                }
                j++;
            }
            return myitem; // returns null if item is not in the priority que should never happen 
        }

        public T Front()
        // Time complexity: O(1)
        {
            if (!Empty())
            {
                return A[1];  // Return the root item (highest priority)
            }
            else
                return default(T);
        }
        public T Bottom()
        {
            if (!Empty())
            {
                return A[count];  // Return the root item (highest priority)
            }
            else
                return default(T);
        }

        public int getCapacity()
        {
            return capacity;
        }
        public int getCount()
        {
            return count;
        }

        // Create a binary heap
        // Percolate down from the last parent to the root (first parent)

        private void BuildHeap()
        // Time complexity: O(n)
        {
            int i;
            for (i = count / 2; i >= 1; i--)
            {
                PercolateDown(i);
            }
        }

        // Sorts and returns the InputArray

        public void HeapSort(T[] inputArray)
        // Time complexity: O(n log n)
        {
            int i;

            capacity = count = inputArray.Length;

            // Copy input array to A (indexed from 1)
            for (i = capacity - 1; i >= 0; i--)
            {
                A[i + 1] = inputArray[i];
            }

            // Create a binary heap
            BuildHeap();

            // Remove the next item and place it into the input (output) array
            for (i = 0; i < capacity; i++)
            {
                inputArray[i] = Front();
                Remove();
            }
        }

        public void MakeEmpty()
        // Time complexity: O(1)
        {
            count = 0;
        }

        public bool Empty()
        // Time complexity: O(1)
        {
            return count == 0;
        }

        public int Size()
        // Time complexity: O(1)
        {
            return count;
        }
    }
}

class Program
{
    static void Main(string[] args)
    {
        int simulationLength = 2 * 60 * 60;  // simulation length is seconds
        int M = 20; // set mean job arrival time
        int P = 5; // set max number of processors
        int T = 20; // set mean exicution time

        // declare needed variables
        waitingQueue<Pevent> wQueue = new waitingQueue<Pevent>(5000);
        PriorityQueue<Pevent> pQueue = new PriorityQueue<Pevent>(5000);
        Random r = new Random();
        Proccessor cores = new Proccessor(P);
        int time = 0;
        Job nextJob;
        Pevent newEvent, currentEvent;
        int jobnum = 0;
        double regJob = 0;
        double intJob = 0;        
        int AvailabelCore;
        double waitTime = 0;
        Random random = new Random();

        // creation of event list ( doesnt say to do this in assignment but its better and common practice for discrete event simulation


        // https://www.cs.cmu.edu/~music/cmsip/readings/intro-discrete-event-sim.html
        //        Implementation of Discrete Event Simulation

        //Operationally, a discrete -event simulation is a chronologically nondecreasing sequence of event occurrences.

        //event record:
        //a pairing of an event with its event time
        //future event list (FEL) (or just event list):
        //a list ordered by nondecreasing simulation time (e.g., in a priority queue)
        //event (list) driven simulation:
        //simulation where time is advanced to the time given by the first event record from the event list
        //Requirements for support of discrete-event simulation:

        //maintain a future event list
        //enable event record creation and insertion into and deletion from event list
        //maintain simulation clock
        //(for stochastic simulations) provide utilities to generate random numbers from common probability distributions
        while (true)
        {
            time = time + Convert.ToInt32(Math.Round(-M * Math.Log(r.NextDouble())));
            if (time > simulationLength)
                break;
            jobnum++;

            if (r.NextDouble() < 0.9)
            {

                nextJob = new Job(jobnum, T, P, random);
                regJob++;
                for (int i = 0; i < nextJob.processors; i++)
                {
                    newEvent = new Pevent(nextJob, Pevent.Jobtype.Arrival, time);
                    pQueue.Add(newEvent);

                }
            }
            else
            {
                nextJob = new Job(0, T, P, random);
                newEvent = new Pevent(nextJob, Pevent.Jobtype.IArrival, time, nextJob.processors);
                pQueue.Add(newEvent);
                intJob++;

            }


        }
        // TEST SCINARIO 

        //nextJob = new Job(1, T, P,random);
        //nextJob.time = 30;
        //nextJob.processors = 5;
        //time = 30;
        //for (int i = 0; i < nextJob.processors; i++)
        //{
        //    newEvent = new Pevent(nextJob, Pevent.Jobtype.Arrival, time);
        //    pQueue.Add(newEvent);
        //}
        //nextJob = new Job(2, T, P,random);
        //nextJob.time = 60;
        //nextJob.processors = 3;
        //time = 40;
        //for (int i = 0; i < nextJob.processors; i++)
        //{
        //    newEvent = new Pevent(nextJob, Pevent.Jobtype.Arrival, time);
        //    pQueue.Add(newEvent);
        //}
        //nextJob = new Job(0, T, P,random);
        //nextJob.time = 35;
        //nextJob.processors = 4;
        //time = 45;
        //newEvent = new Pevent(nextJob, Pevent.Jobtype.IArrival, time);
        //pQueue.Add(newEvent);

        //nextJob = new Job(0, T, P, random);
        //nextJob.time = 35;
        //nextJob.processors = 4;
        //time = 60;
        //newEvent = new Pevent(nextJob, Pevent.Jobtype.IArrival, time);
        //pQueue.Add(newEvent);

        //nextJob = new Job(3, T, P,random);
        //nextJob.time = 40;
        //nextJob.processors = 4;
        //time = 115;
        //for (int i = 0; i < nextJob.processors; i++)
        //{
        //    newEvent = new Pevent(nextJob, Pevent.Jobtype.Arrival, time);
        //    pQueue.Add(newEvent);
        //}
        //nextJob = new Job(4, T, P,random);
        //nextJob.time = 50;
        //nextJob.processors = 3;
        //time = 125;
        //for (int i = 0; i < nextJob.processors; i++)
        //{
        //    newEvent = new Pevent(nextJob, Pevent.Jobtype.Arrival, time);
        //    pQueue.Add(newEvent);
        //}

        //regJob = 4;
        //intJob = 2;
        // processing of events


        while ( !pQueue.Empty())
        {
            
            currentEvent = pQueue.Front(); // get next event
            pQueue.Remove(); // remove it from the priority queue
            time = currentEvent.time; // update simulation clock
            
            Console.WriteLine(currentEvent.getTime()); // display time

            

            // proccess Arrival event
            if (currentEvent.type == Pevent.Jobtype.Arrival)
            {
                Console.WriteLine("arrival"); // display job type
                if (!cores.IsFull()) // check if all processors are active
                { 
                    // if not 
                    AvailabelCore = cores.NextAvailable(); // get first available processor
                    newEvent = new Pevent(currentEvent.job, Pevent.Jobtype.Departure, time + currentEvent.job.time,AvailabelCore); // create new departure
                    cores.Activate(AvailabelCore); // activate the core
                    pQueue.Add(newEvent); // add departure
                    Console.WriteLine("Job " + newEvent.job.number + " Arrives and is assigned to proccesor " + AvailabelCore); // display update
                  
                }
                else
                {
                    // if full
                    wQueue.Add(currentEvent); // add event to waiting queue
                    Console.WriteLine("job " + currentEvent.job.number + " Arrives and is assigned to the waitingQueue"); // display update
                }
            }


            // process departure event
                if(currentEvent.type == Pevent.Jobtype.Departure)
                {
                
                Console.WriteLine("departure"); // display status type
                cores.DeActivate(currentEvent.processor); // deactivate processor
                Console.WriteLine("Job " + currentEvent.job.number + " has finished exicution on proccessor " + currentEvent.processor);
                    if( !wQueue.IsEmpty()) // if a event is in waiting queue
                    {
                       
                        waitTime = waitTime + currentEvent.time - wQueue.Front().time; // caculate how long it waited and add it to total wait time
                        newEvent = new Pevent(wQueue.Front().job, Pevent.Jobtype.Departure, time + wQueue.Front().job.time,currentEvent.processor); // create new departure event
                        cores.Activate(newEvent.processor); // activate processor
                        wQueue.Remove(); // remove from waiting queue
                        pQueue.Add(newEvent); // add departure to priority queue
                        Console.WriteLine("Job " + newEvent.job.number + " is removed form the waiting que and assigned to proccesor "+ currentEvent.processor); // update status
                    }

                    
                 
                }

            // process Inturupt Event

            if (currentEvent.type == Pevent.Jobtype.IArrival)
            {
                Console.WriteLine("interupt"); // display event type 
                if (cores.getStatus(currentEvent.job.processors) != Proccessor.Status.Interrupted ) // if processor is exicuting a inturupt
                {
                    if (cores.getStatus(currentEvent.job.processors) == Proccessor.Status.Active) // if a process is exicuting on the processor
                    {
                        newEvent = pQueue.RemoveItem(currentEvent); // remove the departure event
                        Console.WriteLine("Inturupt for Proccesor " + currentEvent.job.processors + " exicuted job " + newEvent.job.number + " is placed in waiting Q"); // display status
                        newEvent.job.time = newEvent.time - currentEvent.time; // decrease exicution time by time it has been exicuting
                        newEvent.type = Pevent.Jobtype.Arrival; // change job type back to arrival
                        newEvent.time = currentEvent.time; // set its arrival time to current time
                        wQueue.Add(newEvent); // add it back to waiting queue
                        cores.Inturupt(newEvent.processor); // make processor status inturupted
                        newEvent = new Pevent(currentEvent.job, Pevent.Jobtype.Departure, time +currentEvent.job.time,currentEvent.job.processors); // create inturupt departure
                        pQueue.Add(newEvent); // add it to priority queue
                    }
                    else // no event is being exicuted
                    {
                        Console.WriteLine("interupt begins on proccesor " + currentEvent.job.processors); // update status
                        cores.Inturupt(currentEvent.processor); // set core status
                        newEvent = new Pevent(currentEvent.job, Pevent.Jobtype.Departure, time + currentEvent.job.time,currentEvent.job.processors); // create departure
                        pQueue.Add(newEvent); // add it to priority queue
                    }
                }
                else // processor is exicuting a intureupt  ignore the inturupt
                {
                    Console.WriteLine("Inturupt for proccessor " + currentEvent.job.processors + "Ignored");
                }
            }

            cores.Print(); // print cores status
            Console.WriteLine();

        }

        
        Console.WriteLine();
        Console.WriteLine(regJob + ": regular jobs arrived " + intJob + ": inturupt jobs occured"); // display number or reg jobs and inturupt jobs
 
        
            double totaltime = waitTime / regJob  ; // average waittime in seconds
         // convert to hours min seconds
        double h = Math.Floor(Convert.ToDouble(totaltime / 3600));
        double m = Math.Floor(Convert.ToDouble((totaltime - (h * 3600)) / 60));
        double s = Math.Floor(Convert.ToDouble(totaltime % 60));

        Console.WriteLine("average wait time: " + h + ":" + m + ":" + s); // display average waittime
        Console.ReadLine();
    }
    }

