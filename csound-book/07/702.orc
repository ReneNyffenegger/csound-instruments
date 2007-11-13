sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr 	702
idur	=		abs(p3)				; MAIN INIT BLOCK
ipch1	=		cpspch(p6)	
ipch2	=		cpspch(p5)	
kpch	=		ipch2	
iport	=		0.1					; 100msec PORTAMENTO
iatt	=		0.05				; DEFAULT DURS FOR AMPLITUDE RAMPS
idec	=		0.05				; ASSUME THIS IS A TIED NOTE:
iamp	=		p4					; SO START AT p4 LEVEL...
i1		=		-1					; ... AND KEEP PHASE CONTINUITY
		ir		tival				;  CONDITIONAL INIT BLOCK:TIED NOTE?
		tigoto	start	
i1		=		0					; FIRST NOTE: RESET PHASE
iamp	=		0					; AND ZERO iamp
start:			
iadjust	=		iatt+idec	
		if		idur >= iadjust igoto doamp	; ADJUST RAMP DURATIONS FOR SHORT...
iatt	=		idur/2-0.005		; ... NOTES, 10msecs LIMIT
idec	=		iatt				; ENSURE NO ZERO-DUR SEGMENTS
iadjust	=		idur-0.01	
iport	=		0.005				; MAKE AMPLITUDE RAMP...
doamp:								; ... (arate FOR CLEANNESS) AND...
ilen	=		idur-iadjust		; ... SKIP PITCH RAMP GENERATION...
amp		linseg	iamp, iatt, p4, ilen, p4, idec, p7
		if 		ir == 0 || p6 == p5 kgoto slur	;...IF FIRST NOTE OR TIE.
; MAKE PITCH RAMP, PORTAMENTO AT START OF NOTE
kpramp	linseg	ipch1, iport, ipch2, idur-iport, ipch2
kpch	=		kpramp	
slur:								; MAKE THE NOTE
aamp	=		amp	
asig	oscili	aamp, kpch, 1, i1	
		out		asig	
		endin
