#include <iostream>
#include <queue>


using namespace std;

 class Graph {

   int adjMatrix[10][10];
   int numVertex = 0;




    public: Graph(int n){

      numVertex = n;

        for(int i = 0; i < numVertex; i++)
        {
            for(int j = 0; j < numVertex; j++)
            {
                adjMatrix[i][j] = 0;
            }
        }
        return;
    }

     void addVertex(){

        numVertex++;

        for(int i = 0; i < numVertex; i++)
        {
            adjMatrix[i][numVertex] = 0;
            adjMatrix[numVertex][i] = 0;
        }
        return;
    }

    void addEdge(int x, int y){

        adjMatrix[x][y] = 1;
        adjMatrix[y][x] = 1;
        return;

    }

    void bfs(int currentVertex){

        bool visited[numVertex];
        int level[numVertex];
        int lvl = 0;

        for(int i = 0; i < numVertex; i++)
        {
            visited[i] = false;
            level[i]= -1;
        }

        std::queue<int> bfsQueue;
        bfsQueue.push(currentVertex);
        level[currentVertex] = lvl;
        visited[currentVertex] = true;
        lvl++;

        while(!bfsQueue.empty())
        {
        for(int i = 0; i < numVertex; i++)
        {
            if(adjMatrix[bfsQueue.front()][i] == 1 && !visited[i])
            {
                bfsQueue.push(i);
                level[i] = lvl;
                visited[i] = true;

            }
        }

        bfsQueue.pop();
        if(level[bfsQueue.front()] == lvl)
        {
            lvl++;
        }

        }

         for( int i = 0; i <numVertex; i++)
         {
             cout << "vertex: " << i  << " level: " << level[i] << endl;
         }

    }



};


int main()
{
    Graph g = Graph(5);
    g.addEdge(0,1);
    g.addEdge(0,2);
    g.addEdge(1,3);
    g.addEdge(3,4);
    g.addEdge(2,4);

    g.bfs(4);

}
