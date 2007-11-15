
t       0.00    134.000 /*      tempo   */

#include "roomparams.sco"

; p4: note number
; p5: velocity
; p6: azimuth

i 1 0.500     0.350  51     120    90 
i 1 1.250     0.350  51     120    120
i 1 2.000     0.500  47     120    -150
i 1 2.750     0.500  47     120    -120
i 1 3.500     0.750  44     120    -90

/* ------------------------------------------------------------------------- */

f 64  0     32    -2    0.65  /*    volume      */   
      130   /*    tempo */

                        0.1667  /*      release time    (sec.)  */

                        2.0     /*      oscillator      start   frequency       (rel.)  */
                        48.0    /*      frequency       envelope        decay   speed   */
                        0.5     /*      OSC1    BP      bandwidth       (rel.)  */
                        0.0625  /*      OSC1    HP      frequency       (rel.)  */
                        1.0     /*      OSC1    allp.   filter  start   freq.   (rel.)  */
                        1.0     /*      OSC1    allpass filter  end     freq.   */
                        8       /*      OSC1    allpass filter  envelope        speed   */
                        8       /*      OSC2    HP1     frequency       (rel.)  */
                        -5      /*      OSC2    HP1     mix     */  
                        0.5     /*      OSC2    output  HP      frq.    (rel.)  */
                        -0.4    /*      OSC2    output  gain    */ 
                        1.5     /*      output  HP      frq.    (rel.   to      note    f.)     */  
                        2.0     /*      output  HP      resonance       */    
                        28      /*      output  LP      start   freq.   1       (rel.)  */
                        64      /*      output  LP      freq.   env.    1       decay   speed   */
                        4       /*      output  LP      start   freq.   2       */    
                        7       /*      output  LP      freq.   env.    2       decay   speed   */

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
; square wave
f 301 0     16384 7     1     8192  1     0     -1    8192  -1
$FGEN128(300'4096'301'1)

e	/* end of score */

