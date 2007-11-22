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
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"syncgrain",   500,    570,    0   0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,  -1,     2,    150,     30,    0,   0,    0,      2,     0,       -1


idamp				FLvalue	" ",     70,    20,    0,  80
idfreq				FLvalue	" ",     70,    20,    0, 130
idpitch				FLvalue	" ",     70,    20,    0, 180
idprate				FLvalue	" ",     70,    20,    0, 230
idgrsize			FLvalue	" ",     70,    20,    0, 280

;					            				MIN |   MAX  | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider 	"Amplitude",			0,    30000,    0,    5,   idamp,       500,     30,    0,  50
gkfreq, ihfreq			FLslider 	"Density (Grain per Sec.)",	1,       50,    0,    5,   idfreq,      500,     30,    0, 100
gkpitch, ihpitch		FLslider 	"Pitch",			-2,       2,    0,    5,   idpitch,     500,     30,    0, 150
gkprate, ihprate		FLslider 	"Progress Rate",		-2,       2,    0,    5,   idprate,     500,     30,    0, 200
gkgrsize, ihgrsize		FLslider 	"Grain Size",			.001,     1,    0,    5,   idgrsize,    500,     30,    0, 250

gkfun2, ihfun2	FLcount  "Grain Envelope", 		1,    6,     1,     100,     2,    150,      27,     0,303,  -1 
gkfun1, ihfun1	FLcount  "Source Sound", 		1,    2,     1,     100,     2,    150,      27,     0,473,  -1

;TEXT BOXES              									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Half Sine                                     ", 	1,      5,     12,    500,     20,    0, 350
ih		 FLbox  "                 2 - Percussive (straight segments)                ", 	1,      5,     12,    500,     20,    0, 370
ih		 FLbox  "                 3 - Percussive (exponential segments)             ", 	1,      5,     12,    500,     20,    0, 390
ih		 FLbox  "                 4 - Gate (with anti click ramp up and ramp down)  ", 	1,      5,     12,    500,     20,    0, 410
ih		 FLbox  "                 5 - Reverse Percussive (straight segments)        ", 	1,      5,     12,    500,     20,    0, 430
ih		 FLbox  "                 6 - Reverse Percussive (exponential segments)     ", 	1,      5,     12,    500,     20,    0, 450
ih		 FLbox  "Source Sounds    1 - Voice                                         ", 	1,      5,     12,    500,     20,    0, 520
ih		 FLbox  "                 2 - Drums                                         ", 	1,      5,     12,    500,     20,    0, 535

		FLsetVal_i	16000, 	ihamp
		FLsetVal_i	20, 	ihfreq
		FLsetVal_i	1, 	ihpitch
		FLsetVal_i	1, 	ihprate
		FLsetVal_i	.05, 	ihgrsize
		FLsetVal_i   	1, 	ihfun2
		FLsetVal_i   	1, 	ihfun1
		
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 540, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           syncgrain                         ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Syncgrain offers granular synthesis upon a stored sound file ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"stored in a gen 1 function table.                            ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Syncgrain's strength lies in its use of k-rate control for   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"its main input arguments which encourages real time          ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"manipulation.                                                ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Another distinctive feature of syncgrain is the interaction  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"between the density (kfreq), grain size (kgrsize) and        ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"progress rate (kprate). Density or grain frequency (kfreq)   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"defines the number of grains per second. Higher values for   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"grain density have the effect of increasing the progress rate", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"through the sound file (kprate). Increasing the grain size   ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"also increases the rate of progress through the sound file.  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"The progress rate  (kprate) defines the location from where a", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"grain will begin playback as a fraction of the previous      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"grain's entire trajectory. If progress rate is given a value ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"of 1 then a grain will begin exactly where the previous grain", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"finished. If progress rate is given a value of 0.5 then it   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"will begin at the halfway point of the previous grain's      ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"trajectory. Negative values for progress rate cause the      ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"progress pointer to move backwards through the file (but     ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"playback of each grain is still forwards).                   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"The user is required to provide an amplitude envelope which  ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"is stored in a function table. In this example the user is   ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"provided with six grain envelopes from which to choose.      ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"Details are provided on the interface.                       ", 	1,      5,     14,    490,    15,     5, 520

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr		1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed		gkfun2, gkfun1
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,       0,        2,        0,    -1
CONTINUE:
		endin
		
		instr		2
if	gkOnOff!=-1	goto	CONTINUE ; SENSE FLTK ON/OFF SWITCH
			turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
CONTINUE:
ifun1		=		1	;SOURCE SOUND FUNCTION TABLE
ifun2		=		2	;WINDOWING FUNCTION USED TO DYNAMICALLY SHAPE THE GRAINS
iolaps		=		100	;NUMBER OF ALLOWED OVERLAPS - BEST JUST TO GIVE THIS A LARGE CONSTANT VALUE
asig 		syncgrain	gkamp, gkfreq, gkpitch, gkgrsize, gkprate, i(gkfun1), i(gkfun2)+99, iolaps
		outs 		asig, asig
		endin

</CsInstruments>

<CsScore>
; THE SOUND FILE USED IN THE GRANULATION
; NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH     | IN_SKIP | FORMAT | CHANNEL(LEFT CHANNEL ONLY)
f  1        0      262144       1       "AndItsAll.wav"    0         4        1 
f  2        0      524288       1       "808loop.wav"    0         4        1 

f  3        0      4096        10       1	;SINE WAVE

; WINDOWING FUNCTIONS USED TO DYNAMICALLY SHAPE THE GRAINS
; NUM | INIT_TIME | SIZE | GEN_ROUTINE | PARTIAL_NUM | STRENGTH | PHASE
;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
f100  0 131072  9   .5 1 0 				; HALF SINE
f101  0 131072  7    0 3072   1 128000    0		; PERCUSSIVE - STRAIGHT SEGMENTS
f102  0 131072  5 .001 3072   1 128000 .001		; PERCUSSIVE - EXPONENTIAL SEGMENTS
f103  0 131072  7    0 1536   1 128000    1 1536 0	; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
f104  0 131072  7    0 128000 1 3072      0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
f105  0 131072  5 .001 128000 1 3072   .001		; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

i 1 0 3600		;INSTRUMENT 1 PLAYS FOR 1 HOUR (ALSO KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>