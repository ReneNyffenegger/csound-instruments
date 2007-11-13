;Written by Iain McCurdy, 2006

;ELLIPTICAL FILTER DESIGN NOT IMPLEMENTED YET!

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
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"clfilt",  500,    350,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,   -1,     2,    150,     30,    0,  0,    0,      2,      0,       -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfreq				FLvalue	" ",      70,      20,    0,  80
idamp				FLvalue	" ",      70,      20,    0, 230
idpbr				FLvalue	" ",      70,      20,    0, 280
idsba				FLvalue	" ",      70,      20,    0, 330

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gktype, ihtype 			FLcount  "Type", 			0,      1,    1,      1,      2,    150,     30,     0, 100,   -1
gknpol, ihnpol 			FLcount  "Number of Poles", 		2,     80,    2,     80,      1,    150,     30,   175, 100,   -1
gkkind, ihkind 			FLcount  "Filter Design", 		0,      3,    1,      1,      2,    150,     30,   350, 100,   -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,      1,    1,      1,      2,    150,     30,   350,   0,   -1

;SLIDERS				            								MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkfreq, ihfreq			FLslider 	"Filter Cutoff",						20,  20000, -1,    5,     idfreq,      500,      30,   0,    50
gkamp, ihamp			FLslider 	"Output Amplitude Rescaling",					0,      10,  0,    5,      idamp,      500,      30,   0,   200
gkpbr, ihpbr			FLslider 	"Pass Band Ripple (Chebyshev Type I and Elliptical)",		.1,     50,  0,    5,      idpbr,      500,      30,   0,   250
gksba, ihsba			FLslider 	"Stop Band Attenuation (Chebyshev Type II and Elliptical)",	-60,    -1,  0,    5,      idsba,      500,      30,   0,   300

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	7000, 	ihfreq
				FLsetVal_i	0, 	ihtype
				FLsetVal_i	2, 	ihnpol
				FLsetVal_i	0, 	ihkind
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	1, 	ihamp
				FLsetVal_i	1, 	ihpbr
				FLsetVal_i	-60, 	ihsba
				FLsetVal_i	0, 	ihskip

;TEXT BOXES								TYPE | FONT | SIZE | WIDTH | HEIGHT | X  | Y
ih		 	FLbox  	"0-Low-pass     1-High-pass", 		1,      1,     12,    150,    20,      0, 150
ih		 	FLbox  	"0-Butterworth  1-Chebyshev I ", 	1,      1,     11,    150,    18,    350, 150
ih		 	FLbox  	"2-Chebyshev II   3-Elliptical", 	1,      1,     11,    150,    18,    350, 170
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          clfilt                             ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Clfilt implements low and high-pass filters of various types.", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Experimentation is needed and care must be taken as certain  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"combinations of setting can crash Csound.                    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The number of poles (an even number between 2 and 80)        ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"directly relates to the steepness of the cutoff slope.       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Four types of filter are offered: Butterworth, Chebyshev Type", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"I, Chebyshev Type II and Elliptical (not implemented yet but ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"included in this example for the future).                    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The filter type argument is optional and defaults to         ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Butterworth.                                                 ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"Pass band ripple (optional, defaults to 1dB) controls the    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"amplitude of the ripple at the cutoff frequency. (This is    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"heard as a resonance at the cutoff frequency.) The pass band ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"ripple control is ignored by Butterworth and Chebyshev Type  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"II.                                                          ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Stop Band Attenuation (optional, default -60dB) controls the ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"amount of attenuation (in dBs) that is imposed beyond the    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"cutoff frequency. Stop Band Attenuation is ignored by        ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"Butterworth and Chebyshev Type I.                            ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"An optional 2-way switch (default=0) is used to select       ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"whether the data space for feedback within the filter is     ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"initially cleared or allowed to retain previously held       ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"information.                                                 ", 	1,      5,     14,    490,    15,     5, 480

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasigL, gasigR	diskin	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
kSwitch		changed	gktype, gknpol, gkkind, gkpbr, gksba, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,        0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
		endin
		
		instr	2
if	gkOnOff!=-1	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
aresL 		clfilt 	gasigL, gkfreq, i(gktype), i(gknpol) , i(gkkind) , i(gkpbr), i(gksba), i(gkskip)
aresR 		clfilt 	gasigR, gkfreq, i(gktype), i(gknpol) , i(gkkind) , i(gkpbr), i(gksba), i(gkskip)
		outs	aresL * gkamp, aresR * gkamp;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
  		endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























