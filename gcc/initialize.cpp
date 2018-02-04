#include "mbed.h"

short primary_init(DigitalOut outPin) {
     
    outPin = 1;
    return 0;   
}

short secondary_init(DigitalOut outPin) {
    
    outPin = 1;
    return 0;   
}
