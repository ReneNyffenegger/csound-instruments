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

;			LABEL | WIDTH | HEIGHT | X | Y
		FLpanel	"fof",   500,    450,    0,  0

;SWITCHES					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,   -1,     2,    150,     30,    0,  0,     0,     1,      0,       -1

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",	80,      20,    0,   80
idfund			FLvalue	" ",	80,      20,    0,  130
idform			FLvalue	" ",	80,      20,    0,  180
idoct			FLvalue	" ",	80,      20,    0,  230
idband			FLvalue	" ",	80,      20,    0,  280
iddur			FLvalue	" ",	80,      20,    0,  330
idris			FLvalue	" ",	80,      20,    0,  380
iddec			FLvalue	" ",	80,      20,    0,  430

;SLIDERS					      		MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",  		0,   10000,  0,    5,    idamp,     500,     30,    0,   50
gkfund, ihfund		FLslider	"Fundemental (Hz.)",   	1,    5000, -1,    5,    idfund,    500,     30,    0,   100
gkform, ihform		FLslider	"Formant (Hz.)",	20,   5000, -1,    5,    idform,    500,     30,    0,   150
gkoct, ihoct		FLslider	"Octaviation Factor",	0,       8,  0,    5,    idoct,     500,     30,    0,   200
gkband, ihband		FLslider	"Bandwidth",		0,     100,  0,    5,    idband,    500,     30,    0,   250
gkdur, ihdur		FLslider	"Duration",		.017,    1,  0,    5,    iddur,     500,     30,    0,   300
gkris, ihris		FLslider	"Rise Time",		.001,  .05,  0,    5,    idris,     500,     30,    0,   350
gkdec, ihdec		FLslider	"Decay Time",		.001,  .05,  0,    5,    iddec,     500,     30,    0,   400

; INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	7000, 	ihamp
		FLsetVal_i	2, 	ihfund
		FLsetVal_i	700, 	ihform
		FLsetVal_i	0, 	ihoct
		FLsetVal_i	50, 	ihband
		FLsetVal_i	.1, 	ihdur
		FLsetVal_i	.003, 	ihris
		FLsetVal_i	.007, 	ihdec

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL

				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            fof                              ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Fof (fonction d'onde formantique) is a rather specialised    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"type of granular synthesis in that its intended use is the   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"creation of vocal vowel sounds through the use of rapidly    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"repeated sine wave grains. (The should not be viewed as a    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"restriction upon it being used less conventionally.)         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"If the user starts this example the first thing that is heard", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"is a stream of repeated pulses in which each pulse is easily ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"discernible. The pitch of each grain is just about           ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"discernible.                                                 ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"If the 'Formant' slider is moved it is heard that the pitch  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"of each grain is modulated.                                  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"If the 'Fundemental' slider is slowly moved from left to     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"right it is heard that the frequency of grain repetition     ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"increases. As we pass about 35 hertz we are no longer able   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"distinguish individual grains and instead a new tone emerges ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"which is a consequence of the periodically repeating         ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"identical grains.                                            ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"Keep 'Fundemental' at a highish value (say 200 Hz.) and now  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"move the 'Formant' slider. The effect this time is of a      ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"bandpass filter being applied to the tone. A formant is      ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"really just a peak of energy on a harmonic sound spectrum.   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"The phenomena just demonstrated are the fundemental          ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"principles behind fof synthesis. To convincingly imitate     ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"vowel sounds of the human voice about six simulataneous fof  ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"signals are needed. The next example demonstrates this.      ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"The amplitude envelope that is applied to each grain is      ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"controlled by a combination of the 'Duration' (kdur), 'Rise  ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"Time' (kris), 'Decay Time' (kdec) and 'Bandwidth' (kband).   ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"Bandwidth controls how an exponential curve defined in a     ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"separate function is applied to the decay of each grain.     ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"'Octaviation Index' (koct) is typically zero but as it tends ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"to 1 every other grain is increasingly attenuated. When it is", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"exactly 1 the grain density is effectively halved and the fof", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"fundemental is dropped by one octave. From 1 to 2 the process", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"is repeated and the density is halved again and so on from 2 ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"to 3 and beyond. This effect is perceived quite differently  ", 	1,      5,     14,    490,    15,     5, 740
ih		 	FLbox  	"for dense and sparse textures.                               ", 	1,      5,     14,    490,    15,     5, 760

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr	1
if gkOnOff	!=	-1	kgoto CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff				;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:

iporttime	=	.2				; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
kporttime	linseg	0,(.01),iporttime,(1),iporttime	; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME

kamp	portk	gkamp, kporttime	;APPLY PORTAMENTO TO SELECTED FLTK SLIDER VARIABLE AND CREATE NEW NON-GLOBAL VARIABLES TO BE USED BY THE FOF OPCODE
kfund	portk	gkfund, kporttime       ;APPLY PORTAMENTO TO SELECTED FLTK SLIDER VARIABLE AND CREATE NEW NON-GLOBAL VARIABLES TO BE USED BY THE FOF OPCODE
kform	portk	gkform, kporttime       ;APPLY PORTAMENTO TO SELECTED FLTK SLIDER VARIABLE AND CREATE NEW NON-GLOBAL VARIABLES TO BE USED BY THE FOF OPCODE

iolaps	=	500		;MAXIMUM ALLOWED NUMBER OF GRAIN OVERLAPS (THE BEST IDEA IS TO SIMPLY OVERESTIMATE THIS VALUE)
ifna	=	1		;WAVEFORM USED BY THE GRAINS (NORMALLY A SINE WAVE)
ifnb	=	2		;WAVEFORM USED IN THE DESIGN OF THE EXPONENTIAL ATTACK AND DECAY OF THE GRAINS
itotdur	=	3600		;TOTAL DURATION OF THE FOF NOTE. IN NON-REALTIME THIS WILL BE p3. IN REALTIME OVERESTIMATE THIS VALUE, IN THIS CASE 1 HOUR - PERFORMANCE CAN STILL BE INTERRUPTED PREMATURELY
;THE FOF OPCODE:
asig 	fof 	gkamp, kfund, kform, gkoct, gkband, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur ;[, iphs] [, ifmode] [, iskip
	outs	asig, asig	;OUTPUT OF fof OPCODE IS SENT TO THE OUTPUTS  
	endin

</CsInstruments>

<CsScore>
f1 0 4096 10 1			;SINE WAVE
f2 0 1024 19 .5 .5 270 .5	;EXPONENTIAL CURVE

f 0 3600	;DUMMY SCORE EVENT - PERMITS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>