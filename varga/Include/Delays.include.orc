
/* Delays.include.orc - compatibility macros for .orc files using */
/* DeltapiHQ / Deltap3A (now replaced by deltapx opcode)          */

/* initialization macro */

#define InitHQDelay #

/* nothing to do */

#

/* high quality variable delay */

#define DeltapiHQ #

  a_        deltapx   a_1_, 8

#

/* faster replacement for DeltapiHQ */

#define Deltap3A #

  a_        deltapx   a_1_, 4

#

