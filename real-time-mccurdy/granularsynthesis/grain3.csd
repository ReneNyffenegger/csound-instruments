;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;		LABEL | WIDTH | HEIGHT | X | Y
	FLpanel	"grain3",500,     700,   0,  0

;SWITCHES                                					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",				1,   -1,    2,     150,     30,    0,  0,    0,      2,      0,      -1
gkSyncCPS,ihoptions	FLbutton	"Sync Start Phase to CPS",		64,    0,    2,     166,     50,    0,500,    0,      2,      0,      -1
gkIntegerLoc,ihoptions	FLbutton	"Start All Grains at Integer Location",	32,    0,    2,     166,     50,  166,500,    0,      2,      0,      -1
gkLessZero,ihoptions	FLbutton	"Ignore Grains Starting at Phase<0",	16,    0,    2,     166,     50,  333,500,    0,      2,      0,      -1
gkInterp,ihoptions	FLbutton	"Interpolate Window",			8,    0,    2,     166,     50,    0,550,    0,      2,      0,      -1
gkNoInterp,ihoptions	FLbutton	"No Interpolate Waveform",		4,    0,    2,     166,     50,  166,550,    0,      2,      0,      -1
gkFreqCont,ihoptions	FLbutton	"Continual Freq. Modification",		2,    0,    2,     166,     50,  333,550,    0,      2,      0,      -1
gkSkipInit,ihoptions	FLbutton	"Skip Initialisation",			1,    0,    2,     166,     50,    0,600,    0,      2,      0,      -1

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp	  FLvalue   " ",     	80,       20,    0, 80
iddur	  FLvalue   " ",     	80,       20,    0, 130
idpch	  FLvalue   " ",     	80,       20,    0, 180
idfmd	  FLvalue   " ",     	80,       20,    0, 230
iddens	  FLvalue   " ",     	80,       20,    0, 280
idphs	  FLvalue   " ",     	80,       20,    0, 330
idpmd	  FLvalue   " ",     	80,       20,    0, 380
idfrpow	  FLvalue   " ",     	80,       20,    0, 430
idprpow	  FLvalue   " ",     	80,       20,    0, 480
idseed	  FLvalue   " ",     	90,       15,  300,  30

;SLIDERS										MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",    				0,   10000,  0,    5,     idamp,     500,     30,    0,    50
gkdur, ihdur		FLslider	"Grain Duration (ms.)",				.001,  1,    0,    5,     iddur,     500,     30,    0,   100
gkpch, ihpch		FLslider	"Pitch",					.0625, 2,    0,    5,     idpch,     500,     30,    0,   150
gkfmd, ihfmd		FLslider	"Pitch Offset",					0,     .3,   0,    5,     idfmd,     500,     30,    0,   200
gkdens, ihdens		FLslider	"Density",					1,    500,   0,    5,     iddens,    500,     30,    0,   250
gkphs, ihphs		FLslider	"Grain Phase",					0,     1,    0,    5,     idphs,     500,     30,    0,   300
gkpmd, ihpmd		FLslider	"Grain Phase Random Offset",			0,     1,    0,    5,     idpmd,     500,     30,    0,   350
gkfrpow, ihfrpow	FLslider	"Distribution of Random Frequency Variation",	-2,    2,    0,    5,     idfrpow,   500,     30,    0,   400
gkprpow,ihprpow		FLslider	"Distribution of Random Phase Variation",	-2,    2,    0,    5,     idprpow,   500,     30,    0,   450
gkseedL,ihseedL		FLslider	" ",						0,2147483646,0,    5,     idseed,        190,     15,  305,     0
gkseedR,ihseedR		FLslider	"Seed Value L/R",				0,2147483646,0,    5,     idseed,        190,     15,  305,    15

;			FLsetAlign ialign, ihandle
			FLsetAlign 9,      ihseedR	; (BOTTOM RIGHT)
;			FLsetAlign 3,      ihoptions	; (BOTTOM BOTTOM)


;COUNTERS				     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkmaxolap, ihmaxolap	FLcount  "Maximum Overlaps", 	1,   1000,    1,     100,     1,    150,     30,   150, 0,    -1 
gkwfn, ihwfn		FLcount  "Grain Envelope", 	1,      6,    1,     100,     2,    166,     30,   166,605,   -1 

;TEXT BOXES              																														TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Hanning . 2 - Percussive (straight segments) . 3 - Percussive (exponential segments) . 4 - Gate (with anti click ramp up and ramp down) . 5 - Percussive (straight segments) . 6 - Percussive (exponential segments)", 	1,     1,      12,    500,     30,    0, 655

; INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	5000, 	ihamp
FLsetVal_i   	600, 	ihmaxolap
FLsetVal_i   	.25, 	ihdur
FLsetVal_i   	1, 	ihpch
FLsetVal_i   	0, 	ihfmd
FLsetVal_i   	50, 	ihdens
FLsetVal_i   	.45, 	ihphs
FLsetVal_i   	.0055, 	ihpmd
FLsetVal_i   	0, 	ihfrpow
FLsetVal_i   	-2, 	ihprpow
FLsetVal_i   	0, 	ihseedL
FLsetVal_i   	0, 	ihseedR
FLsetVal_i   	1, 	ihwfn

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          grain3                             ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"grain3 performs granular synthesis upon a stored function    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"table. The function table used can contain a simple single   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"cycle waveform or it can contain a stored sample. In this    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"example a sound sample stored within a GEN 1 function table  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"is used. By studying the code it is seen that interrogation  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"of the sample's duration is needed in order for the 'phase'  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"parameter to be used effectively. 'Phase' effectively defines", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"to the location within the waveform or function table from   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"which samples will be read.                                  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"In this example pitch is reinterpretted mathematically so    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"that the values inputted via the interface are ratios to the ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"original pitch of the sample. i.e. a value of represents no  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"transposition, a value of 2 represents a transposition up 1  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"octave, a value of .5 represents a transposition down 1      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"octave and so on.                                            ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"The grain3 opcode allows for user modification of what sort  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"of random distribution it uses in its randomisation          ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"precedures for pitch and phase. This example allows the user ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"to modify these setting but for a more in depth explanation  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"of what exactly these values represent the user is directed  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"to the Csound Manual.                                        ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"The 'seed value' (optional) is used to seed the pseudo-random", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"number generator that is used in the randomization of pitch  ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"and phase. A value of zero means that the system clock       ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"reading will be used as a seed value.                        ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"Another optional input argument, called 'imode' in the manual", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"allows for the setting of a variety of subtle options in the ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"precise way in which grains are produced. For convenience    ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"these options are represented individually with a series of  ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"switches in this example.                                    ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"The user must supply a windowing function via a function     ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"table that the opcode will use to apply an amplitude envelope", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"to each grain. In this example six different envelope types  ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"are offerred for experimentation. Descriptions of the        ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"different types on offer are included on the main panel. To  ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"hear most clearly the effect of using different grain        ", 	1,      5,     14,    490,    15,     5, 740
ih		 	FLbox  	"envelopes set 'Density' to a low value and set 'Grain        ", 	1,      5,     14,    490,    15,     5, 760
ih		 	FLbox  	"Duration' to a high setting.                                 ", 	1,      5,     14,    490,    15,     5, 780

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed	gkmaxolap, gkseedL, gkseedR, gkSyncCPS, gkIntegerLoc, gkLessZero, gkInterp, gkNoInterp, gkFreqCont, gkFreqCont, gkSkipInit, gkwfn
;				TRIGGER  | MINTIM | MAXNUM | INSNUM | WHEN | DUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,     0,       0,        2,     0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
		endin
	
		instr	2
if gkOnOff!	=	-1	kgoto		CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff				;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
ifn 		= 	1	;SOURCE SOUND/WAVEFORM FUNCTION TABLE
kpitch 		= 	(sr*gkpch)/ftlen(ifn)	;MATHEMATICALLY REINTERPRET USER INPUTTED PITCH RATIO VALUE INTO A FORMAT THAT IS USABLE AS AN INPUT ARGUMENT BY THE grain3 OPCODE - ftlen(x) FUNCTION RETURNS THE LENGTH OF A FUNCTION TABLE (no. x), REFER TO MANUAL FOR MORE INFO.
imaxovr 	= 	i(gkmaxolap)	;MAXIMUM NUMBER OF OVERLAPS
kphs 		= 	gkphs*(nsamp(ifn)/ftlen(ifn))	;MATHREMATICALLY REINTERPRET USER INPUTTED PHASE VALUE INTO A FORMAT THAT IS USABLE AS AN INPUT ARGUMENT  BY THE grain3 OPCODE
imode	=	i(gkSyncCPS) + i(gkIntegerLoc) + i(gkLessZero) + i(gkInterp) + i(gkNoInterp) + i(gkFreqCont) + i(gkFreqCont) + i(gkSkipInit)	;SUM THE MODE BUTTON OUTPUTS
aSignalL	grain3	kpitch, kphs, gkfmd, gkpmd, gkdur, gkdens, imaxovr, ifn, i(gkwfn)+99, gkfrpow, gkprpow , i(gkseedL), int(imode)
aSignalR	grain3	kpitch, kphs, gkfmd, gkpmd, gkdur, gkdens, imaxovr, ifn, i(gkwfn)+99, gkfrpow, gkprpow , i(gkseedR), int(imode)
		outs 	aSignalL * gkamp, aSignalR * gkamp
		endin

</CsInstruments>

<CsScore>
; THE SOUND FILE USED IN THE GRANULATION
; NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH     | IN_SKIP | FORMAT | CHANNEL
f  1        0      524288       1       "AndItsAll.wav"    0         4        1 

;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
f100  0 512  20 2			; HANNING WINDOW
f101  0 512  7 0 12 1 500 0		; PERCUSSIVE - STRAIGHT SEGMENTS
f102  0 512  5 .001 12 1 500 .001	; PERCUSSIVE - EXPONENTIAL SEGMENTS
f103  0 512  7 0 6 1 500 1 6 0		; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
f104  0 512  7 0 500 1 12 0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
f105  0 512  5 .001 500 1 12 .001	; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

i 1 0 3600		;INSTRUMENT 1 PLAYS FOR 1 HOUR (ALSO KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>