;Written by Iain McCurdy, 2006

;THE delay OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
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
;			LABEL                     | WIDTH | HEIGHT | X | Y
		FLpanel	"Delay with Portamento",     500,    150,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",     100,    20,     0,  80
idmix				FLvalue	" ",     100,    20,     0, 130

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",		.001,  5,    0,    5,   iddlt,     500,     30,    0,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,     1,    0,    5,   idmix,     500,     30,    0, 100

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.5, 	ihdlt
		FLsetVal_i	1, 	ihmix
		FLsetVal_i	-1, 	ihOnOff

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"  delayr delayw deltap3 - portamento applied to delay time   ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example is very similar to the previous example with    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"the addition of portamento being applied to the delay time   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"parameter. As the delay time slider is moved pitch bending   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"effects are created.                                         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"For better quality results the deltap3 opcode is used in     ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"place of the deltap opcode. Also for higher fidelity results ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"the delay time is expressed to the deltap3 opcode as an      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"a-rate variable. This necessitates the use of the 'interp'   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"opcode for rate conversion as FLTK sliders only output values", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"at k-rate.                                                   ", 	1,      5,     14,    490,    15,     5, 220

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
iporttime	=		.1	;PORTAMENTO TIME
kporttime	linseg		0, .001, iporttime, 1, iporttime ;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERON TO THE REQUIRED VALUE PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED
kdlt		portk		gkdlt, kporttime ;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
adlt		interp		kdlt	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 

;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
abufferL	delayr	5	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigL 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS
		delayw	gasigL	;WRITE AUDIO INTO THE BEGINNING OF THE BUFFER

abufferR	delayr	5	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigR 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS
		delayw	gasigR	;WRITE AUDIO INTO THE BEGINNING OF THE BUFFER

		outs		(adelsigL * gkmix) + (gasigL * (1-gkmix)), (adelsigR * gkmix) + (gasigR * (1-gkmix))	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT
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



























