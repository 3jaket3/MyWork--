using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment1
{
    class Program
    {
        class WebServer
        {
            public string Name;
            private List<WebPage> P;

            public Webserver(string name)
            {
                Name = name;
                P = new List<WebPage>();
            }
        }

        class ServerGraph
        {
            public WebServer[] S;
            private int[,] E;
            private int NumServers;
            private int MaxNumServers;

            public ServerGraph(int maxNumServers)
            {
                NumServers = 0;
                MaxNumServers = maxNumServers;
                S = new WebServer[maxNumServers];
                E = new int[maxNumServers, maxNumServers];
            }

            private int FindWebServer(string name)
            {
                for(int i = 0; i < NumServers; i++)
                {
                    if(S[i].Name.Equals(name))
                    {
                        return i;
                    }
                }
                return -1;
            }

            public void AddServer(string name)
            {
                int i;
                if (NumServers < MaxNumServers && FindWebServer(name) == -1)
                {
                    S[NumServers] = new WebServer(name);

                    for(i = 0; i <= NumServers; i++)
                    {
                        E[i, NumServers] = -1;
                        E[NumServers, i] = -1;
                    }
                    NumServers++;
                }
            }

            public void RemoveServer(string name)
            {
                int i, j;
                if((i = FindWebServer(name)) > -1)
                {
                    NumServers--;
                    S[i] = S[NumServers];

                    for(j = NumServers; j >=0; j--)
                    {
                        E[j, i] = E[j, NumServers];
                        E[i, j] = E[NumServers, j];
                    }
                }
            }

            public void AddLink(string from,string to)
            {
                int i, j;
                if((i = FindWebServer(name)) > -1 && (j = FindWebServer(to)) >-1)
                {
                    if (E[i, j] == -1)
                        E[i, j] = 1;
                    if (E[j, i] == -1)
                        E[j, i] == 1;
                }
            }

            public void RemoveLink(string from, string to)
            {
                int i, j;
                if((i = FindWebServer(from) ) > -1 && (j = FindWebServer(to) )>-1)
                {
                    E[i, j] = -1;
                    E[j, i] = -1;
                }

            }


            public bool Connected()
            {
                int i;
                bool[] visited = new bool[NumServers];
                Stack MyStack = new Stack();
                int count = 1;

                for(i = 0; i < NumServers; i++)
                {
                    visited[i] = false;
                }
                int j;
                i = 0;
                visited[i] = 0;
                MyStack.Push(i);

                while (MyStack.Count != 0)
                {
                    i = (int)MyStack.Peek();
                    for ( j = 0; j < NumServers; j++)
                    {
                        if(!visited[j] && E[i,j] > -1)
                        {
                            count++;
                            MyStack.Push(j);
                            visited[j] = true;
                            i = j;
                            j = 0;
                        }
                    }
                    MyStack.Pop();
                }
                if (count == NumServers)
                    return true;

                return false;
            }

            public string[] ArticulationPoints()
            {
                int i;
                int index = 0;
                int[] order = new int[NumServers];
                int[] lowlink = new int[NumServers];
                int[] parent = new int[NumServers];
                string[] Apoints = new string[NumServers];
                Stack myStack = new Stack();

                for(i = 0; i < NumServers; i++)
                {
                    order[i] = -1;
                    lowlink[i] = -1;
                    parents[i] = -1;
                    Apoints[i] = null;
                }

                int j;
                i = 0;
                order[i] = 0;
                lowlink[i] = 0;
                parent[i] = -1;
                myStack.Push(i);

                while(myStack.Count != 0)
                {
                    i = (int)myStack.Peek();
                    for( j =0; j < NumServers; j++)
                    {
                        if((order[j] == -1) && (E[i,j] > -1))
                        {
                            index++;
                            order[j] = index;
                            parent[j] = i;
                            lowlink[j] = index;
                            myStack.Push(j);
                            i = j;
                            j = 0;
                        }

                        if(order[j] != -1 && parent[i] != j && E[i,j] > -1)
                        {
                            if(order[i] <= lowlink[j] && i != 0)
                            {
                                Apoints[i] = S[i].Name;
                            }
                            lowlink[i] = Math.Min(lowlink[j], lowlink[i]);

                        }
                    }
                    myStack.Pop();
                }

                int RootChildren = 0;
                for (i = 1; i < NumServers; i++)
                {
                    if (parent[i] == 0)
                    {
                        RootChildren++;
                    }
                }

            }



        }


        static void Main(string[] args)
        {
        }
    }
}
