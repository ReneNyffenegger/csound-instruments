;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	44100	;CONTROL RATE
ksmps 		= 	1	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL           | WIDTH | HEIGHT | X | Y
		FLpanel	"Stereo Chorus",   500,    250,    0,  0

;                                                      			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"200Hz. Triangle Wave",		1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idmix				FLvalue	" ",     100,    20,     0,  80
idChoDepth			FLvalue	" ",     100,    20,     0, 130
idChoRate			FLvalue	" ",     100,    20,     0, 180
idphs				FLvalue	" ",     100,    20,     0, 230

;SLIDERS					            				MIN |  MAX | EXP | TYPE |    DISP    | WIDTH | HEIGHT | X | Y
gkmix,ihmix			FLslider 	"Dry/Wet Mix",				0,      1,    0,    5,         idmix,   500,     30,    0,  50
gkChoDepth,ihChoDepth		FLslider 	"Chorus Modulation Depth (sec)",	0,    .05,    0,    5,    idChoDepth,   500,     30,    0, 100
gkChoRate,ihChoRate		FLslider 	"Chorus Modulation Rate",		.001,  14,    0,    5,     idChoRate,   500,     30,    0, 150
gkphs,ihphs			FLslider 	"Right Channel Phase (radians)",	0,      1,    0,    5,         idphs,   500,     30,    0, 200

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	-1, 	ihOnOff
		FLsetVal_i	.001, 	ihChoDepth
		FLsetVal_i	.8, 	ihChoRate
		FLsetVal_i	.5, 	ihphs

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 360, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"            delayr delayw deltap3 - Stereo Chorus            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Using the same basic algorithm as the flanger implementation ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"a chorus effect is implemented.                              ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"A chorus effect uses the pitch bending effect of a modulating", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"delay to create an imitation of an ensemble of voices from a ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"single voice source sound.                                   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Typically the delay time offset is larger than in a flanger  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"implementation and a sine wave LFO (low frequency oscillator)", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"shape.                                                       ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"This example uses independent LFOs on the left and right     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"channels. The user can change the phase of the right hand    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"side LFO (the left is permanently set at 0 radians).         ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Setting the phase of the right hand LFO creates a broad      ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"stereo effect.                                               ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"If the Dry/Wet control is set at 100% wet, and the phase of  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"right hand channel LFO is set at 0 radians then a simple     ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"vibrato effect results.                                      ", 	1,      5,     14,    490,    15,     5, 340

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
gasig		vco 		30000, 200, 1, 0	;GENERATE A TRIANGLE WAVE AUDIO SIGNAL
		endin

		instr 		2	;CHORUS-DELAY INSTRUMENT
amodL 		osciliktp 	gkChoRate, 1, 0
amodL		=		(((amodL*gkChoDepth)+gkChoDepth)*.5)+.01

amodR 		osciliktp 	gkChoRate, 1, gkphs	;THE PHASE OF THE RIGHT CHANNEL IS ADJUSTABLE
amodR		=		(((amodR*gkChoDepth)+gkChoDepth)*.5)+.01

;REMEMBER THAT THE LENGTH OF THE DELAY BUFFER DEFINED WILL HAVE TO TAKE ACCOUNT OF THE SUMMED MAXIMUM OF THE STATIC CONSTANT VALUE AND MODULATING DELAY TIME

;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
abufferL	delayr	1.2	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigL 	deltap3	amodL	;TAP THE DELAY LINE AT gkdlt SECONDS
		delayw	gasig	;WRITE AUDIO SOURCE INTO THE BEGINNING OF THE BUFFER

abufferR	delayr	1.2	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigR 	deltap3	amodR	;TAP THE DELAY LINE AT gkdlt SECONDS
		delayw	gasig	;WRITE AUDIO SOURCE INTO THE BEGINNING OF THE BUFFER

		outs		(adelsigL * gkmix) + (gasig * (1-gkmix)), (adelsigR * gkmix) + (gasig * (1-gkmix))	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT. NOTE THAT THE DELAYED SIGNAL IS INVERTED (NEGATIVE)
gasigL		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
gasigR		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
		endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 1 0 131072 10 1

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























