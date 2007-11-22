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

;		LABEL |  WIDTH | HEIGHT	| X | Y
	FLpanel	"sndwarp",500,     570,   0,  0

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp		FLvalue   " ",	 80,      20,    0,  80
idptr		FLvalue   " ",	 80,      20,    0, 130
idstretch	FLvalue   " ",	 80,      20,    0, 180
idpch		FLvalue   " ",	 80,      20,    0, 230
idwsize		FLvalue   " ",	 80,      20,    0, 280
idrnd		FLvalue   " ",	 80,      20,    0, 330
idbeg		FLvalue   " ",	 80,      20,    0, 380

;SWITCHES                                               ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,  -1,     2,    150,     30,     0,  0,   0,      2,      0,      -1

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkolap, iholap	FLcount  "Number of Overlaps",		1,    20,    1,      20,     1,    150,      30,   175, 0,   -1
gkmode, ihmode	FLcount  "0-Warp 1-Pointer", 		0,    1,     1,       1,     2,    150,      30,   350, 0,   -1
gkwfn, ihwfn	FLcount  "Grain Envelope", 		1,    6,     1,     100,     2,    150,      27,     0,403,  -1 

;TEXT BOXES              									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Half Sine                                     ", 	1,      5,     12,    500,     20,    0, 450
ih		 FLbox  "                 2 - Percussive (straight segments)                ", 	1,      5,     12,    500,     20,    0, 470
ih		 FLbox  "                 3 - Percussive (exponential segments)             ", 	1,      5,     12,    500,     20,    0, 490
ih		 FLbox  "                 4 - Gate (with anti click ramp up and ramp down)  ", 	1,      5,     12,    500,     20,    0, 510
ih		 FLbox  "                 5 - Reverse Percussive (straight segments)        ", 	1,      5,     12,    500,     20,    0, 530
ih		 FLbox  "                 6 - Reverse Percussive (exponential segments)     ", 	1,      5,     12,    500,     20,    0, 550

;SLIDERS				      						MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkamp,ihamp		FLslider	"Amplitude  (Portamento Applied)",		0,    10000, 0,     5,   idamp,      500,     26,    0,    50
gkptr,ihptr		FLslider	"Pointer  (Portamento Applied)",  		0,     1,    0,     5,   idptr,      500,     26,    0,   100
gkstretch,ihstretch	FLslider	"Stretch Factor",				1,     50,   0,     5,   idstretch,  500,     26,    0,   150
gkpch,ihpch		FLslider	"Pitch (Portamento Applied)",			.01,   8,   -1,     5,   idpch,      500,     26,    0,   200
gkwsize,ihwsize		FLslider	"Window Size (i-rate)",				10,   40000, 0,     5,   idwsize,    500,     26,    0,   250
gkrnd,ihrnd		FLslider	"Randomization Factor (i-rate)",		0,    10000, 0,     5,   idrnd,      500,     26,    0,   300
gkbeg,ihbeg		FLslider	"Inskip into Source Sound File (i-rate)",	0,    1,     0,     5,   idbeg,      500,     26,    0,   350
gkporttime,ihporttime	FLslider 	"Portamento Amount",				0,    1,     0,     5,      -1,      344,     16,  153,   400

