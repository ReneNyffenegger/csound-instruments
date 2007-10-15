;Function  1 uses the GEN10 subroutine to compute a sine wave
;Function  9 uses the GEN05 subroutine to compute an exponential Attack for use with envlpx
;Function 10 uses the GEN05 subroutine to compute an exponential Attack for use with envlpx

f 1  0 4096 10   1    
f 9  0 513  5    .001 128 .8  128 .6  256  1
f 10 0 513  5   .01  64   1   64   .5   64  .99  64   .6  64  .98  64  .7  64 .97  32  .8  32 1

;ins	st 	dur amp	frq		fun	atk	rel	atkfun indx1 indx2	
;========================================================
i 122	0	 4	70	7.09	 1 .01	.2	10	 1 		30		
i 122	4.5 5	70	7.00	 1  1	.1	9	 10 	60	
i 122	10	10	70	5.09	 1  3	 2	10	 60 	3		
i 122	13	 7	66	7.04	 1  .5	 1	9	 3 		100	
