;Function 1 uses the GEN10 subroutine to compute a sine wave
;Function 3 uses the GEN20 subroutine to compute a Hanning window for use as a grain envelope

f1  0 4096 10   1    
f3  0 4097 20   2  1

; ins	strt	dur amp     frq     fn	atk		rel		bend	dens1	dens2	ampof1	ampof2	pchof1	pchof2	gdur1	gdur2
;=============================================================================================================================
i 117    0      5	1000  	440  	3 	1		.1		430 	12000 	4000  	120 	50    	.01  	.05  	.1   	.01 
i 117    6     10	4000  	1760  	3	5		.1		60	    5		200   	500   	1000  	10  	20000   1   	.01