; INITIALISATION OF SLIDERS AND COUNTERS
		FLsetVal_i   4000, 	ihamp
		FLsetVal_i   8, 	iholap
		FLsetVal_i   0, 	ihmode
		FLsetVal_i   .1, 	ihptr
		FLsetVal_i   1, 	ihstretch
		FLsetVal_i   1, 	ihpch
		FLsetVal_i   1500, 	ihwsize
		FLsetVal_i   3500, 	ihrnd
		FLsetVal_i   -1, 	ihOnOff
		FLsetVal_i   1, 	ihwfn
		FLsetVal_i   0, 	ihbeg
		FLsetVal_i	.5, 	ihporttime

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          sndwarp                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Sndwarp performs granular synthesis upon a stored function   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"table by employing either a timestretch (as in the 'granule' ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"opcode) or by making use of a time pointer (as in 'pvoc').   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The user can select between these two modes using sndwarp's  ", 	1,      5,     14,    490,    15,     5, 100 
ih		 	FLbox  	"'itimemode' input argument. Giving 'itimemode' a value of    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"zero means that a time stretching factor will be applied,    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"giving it a value of 1 means that a pointer variable will be ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"used to define from where within the source file grains      ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"begin. On account of sndwarp's dual function nature, its     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"input argument 'xtimewarp' can mean two different things     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"dependant upon the value of 'itimemode'. When itimemode=0    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'xtimewarp' defines the time-stretch factor, when itimemode=1", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"'xtimewarp' defines the pointer location in seconds.         ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"For convenience in this example 'xtimewarp' is represented by", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"two different sliders, 'Pointer' and 'Stretch Factor'. The   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"appropriate slider will be chosen by the code for the value  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"of 'xtimewarp' depending upon the current setting for the    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"'Warp/Pointer' switch. Therefore when the switch is on 'Warp'", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"the 'Pointer' slider has no effect (and vice versa).         ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Instead of defining grain sizes in seconds 'sndwarp' refers  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"to grains as 'windows'. In effect, grain size is defined in  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"samples using the 'Window Size' slider (iwsize). The         ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"'Randomization' slider (irandw) applies randomization to the ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"value for 'Window Size' (iwsize). This value defines the     ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"bandwidth of a random number generator. The random numbers   ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"will be added to 'Window Size' (iwsize).                     ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"The density of the granular synthesis texture produced is    ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"controlled using the 'Number of Overlaps' (ioverlap)         ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"parameter.                                                   ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"The pitch of the granular synthesis texture produced can be  ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"rescaled using the 'Pitch' slider (xresample).               ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"1=no transposition, 2=up one octave, 0.5=down one octave and ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"so on.                                                       ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"The user must supply a windowing function via a function     ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"table that the opcode will use to apply an amplitude envelope", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"to each grain. In this example six different envelope types  ", 	1,      5,     14,    490,    15,     5, 740
ih		 	FLbox  	"are offered for experimentation. Descriptions of the         ", 	1,      5,     14,    490,    15,     5, 760
ih		 	FLbox  	"different types on offer are included on the main panel. To  ", 	1,      5,     14,    490,    15,     5, 780
ih		 	FLbox  	"hear most clearly the effect of using different grain        ", 	1,      5,     14,    490,    15,     5, 800
ih		 	FLbox  	"envelopes set 'Number of Overlaps' to a 1 value and set      ", 	1,      5,     14,    490,    15,     5, 820
ih		 	FLbox  	"'Window Size' to a large number.                             ", 	1,      5,     14,    490,    15,     5, 840
ih		 	FLbox  	"'Inskip into Source Sound File' (ibeg) allows the user to    ", 	1,      5,     14,    490,    15,     5, 860
ih		 	FLbox  	"define where the opcode will begin reading grains from. If   ", 	1,      5,     14,    490,    15,     5, 880
ih		 	FLbox  	"this value is zero 'sndwarp' will begin reading grains from  ", 	1,      5,     14,    490,    15,     5, 900
ih		 	FLbox  	"the beginning of the source sound file.                      ", 	1,      5,     14,    490,    15,     5, 920
                                 
				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch	changed	gkolap, gkmode, gkwsize, gkrnd, gkwfn, gkbeg
;			ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
	schedkwhen	kSwitch,       0,       0,        2,        0,    -1
	endin

	instr	2		;SOUNDWARPING INSTRUMENT
if gkOnOff!	=	-1	kgoto		CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff				;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
iporttime 	= 	.1				;PORTAMENTO TIME
kporttime	linseg	0,.1,(iporttime),1,(iporttime)	;USE OF A RAMPING UP ENVELOPE PREVENTS GLIDING PARAMETERS EACH TIME A NOTE IS RESTARTED
kporttime	=		kporttime * gkporttime	;FLTK SLIDER FOR PORTAMENTO TIME MULTIPLIED TO kporttime FUNCTION
isfn 		= 	1				;SOURCE SOUND FILE FUNCTION TABLE 
iwfn 		= 	i(gkwfn) + 99			;WINDOW FUNCTION
ilen 		= 	nsamp(isfn) / sr			;DURATION (IN SECONDS) OF THE SOURCE SOUND FILE IS DERIVED
imode 		= 	i(gkmode) 		;ENTER WARP MODE: 1=POINTER / 0=PLAYBACK SPEED WARP
ibeg 		= 	i(gkbeg)		;INSKIP (O=BEGINNING OF FILE)
iolap 		= 	i(gkolap)		;NUMBER OF OVERLAPS (CONVERTED TO I-RATE)
kptr	 	=	gkptr*ilen		;DERIVE POINTER POSITION RELATIVE TO THE ACTUAL DURATION OF THE FILE USED
iwsize		=	i(gkwsize)		;WINDOW SIZE (CONVERTED TO I-RATE)
irnd		=	i(gkrnd)		;RANDOMIZATION OF WINDOW SIZE
kptr		portk	kptr,kporttime		;PORTAMENTO APPLIED TO PARAMETER TO SMOOTH CHANGES
kpch		portk	gkpch,kporttime		;PORTAMENTO APPLIED TO PARAMETER TO SMOOTH CHANGES
kamp		portk	gkamp,kporttime		;PORTAMENTO APPLIED TO PARAMETER TO SMOOTH CHANGES
kwarp		=	(imode == 0 ? gkstretch : kptr )	;CHOOSE WHETHER TO USE 'STRETCH FACTOR' OR 'POINTER POSITION'
								;SCCORDING TO THE STATUS OF 'imode'
ares 		sndwarp kamp, kwarp, kpch, isfn, ibeg, iwsize, irnd, iolap, iwfn, imode
		outs ares, ares
		endin
</CsInstruments>

<CsScore>
; THE SOUND FILE USED IN THE GRANULATION
; NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH     | IN_SKIP | FORMAT | CHANNEL(LEFT CHANNEL ONLY)
f1 0 262144 1 "AndItsAll.wav" 0 4 1

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