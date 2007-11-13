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
;					LABEL           | WIDTH | HEIGHT | X | Y
				FLpanel	"butterbr/butbr",  500,    150,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,   -1,    2,     150,     30,    0,   0,    0,     2,      0,      -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfreq				FLvalue	" ",     100,     20,     0,  80
idband				FLvalue	" ",     100,     20,     0,  130

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,     2,     150,     30,   350, 0,    -1

;SLIDERS				            			MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkfreq,ihfreq			FLslider 	"Filter Cutoff",	20,  20000, -1,    5,      idfreq,     500,     30,   0,     50
gkband,ihband			FLslider 	"Bandwidth",		20,  10000, -1,    5,      idband,     500,     30,   0,    100

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	900, 	ihfreq
				FLsetVal_i	1000, 	ihband
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	0, 	ihskip
			
				FLpanel_end
				
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 360, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       butterbr/butbr                        ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Butterbr/butbr is an implementation of a second-order IIR    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Butterworth band-reject filter. Its input arguments are for  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"filter cutoff frequency (in hertz), and bandwidth (also in   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"hertz) of the spectral band removed by the filter.           ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"An optional 2-way switch (default=0) is provided to select   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"whether the data space for feedback within the filter is     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"initially cleared or allowed to retain previously held       ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"information.                                                 ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Butterbr/butbr is slower than the original filters in Csound ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"but provides an almost flat passband (particularly when      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"compared to the areson filter).                              ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Multiple iterations of the butterbr/butbr opcode applied to  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the signal path in series can be used to create a sharper    ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"cutoff slope.                                                ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"The audible results of the butterbr/butbr filter are not     ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"dissimilar to those of a phaser effect.                      ", 	1,      5,     14,    490,    15,     5, 340

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasigL, gasigR	diskin	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
kSwitch		changed	gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,        0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
		endin
				
		instr	2
if	gkOnOff!=-1	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
aresL 		butbr 	gasigL, gkfreq, gkband, i(gkskip)
aresR 		butbr 	gasigR, gkfreq, gkband, i(gkskip)
		outs	aresL, aresR	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS
  		endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























