;Function  1 uses the GEN10 subroutine to compute a sine wave
;Function 10 uses the GEN05 subroutine to compute an exponential Attack for use with envlpx

f1  0 4096 10   1    
f10 0 513  5   .01  64   1   64   .5   64  .99  64   .6  64  .98  64  .7  64 .97  32  .8  32 1

;ins	strt	dur amp	frq     fn	atk	rel	atkfun	modp1	modp2	modfr1	modfr2	modfun
;==========================================================================================
i 124   	0      .6	70	8.09	1	.01	.01  10		10		1	    9.00	8.09		1
i 124   	1      .5	70	8.07	1	.01	.01  10		10		5    	5.00	7.07		1
i 124   	2      .4	70	7.05	1	.02	.02  10		10		8	    12.05	6.04		1
i 124   	3      .7	70	6.00	1	.03	.03  10		5		10	    4.00	14.00		1
