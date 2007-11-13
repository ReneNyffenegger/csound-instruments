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
	FLpanel	"fog",   500,     600,   0,  0

;TEXT BOXES              					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ihtmodelabel	 FLbox  "0-Grain-by-Grain  1-Continuous", 	1,     9,      12,   150,     30,    150, 50

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gktransmode, ihtransmode	FLcount  "Transposition Mode",	0,     1,     1,      1,     2,     150,    30,    150, 0,   -1

;SWITCHES					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,   -1,     2,    150,     30,    0,  0,    0,      2,      0,      -1


;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idptr		FLvalue	" ",      90,     20,    0, 130
iddens		FLvalue	" ",      90,     20,    0, 180
idoct		FLvalue	" ",      90,     20,    0, 230
idtrans		FLvalue	" ",      90,     20,    0, 280
iddur		FLvalue	" ",      90,     20,    0, 330
idris		FLvalue	" ",      90,     20,    0, 380
iddec		FLvalue	" ",      90,     20,    0, 430
idband		FLvalue	" ",      90,     20,    0, 480
idamp		FLvalue	" ",      90,     20,    0, 530
idphs		FLvalue	" ",      90,     20,    0, 580

;SLIDERS					      					MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkptr, ihptr		FLslider	"Pointer (portamento applied)",  		0,     1,    0,     5,      idptr,     500,     30,    0, 100
gkdens, ihdens		FLslider	"Density (portamento applied)",  		1,    200,   0,     5,      iddens,    500,     30,    0, 150
gkoct, ihoct		FLslider	"Octaviation Index",  				0,    4,     0,     5,      idoct,     500,     30,    0, 200
gktrans, ihtrans	FLslider	"Transposition Factor (portamento applied)",  	-2,   2,     0,     5,      idtrans,   500,     30,    0, 250
gkdur, ihdur		FLslider	"Grain Duration",  				.01,  .2,    0,     5,      iddur,     500,     30,    0, 300
gkris, ihris		FLslider	"Grain Rise Time",  				.001, .2,    0,     5,      idris,     500,     30,    0, 350
gkdec, ihdec		FLslider	"Grain Decay Time",  				.001, .2,    0,     5,      iddec,     500,     30,    0, 400
gkband, ihband		FLslider	"Bandwidth (Grain Exponential Decay)",  	0,    100,   0,     5,      idband,    500,     30,    0, 450
gkamp, ihamp		FLslider	"Amplitude",  					0,    10000, 0,     5,      idamp,     500,     30,    0, 500
gkphs, ihphs		FLslider	"Initial Phase Of Fundamental (i-rate)",	0,    1,     0,     5,      idphs,     500,     30,    0, 550
gkporttime,ihporttime	FLslider 	"Portamento Amount",				0,    1,     0,     5,      -1,        190,     10,  305,  10

; INITIALISATION OF SLIDERS
			FLsetVal_i   	0,	ihtransmode
			FLsetVal_i   	.3,	ihptr
			FLsetVal_i   	20,	ihdens
			FLsetVal_i   	0,	ihoct
			FLsetVal_i   	1,	ihtrans
			FLsetVal_i   	.1,	ihdur
			FLsetVal_i   	.01,	ihris
			FLsetVal_i   	.01,	ihdec
			FLsetVal_i   	10,	ihband
			FLsetVal_i   	6000,	ihamp
			FLsetVal_i   	0,	ihphs
			FLsetVal_i	.5, 	ihporttime

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 680, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            fog                              ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Fog performs granular synthesis upon sound material stored   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"within a GEN 1 function table using a method that bears many ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"simularities to the fof opcode.                              ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The amplitude envelope that is applied to each grain is      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"controlled by a combination of the 'Grain Duration' (kdur),  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"'Grain Rise Time' (kris), 'Grain Decay Time' (kdec) and      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"'Bandwidth (Grain Exponential Decay)' (kband). Bandwidth     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"controls how an exponential curve defined in a separate      ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"function is applied to the decay of each grain.              ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"'Pointer' (aspd) defines the point from within the stored    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"sound file (range 0-1) that grains will be read.             ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'Density' (kdens) controls the frequency of grain duration in", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"grains per second.                                           ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"'Transposition Factor' (ktrans) controls the transposition of", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"each grain. 1=no transposition. 2=up one octave. 0.5=down one", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"octave and so on... A minus sign indicates that grains will  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"be played backwards, the numerical part functions in the same", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"way.                                                         ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"'Transposition Mode' (itmode) is a 2-way switch defining     ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"whether transposition modulation is carried out on a grain by", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"grain basis or continually, even within the duration of a    ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"grain. To appreciate this effect first create a texture with ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"large sparse grains.                                         ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"'Octaviation Index' (koct) is typically zero but as it tends ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"to 1 every other grain is increasingly attenuated. When it is", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"exactly 1 the grain density is effectively halved. From 1 to ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"2 the process is repeated and the density is halved again and", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"so on from 2 to 3 and beyond. This effect is perceived quite ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"differently for dense and sparse textures.                   ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"In this example a controllable amount of portamento is       ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"applied to 'Pointer', 'Transposition Factor' and 'Density' in", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"order to allow smoother changes of their values.             ", 	1,      5,     14,    490,    15,     5, 660

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed	gktransmode, gkphs	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				TRIGGER  | MINTIM | MAXNUM | INSNUM | WHEN | DUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,     0,       0,        2,     0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
		endin

		instr	2	;FOG INSTRUMENT
