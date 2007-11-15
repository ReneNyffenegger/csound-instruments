
t       0       170.00  /*      tempo   */

i 90   0      2.0    /*     output instrument    */ 

i 1 0.0000    0.4000 32     127 

/* ------------------------------------------------------------------------- */

f 64  0     128   -2    3000.0      /*    output      volume      */   
      170.0 /*    tempo */

                        4.3333  /*      oscillator      start   freq.   1       /       note    frq.    */ 
                        10.0    /*      osc.    frq.    1       decay   speed   at      max.    vel.    */ 
                        16.0    /*      osc.    freq.   1       max.    decay   speed   */
                        96      /*      note    velocity        for     max.    decay   speed   */
                        1.0     /*      oscillator      start   freq.   2       /       note    frq.    */ 
                        2.0     /*      osc.    freq.   2       decay   speed   */
                        2.6666  /*      oscillator      start   freq.   3       /       note    frq.    */ 
                        128.0   /*      osc.    freq.   3       decay   speed   */
                        0.0     /*      oscillator      start   freq.   4       /       note    frq.    */ 
                        1.0     /*      osc.    freq.   4       decay   speed   */

                        0       /*      lowpass filter  start   freq.   1       (Hz)    */ 
                        1       /*      lowpass filter  freq.   1       decay   speed   */
                        0       /*      lowpass filter  start   freq.   2       (Hz)    */ 
                        1       /*      lowpass filter  freq.   2       decay   speed   */
                        48.0    /*      LP      filter  start   freq.   3       /       note    frq.    */ 
                        64.0    /*      lowpass filter  freq.   3       decay   speed   */
                        16.0    /*      LP      filter  start   freq.   4       /       note    frq.    */ 
                        12.0    /*      lowpass filter  freq.   4       decay   speed   */

                        0       /*      EQ      1       frequency       /       osc.    frequency       */    
                        5.3333  /*      EQ      1       frequency       /       note    frequency       */    
                        0       /*      EQ      1       frequency       (Hz)    */ 
                        2.0     /*      EQ      1       level   */
                        0.7071  /*      EQ      1       Q       */    
                        1       /*      EQ      1       mode    (0:peak,1:low,2:high)   */

                        0       /*      EQ      2       frequency       /       osc.    frequency       */    
                        5.3333  /*      EQ      2       frequency       /       note    frequency       */    
                        0       /*      EQ      2       frequency       (Hz)    */ 
                        2.0     /*      EQ      2       level   */
                        0.7071  /*      EQ      2       Q       */    
                        1       /*      EQ      2       mode    (0:peak,1:low,2:high)   */

                        4       /*      EQ      3       frequency       /       osc.    frequency       */    
                        0       /*      EQ      3       frequency       /       note    frequency       */    
                        0       /*      EQ      3       frequency       (Hz)    */ 
                        4.0     /*      EQ      3       level   */
                        1.0     /*      EQ      3       Q       */    
                        2       /*      EQ      3       mode    (0:peak,1:low,2:high)   */

                        0       /*      EQ      4       frequency       /       osc.    frequency       */    
                        3       /*      EQ      4       frequency       /       note    frequency       */    
                        0       /*      EQ      4       frequency       (Hz)    */ 
                        0.125   /*      EQ      4       level   */
                        3.0     /*      EQ      4       Q       */    
                        0       /*      EQ      4       mode    (0:peak,1:low,2:high)   */

                        1.0     /*      noise   mix     */  

                        0       /*      noise   EQ      1       frequency       /       osc.    freq.   */
                        0       /*      noise   EQ      1       frequency       /       note    freq.   */
                        1000    /*      noise   EQ      1       frequency       (Hz)    */ 
                        1.0     /*      noise   EQ      1       level   */
                        0.7071  /*      noise   EQ      1       Q       */    
                        1       /*      noise   EQ      1       mode    (0:peak,1:lo,2:hi)      */   

                        0       /*      noise   EQ      2       frequency       /       osc.    freq.   */
                        0       /*      noise   EQ      2       frequency       /       note    freq.   */
                        1000    /*      noise   EQ      2       frequency       (Hz)    */ 
                        1.0     /*      noise   EQ      2       level   */
                        0.7071  /*      noise   EQ      2       Q       */    
                        0       /*      noise   EQ      2       mode    (0:peak,1:lo,2:hi)      */   

                        48      55      /*      MIDI    key     range   for     panning */
                        0       0       /*      azimuth range   */
                        0       0       /*      elevation       range   */
                        0.6     0.6     /*      distance        range   */

/* ------------------------------------------------------------------------- */

/* room parameters are set in this table (see spat3d.README) */

/* depth1, depth2, max. delay, IR length, idist, seed	*/
f 225 0     64    -2    3     40    -1    0.003 1.0   123
      1     13.627      0.05  0.80  20000.0     0.0   0.50  2     /*    ceil  */
      1     1.753 0.05  0.80  20000.0     0.0   0.25  2     /*    floor */
      1     11.489      0.05  0.90  20000.0     0.0   0.35  2     /*    front */
      1     8.951 0.05  0.90  20000.0     0.0   0.35  2     /*    back  */
      1     15.287      0.05  0.92  20000.0     0.0   0.35  2     /*    right */
      1     10.399      0.05  0.92  20000.0     0.0   0.35  2     /*    left  */

#include "fgen.h.sco"

f 257 0     16384 7     1     16384 -1  ; sawtooth wave
$FGEN128(256'4096'257'1)

e	/* end of score */

