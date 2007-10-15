;Function 1 uses the GEN10 subroutine to compute a sine wave
;Function 2 uses the GEN10 subroutine to compute the first sixteen partials of a sawtooth wave

f1  0 4096 10   1    
f2  0 4096 10   1  .5 .333 .25 .2 .166 .142 .125 .111 .1 .09 .083 .076 .071 .066 .062

i108		0		1       10000		440  	1  2  		3  		1
i108		1.5   	1       20000		220  	1  13  		8  	    1
i108		3	    3       10000		110   	1  1  		13  	1
i108		3.5	2.5     10000		130.8  	1  2.001  	8  	   	1
i108		4	    2       5000		329.6  	1  3.003  	5  	    1
i108		4.5	1.5     6000		440    	1  5.005  	3  		1
