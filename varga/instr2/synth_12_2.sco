
t       0       134.00  /*      tempo   */

#include "room.sco"

i 1 0.000     17.0   /*     ctrl   instr  */
i 80   0.000  17.0   /*     output instr  */
i 90   0.000  17.0

/* ------------------------------------------------------------------------- */

#include "fgen.h.sco"

/* sawtooth */

f 257 0     16384 7     1     16384 -1  ; sawtooth
$FGEN128(256'4096'257'1)

f 3 0 16384 20    2     1               ; window

e	/* end of score */

