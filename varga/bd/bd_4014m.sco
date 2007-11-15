
t       0.00    160.000 /*      tempo   */

i 90   0.000  2.000

i 1 0.000     0.400  31     127 

/* ------------------------------------------------------------------------- */

f 64  0     32    -2    0.6   /*    volume      */   
      160   /*    tempo */
      0.025 /*    release     time  (sec.)      */   

                        5.3333  /*      oscillator      start   frequency       (rel.)  */
                        20.0    /*      frequency       envelope        decay   speed   */
                        0.5     /*      OSC1    BP      bandwidth       (rel.)  */
                        0.0625  /*      OSC1    HP      frequency       (rel.)  */
                        8.0     /*      OSC1    allp.   filter  start   freq.   (rel.)  */
                        1.0     /*      OSC1    allpass filter  end     freq.   */
                        64      /*      OSC1    allpass filter  envelope        speed   */
                        8       /*      OSC2    HP1     frequency       (rel.)  */
                        -3      /*      OSC2    HP1     mix     */  
                        1.0     /*      OSC2    output  HP      frq.    (rel.)  */
                        -0.8    /*      OSC2    output  gain    */ 
                        1.25    /*      output  HP      frq.    (rel.   to      note    f.)     */  
                        1.5     /*      output  HP      resonance       */    
                        24      /*      output  LP      start   freq.   1       (rel.)  */
                        64      /*      output  LP      freq.   env.    1       decay   speed   */
                        8       /*      output  LP      start   freq.   2       */    
                        8       /*      output  LP      freq.   env.    2       decay   speed   */

                        7040    /*      noise   BP      start   frequency       (Hz)    */ 
                        7040    /*      noise   BP      end     frequency       */    
                        2       /*      noise   BP      bandwidth/freq. */
                        3520    /*      noise   LP      start   frequency       (Hz)    */ 
                        55      /*      noise   LP      end     frequency       */    
                        12      /*      noise   filter  envelope        speed   */
                        0.01    /*      noise   attack  time    (sec.)  */
                        3       /*      noise   decay   speed   */
                        0.5     /*      noise   mix     */  

/*-------------------------------------------------------------------------- */

#include "fgen.h.sco"

f 257 0     16384 7     1     16384 -1  ; sawtooth wave
$FGEN128(256'4096'257'1)

e	/* end of score */

