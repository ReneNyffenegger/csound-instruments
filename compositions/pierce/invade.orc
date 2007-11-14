
;=======================================================================================;									
;	   	        	Derek Pierce aka Beatsystem 				;					;
;											;
;                           "Invade areas where nothing's definite"			;
;					1998 version					;
;=======================================================================================;

sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

; Dynamic pitch shift instrument

instr 1  


	kenv	oscil		20000,1/p3,2
	aindx	line		p4,p3,p3+p4
	asig	tablei	aindx*sr,1

		outs asig*kenv ,  asig*kenv
	
	endin
	
; Dynamic granular instrument

instr 2

	k1      linseg  0,20,1,(p3-80),1,60,0  
	k2      expseg  .20,(p3/8)*2,.2,(p3/8)*6,.002 ;gap varies over time.
	k3      expseg  .30,p3/2,.03,p3/2,.002 ;grain size decreases over time.


	a1      granule  p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,k2,p15,k3,p17,p18,p19,p20,p21,p22,p23,p24
	a2      granule  p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,k2,p15,k3,p17,p18,p19,p20+0.07,p21,p22,p23,p24
        	outs a1,a2

	endin

; Soundwarp instrument

	instr 4

	isamp  	=  p4
	iws	=  3000
	iwfn	=  3
	iover	=  23
	


	k1      expon     2,p3,.001
	asig    sndwarp  6000,p5+k1,1,isamp,0,iws,500,iover,iwfn,0
        	outs      asig*p6,asig*(1-p6)
		endin


	instr 5

	isamp  	=  p4
	iws	=  3000
	iwfn	=  3
	iover	=  20
	


	k1      expon     2,p3,.001
	asig   	sndwarp   6000,p5+k1,1,isamp,0,iws,500,iover,iwfn,0
       	outs     asig*p6,asig*(1-p6)

		endin 

