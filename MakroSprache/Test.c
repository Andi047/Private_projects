#include <stdio.h>
#include <stdint.h>

int main()
{
    /*
    uint8_t a = 15;
    uint8_t b = 14;

    int c = b - a;
    printf("%d\n",c);

    b = -b;
    a = -a;

    int d = b + a;
    printf("%d\n", d);
    */

    int arr[4];

    int result = 60;
    arr[0x00] = result;

    int arr_out = arr[0x00];
    printf("%d\n", arr_out);

    return 0;
}