#include <iostream>

using namespace std;

int Majority(int myArray[], int i, int j)
{
    int left, right, mid, num;

    if( (j - i) > 0)
    {    mid = (i+j)/2;
         left = Majority(myArray, i, mid);
         right = Majority(myArray, mid+1, j);
    }
    else
    {
        return myArray[j];
    }

    if(left == right)
    {
        return right;
    }

    if(left != -1)
    {
      num = 0;
      for (int k = i; k <=j; k++)
      {
        if ( myArray[k] == left)
        {
            num++;
        }
      }
      if( num > (j-i+1)/2)
        {
            return left;
        }
    }
    if( right != -1)
    {
        num =0;
        for (int k = i; k <=j; k++)
      {
        if ( myArray[k] == right)
        {
             num++;
        }
      }
      if( num > (j-i+1)/2)
        {
            return right;
        }
    }


        return -1;





}


int main()
{
    int a[] = { 4,2,4,4,8,4,3,4,4,8,1,4,4,8};
    int b[] = { 1,3,5,6,6,6};
    int c[] = { 52,6,3,6,6,6,7};
    cout << Majority(a,0,13) << endl;
    cout << Majority(b,0,5) << endl;
    cout << Majority(c,0,6) << endl;
    return 0;
}
