#include <stdio.h>

#define PI 3.14
#define circleArea(r) (PI * (r) * (r))

int main() {
    printf("area = %f\n", circleArea(3 + 2));
    printf("area = %f\n", circleArea(3.5 + 2));
    return 0;
}
