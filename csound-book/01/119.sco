; Function 1 uses the GEN10 subroutine to compute a sine wave
; Function 2 uses the GEN10 subroutine to compute the first sixteen partials of a sawtooth wave
; Function 7 uses the GEN07 subroutine to compute a linear ADSR envelope function
; Function 8 uses the GEN05 subroutine to compute an exponential ADSR envelope function

f 1  0 4096 10   1    
f 2  0 4096 10   1  .5 .333 .25 .2 .166 .142 .125 .111 .1 .09 .083 .076 .071 .066 .062
f 7  0 1024 7	0	128		1	128		.6		512		.6		256 	0
f 8  0 1024 5   .01  256   	1   192   	.5   	256  	.5   	64  	.01

;ins	strt	dur amp     frq     fn	envfn	loopfrq fc  fm  indx1	indx2	
;=====================================================================================
i 119	0		3	10000	440  	1   8		30		1	1	10		1		   
i 119 	4   	3 	10000	220  	1   7		15  	1   .5	1		10
i 119	8	    3	10000	110   	1   2		12   	1   3	20		1
i 119 	12	   20	5000	110.9  	1   8  		100    	1   1	3		20
i 119	14	   12	5000	329.6  	1   7  		94    	1   1	15		6
i 119	16	   12 	5000	659.2   1   2   	70    	1   .5	3		14
i 119	18	   12 	5000	329.6   1   7   	67    	4   1	10		2
i 119	20	   12 	5000	130.8   1   8   	56    	1   1	1		11
i 119	22	   10 	5000	440    	1   2   	41    	1   2	20		3
