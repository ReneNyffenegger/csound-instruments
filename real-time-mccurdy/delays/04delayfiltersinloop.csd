;Written by Iain McCurdy, 2006

;THE deltap3 OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
;THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

;ksmps MAY NEED TO BE LOW (AND kr THEREFORE HIGH) WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	4410	;CONTROL RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL                                 | WIDTH | HEIGHT | X | Y
		FLpanel	"delay with filters in feedback loop",   500,    350,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",     100,    20,     0,  80
idmix				FLvalue	" ",     100,    20,     0, 130
idfeedbackamt			FLvalue	" ",     100,    20,     0, 180
idamp				FLvalue	" ",     100,    20,     0, 230
idHPFcf				FLvalue	" ",     100,    20,     0, 280
idLPFcf				FLvalue	" ",     100,    20,     0, 330

;SLIDERS					            			MIN |  MAX | EXP | TYPE |      DISP    | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",		.001,   5,    0,    5,           iddlt,   500,     30,    0,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,      1,    0,    5,           idmix,   500,     30,    0, 100
gkfeedamt,ihfeedamt		FLslider 	"Feedback Amount",		0,    200,    0,    5,   idfeedbackamt,   500,     30,    0, 150
gkamp,ihamp			FLslider 	"Output Amplitude Rescaling",	0,      1,    0,    5,           idamp,   500,     30,    0, 200
gkHPFcf,ihHPFcf			FLslider 	"High Pass Filter Cutoff",	20, 20000,   -1,    5,         idHPFcf,   500,     30,    0, 250
gkLPFcf,ihLPFcf			FLslider 	"Low Pass Filter Cutoff",	20, 20000,   -1,    5,         idLPFcf,   500,     30,    0, 300

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.31, 	ihdlt
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	-1, 	ihOnOff
		FLsetVal_i	108, 	ihfeedamt
		FLsetVal_i	.7, 	ihamp
		FLsetVal_i	2000, 	ihHPFcf
		FLsetVal_i	7000, 	ihLPFcf

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           delayr delayw deltap3 - filters in loop           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example adds a low pass and a high pass filter within   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"the feedback loop. The result of doing this is that each time", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"the signal loops around the system it will be more sharply   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"filtered. (This is equivalent to iterative filtering.)       ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Feedback values greater than 100% are now possible as the    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"signal is likely to be attenuated by the filters anyway.     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"This type of delay effect simulates the signal degradation   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"that is evident in analog tape loop delay systems when using ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"signal feedback.                                             ", 	1,      5,     14,    490,    15,     5, 200

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasigL, gasigR	diskin	"808loop.wav",     1,       0,        1
		endin

		instr 		2	;DELAY INSTRUMENT
afeedbacksigL	init		0	;LEFT AND RIGHT CHANNELS OF THE FEEDBACK SIGNAL ARE INITIALISED TO ZERO
afeedbacksigR	init		0       ;LEFT AND RIGHT CHANNELS OF THE FEEDBACK SIGNAL ARE INITIALISED TO ZERO                                                                                                    
iporttime	=		.1	;PORTAMENTO TIME
kporttime	linseg		0, .001, iporttime, 1, iporttime ;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERON TO THE REQUIRED VALUE PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED
kdlt		portk		gkdlt, kporttime ;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
adlt		interp		kdlt	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 

;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
abufferL	delayr	1	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigL 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS
		delayw	gasigL + afeedbacksigL	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER

abufferR	delayr	1	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigR 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS
		delayw	gasigR + afeedbacksigR	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER

adelsigL	atone	adelsigL, gkHPFcf	;LEFT CHANNEL DELAY PASSED THROUGH A HIGH-PASS FILTER WITHIN THE DELAY LOOP
adelsigL	tone	adelsigL, gkLPFcf       ;LEFT CHANNEL DELAY PASSED THROUGH A LOW-PASS FILTER WITHIN THE DELAY LOOP
adelsigR	atone	adelsigR, gkHPFcf       ;RIGHT CHANNEL DELAY PASSED THROUGH A HIGH-PASS FILTER WITHIN THE DELAY LOOP
adelsigR	tone	adelsigR, gkLPFcf	;RIGHT CHANNEL DELAY PASSED THROUGH A LOW-PASS FILTER WITHIN THE DELAY LOOP 

afeedbacksigL	=	adelsigL * gkfeedamt * .01	;CREATE FEEDBACK SIGNAL (AN ATTENUATED PROPORTION OF THE DELAY OUTPUT SIGNAL)
afeedbacksigR	=	adelsigR * gkfeedamt * .01	;CREATE FEEDBACK SIGNAL (AN ATTENUATED PROPORTION OF THE DELAY OUTPUT SIGNAL)

		outs		((adelsigL * gkmix) + (gasigL * (1-gkmix))) * gkamp, ((adelsigR * gkmix) + (gasigR * (1-gkmix))) * gkamp	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT
gasigL		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
gasigR		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
		endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























