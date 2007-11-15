
t       0       140.00  /*      tempo   */

i 1 0.0000    1.0000 31     127 

/* ------------------------------------------------------------------------- */

f 64  0     64    -2    7000.0      /*    output      volume      */   
      140.0 /*    tempo */

                        5.3333  /*      oscillator      start   frq.    /       note    freq.   */
                        1.0     /*      oscillator      end     frequency       /       note    frq.    */ 
                        20.0    /*      osc.    freq.   envelope        speed   */

                        880     /*      lowpass filter  start   freq.   1       (Hz)    */ 
                        128     /*      lowpass filter  freq.   1       decay   speed   */
                        0       /*      lowpass filter  start   freq.   2       (Hz)    */ 
                        1       /*      lowpass filter  freq.   2       decay   speed   */
                        8       /*      LP      filter  start   freq.   3       /       note    frq.    */ 
                        8       /*      lowpass filter  freq.   3       decay   speed   */
                        0       /*      LP      filter  start   freq.   4       /       note    frq.    */ 
                        1       /*      lowpass filter  freq.   4       decay   speed   */

                        0.5     /*      EQ      1       frequency       /       osc.    frequency       */    
                        0       /*      EQ      1       frequency       /       note    frequency       */    
                        0       /*      EQ      1       frequency       (Hz)    */ 
                        0.25    /*      EQ      1       level   */
                        0.7071  /*      EQ      1       Q       */    
                        1       /*      EQ      1       mode    (0:peak,1:low,2:high)   */

                        0.5     /*      EQ      2       frequency       /       osc.    frequency       */    
                        0       /*      EQ      2       frequency       /       note    frequency       */    
                        0       /*      EQ      2       frequency       (Hz)    */ 
                        0.25    /*      EQ      2       level   */
                        0.7071  /*      EQ      2       Q       */    
                        1       /*      EQ      2       mode    (0:peak,1:low,2:high)   */

                        0.5     /*      EQ      3       frequency       /       osc.    frequency       */    
                        0       /*      EQ      3       frequency       /       note    frequency       */    
                        0       /*      EQ      3       frequency       (Hz)    */ 
                        4       /*      EQ      3       level   */
                        2.0     /*      EQ      3       Q       */    
                        0       /*      EQ      3       mode    (0:peak,1:low,2:high)   */

                        0       /*      EQ      4       frequency       /       osc.    frequency       */    
                        1.5     /*      EQ      4       frequency       /       note    frequency       */    
                        0       /*      EQ      4       frequency       (Hz)    */ 
                        2.0     /*      EQ      4       level   */
                        1.0     /*      EQ      4       Q       */    
                        0       /*      EQ      4       mode    (0:peak,1:low,2:high)   */

                        16.0    /*      noise   mix     */  

                        0       /*      noise   EQ      1       frequency       /       osc.    freq.   */
                        16      /*      noise   EQ      1       frequency       /       note    freq.   */
                        0       /*      noise   EQ      1       frequency       (Hz)    */ 
                        0.0625  /*      noise   EQ      1       level   */
                        0.7071  /*      noise   EQ      1       Q       */    
                        1       /*      noise   EQ      1       mode    (0:peak,1:lo,2:hi)      */   

                        0       /*      noise   EQ      2       frequency       /       osc.    freq.   */
                        16      /*      noise   EQ      2       frequency       /       note    freq.   */
                        0       /*      noise   EQ      2       frequency       (Hz)    */ 
                        0.0625  /*      noise   EQ      2       level   */
                        0.7071  /*      noise   EQ      2       Q       */    
                        1       /*      noise   EQ      2       mode    (0:peak,1:lo,2:hi)      */   

/* ------------------------------------------------------------------------- */

f 1 0 262144      10    1  

e	/* end of score */

