#include <stdio.h>
#include <stdlib.h>

int main()
{
    float a,b,c,result;
    a = 0.0000000000009;
    b = 0.0000000000002;
    c = 0.0000000000003;

    result = a + (b+c);
    printf("the result of a + (b+c) is: %.14f \n",result);

    result = (a+b)+c;
    printf("the result of (a+b)+c is %.14f",result);
    return 0;

    // in this program it works with a very small decimal
}
