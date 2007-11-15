
t       0       140.00  /*      tempo   */

i 90   0.0000 2.000  /*     output instrument    */ 

i 1 0.0000    0.4500 31     120 

/* ------------------------------------------------------------------------- */

f 64  0     64    -2    0.7   /*    volume      */   
      140   /*    tempo */

                        0.05    /*      release time    */ 

                        5.3333  /*      start   frequency       1       */    
                        16      /*      freq.   decay   speed   1       */    
                        0.5     /*      start   frequency       2       */    
                        128     /*      freq.   decay   speed   2       */    

                        4.0     /*      noise   mix     */  

                        0.25    /*      HP      filter  1       frequency       /       osc.    freq.   */
                        1.0     /*      BP      filter  1       frequency       /       osc.    freq.   */
                        1.0     /*      BP      filter  1       bandwidth       /       osc.    freq.   */

                        2.0     /*      HP      filter  2       frequency       /       osc.    freq.   */
                        0.7     /*      HP      filter  2       mix     */  
                        8.0     /*      HP      filter  3       frequency       /       osc.    freq.   */
                        -2.0    /*      HP      filter  3       mix     */  

                        1.333   /*      output  HP      filter  freq.   /       note    freq.   */
                        2.0     /*      output  HP      filter  resonance       */    

                        12.0    /*      output  LP      filter  frq.    1       /       osc.    freq.   */
                        8       /*      output  LP      filter  frq.    1       decay   speed   */
                        4.0     /*      output  LP      filter  frq.    2       /       osc.    freq.   */
                        8       /*      output  LP      filter  frq.    2       decay   speed   */

                        16.0    /*      amp.    envelope        1       start   value   */
                        256     /*      amp.    envelope        1       decay   speed   */
                        0.25    /*      amp.    envelope        2       start   value   */
                        4       /*      amp.    envelope        2       decay   speed   */

/* ---- compressor parameters ---- */

                        30000   /*      output  volume  */
                        30000   /*      output  clip    level   */
                        1.0     /*      threshold       level   */
                        1.0     /*      compression     ratio   below   thr.    level   */
                        0.0     /*      compression     ratio   above   thr.    level   */
                        0.0002  /*      delay   time    */ 
                        5000    /*      envelope        LP      filter  1       freq.   (attack)        */     
                        500     /*      envelope        LP      filter  1       freq.   (decay) */
                        2000    /*      envelope        LP      filter  2       frequency       (Hz)    */ 

/* ------------------------------------------------------------------------- */

f 256 0     262144      10    1  

e	/* end of score */

