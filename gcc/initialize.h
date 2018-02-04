#ifndef _INITIALIZE_H_
#define _INITIALIZE_H_

#include "mbed.h"

/**
  * Initialize the primary (sending board)
  * Sets out to high if successful
  */
short primary_init(DigitalOut out);


/**
  * Initialize the secondary (recieving board)
  * Sets out to high is successful
  */
short secondary_init(DigitalOut out);

#endif
