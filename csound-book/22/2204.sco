; LFO WAVE IS A SINE
f 1 0   512 10  1               
;OSCIL WAVE
f 2 0   512 10  1   .5  .3  .2  .1
; LFO DEPTH FACTOR IS .9, GRADUALLY INCREASE MAX DELAY TIME
; INS   ST  DUR AMP PCH LFOHZ   DEPTH   MAXDLT  
i 2204  0   3   10000   8.00    5   .9  1   
i 2204  +   .   .   .   .   .   2   
i 2204  +   .   .   .   .   .   3   
i 2204  +   .   .   .   .   .   4   
