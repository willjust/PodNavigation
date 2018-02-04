#include "mbed.h"
#include "initialize.h"

char PRIMARY = 0;
DigitalOut initSucceed(PB_0);

int main() {
    if(PRIMARY) {
        primary_init(initSucceed);
    } else {
        secondary_init(initSucceed);    
    }
    return 0;   
}
