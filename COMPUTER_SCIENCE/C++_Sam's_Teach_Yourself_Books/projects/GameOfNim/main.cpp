#include <iostream>

using namespace std;

int numSticks = 21;
int removeSticks = 1;
bool playing = true;

int ComputerMove(int numSticks)
{
    int temp = 0;

    temp = numSticks - 5;

    if (temp > 0)
    {
    if (temp % 3 ==0)
    {
        temp = temp /3;

        if (temp % 2 == 0)
        {
        return 1;
        }
        if (temp % 2 != 0)
        {
        return 3;
        }
    }
    return temp % 3;

    }    switch (numSticks)
    {
        case 5:
            return 1;
        case 4:
            return 3;
        case 3:
            return 2;
        case 2:
            return 1;
        case 1:
            return 1;
        default:
            return 2;
    }




return 1;

}

int main()
{
bool input = true;

    while(playing)
    {
        while (input)
        {
            cout << " How many ticks would u like to remove (1-3)" << endl;
            cin >> removeSticks;
            if (removeSticks < 4 && removeSticks > 0)
            {
                input = false;
            }
        }
        input = true;

        numSticks = numSticks - removeSticks;

        cout << " There are " << numSticks << " remaining." << endl;

        if (numSticks <= 0)
        {
            cout << "The computer Wins" << endl;
            break;
        }

        numSticks = numSticks - ComputerMove(numSticks);
        cout << " There are " << numSticks << " remaining after computer move" << endl;


        if (numSticks <= 0)
        {
            cout << " you win";
            playing = false;
        }
    }

}
