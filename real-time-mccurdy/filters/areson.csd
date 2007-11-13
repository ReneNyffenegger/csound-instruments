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
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"areson", 500,    300,    0,  0
 
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,  -1,     2,    150,     30,    0,   0,    0,      2,     0,        -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcf				FLvalue	" ",      100,     20,    0,  80
idbw				FLvalue	" ",      100,     20,    0, 130
idamp				FLvalue	" ",      100,     20,    0, 280

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE
gkscl, ihscl 			FLcount  "Scaling Mode", 		0,     2,     1,      1,      2,    150,     30,     0,  150,   -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     30,   350,    0,   -1

;SLIDERS					            			MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkcf,ihcf			FLslider 	"Filter Centre Frequency",	20,  20000, -1,    5,      idcf,       500,      30,   0,    50
gkbw,ihbw			FLslider 	"Bandwidth",			.1,  10000, -1,    5,      idbw,       500,      30,   0,   100
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    5,      idamp,      500,      30,   0,   250

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	10000, 	ihcf
				FLsetVal_i	1000, 	ihbw
				FLsetVal_i	1, 	ihscl
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	1, 	ihamp
				FLsetVal_i	0, 	ihskip

;TEXT BOXES																ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"Scaling Modes:    0-None    1-Peak Response Factor of 1    2-Overall RMS Response Factor equals 1", 	1,        9,    12,    500,    30,     0, 200
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 400, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              areson                         ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Areson is an implementation of a resonant second-order notch ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"filter.                                                      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Its input arguments are for filter centre frequency (in      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"hertz), bandwidth of the notch (also in hertz) a 3-way switch", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"offering a choice 3 methods by which the output amplitude    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"will be dynamically scaled and a 2-way switch selecting      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"whether the data space for feedback within the filter is     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"initially cleared or allowed to retain previously held       ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"information.                                                 ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"The audible results of the areson filter are not dissimilar  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"to those of a phaser effect.                                 ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Setting 'Scaling Mode' to 0 will provide the most dynamically", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"transparent effect but some manual rescaling of the amplitude", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"of the output signal may be necessary. In this example this  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"can be performed using the 'Output Amplitude Scaling' slider.", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Settings for 'Scaling Mode' of 1 or 2 force dynamic          ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"containment of the output signal similar to the effect of a  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"compressor.                                                  ", 	1,      5,     14,    490,    15,     5, 380

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasigL, gasigR	diskin	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
kSwitch		changed	gkscl, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;					ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
			schedkwhen	kSwitch,             0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
	endin
		
		instr	2
if	gkOnOff!=-1	goto	CONTINUE ; SENSE FLTK ON/OFF SWITCH
			turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
CONTINUE:
aresL 		areson 	gasigL, gkcf, gkbw , i(gkscl), i(gkskip)
aresR 		areson 	gasigR, gkcf, gkbw , i(gkscl), i(gkskip)

		outs	aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
  		endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