if gkOnOff	!=	-1	kgoto CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff				;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
iporttime 	= 	.1				;PORTAMENTO TIME
kporttime	linseg	0,.1,(iporttime),1,(iporttime)	;USE OF A RAMPING UP ENVELOPE PREVENTS GLIDING PARAMETERS EACH TIME A NOTE IS RESTARTED
kporttime	=		kporttime * gkporttime	;FLTK SLIDER FOR PORTAMENTO TIME MULTIPLIED TO kporttime FUNCTION

ifnSoundFile	=	1	; FUNCTION TABLE NUMBER OF THE SOUND FILE THAT WILL BE GRANULATED
ifnRiseDecayShape=	2	; FUNCTION TABLE THAT DEFINES THE SHAPE OF THE ATTACK AND DECAY OF EACH GRAIN

kptr		=	gkptr * (nsamp(ifnSoundFile)/ftlen(ifnSoundFile))	;KPTR VALUE IS RESCALED TO ACCOUNT FOR UNUSED SAMPLES
									;IN THE FUNCTION TABLE

iNumOverLaps	=	200	; MAXIMUM NUMBER OF OVERLAPS (OVERESTIMATATION IS A GOOD IDEA HERE TO PREVENT CRASHES)

itotdur		=	3600	; JUST PUT A LARGE NUMBER HERE FOR REAL TIME - FOR NON-REAL TIME GIVE IT p3

kdens		portk	gkdens,  kporttime	;PORTAMENTO IS APPLIED TO SMOOTH VALUE CHANGES VIA THE FLTK SLIDERS
ktrans		portk	gktrans, kporttime      ;PORTAMENTO IS APPLIED TO SMOOTH VALUE CHANGES VIA THE FLTK SLIDERS
kptr		portk	kptr,    kporttime      ;PORTAMENTO IS APPLIED TO SMOOTH VALUE CHANGES VIA THE FLTK SLIDERS
aptr		interp	kptr			;A NEW A-RATE VARIABLE (aptr) IS CREATED BASE ON kptr

;                                                                                                                                       OPTIONAL->
asignal		fog	gkamp, kdens, ktrans, aptr, gkoct, gkband, gkris, gkdur, gkdec, iNumOverLaps, ifnSoundFile, ifnRiseDecayShape, itotdur, i(gkphs), i(gktransmode)
		outs	asignal, asignal	;OUTPUT OF fog OPCODE IS SENT TO THE OUTPUTS
		endin

</CsInstruments>

<CsScore>
; THE SOUND FILE USED IN THE GRANULATION
; NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH     | IN_SKIP | FORMAT | CHANNEL
f  1        0      524288       1       "AndItsAll.wav"    0         4        1 

; CURVE USED TO FORM ATTACK AND DECAY PORTIONS OF EACH GRAIN
; NUM | INIT_TIME | SIZE | GEN_ROUTINE |  PARTIAL_NUMBER_1 | STRENGTH_1 | PHASE_1 | DC_OFFSET_1
f  2        0      524288      19         .5                     .5          270         .5	; I.E. A RISING SIGMOID

i 1 0 3600		;INSTRUMENT 1 PLAYS FOR 1 HOUR (ALSO KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>