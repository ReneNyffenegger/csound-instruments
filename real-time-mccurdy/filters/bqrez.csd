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
				FLpanel	"bqrez",  500,    300,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,   -1,    2,     150,     30,    0,  0,     0,     2,      0,       -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",      100,    20,     0,  80
idres				FLvalue	" ",      100,    20,     0, 130
idamp				FLvalue	" ",      100,    20,     0, 280

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkmode, ihmode 			FLcount  "Type", 			0,     4,     1,      1,      2,    150,     30,     0, 150,   -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     30,   350,   0,   -1

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkfco,ihfco			FLslider 	"Filter Cutoff",	20,  20000, -1,    5,   idfco,   500,     30,    0,  50
gkres,ihres			FLslider 	"Resonance",		1,     100,  0,    5,   idres,   500,     30,    0, 100
gkamp,ihamp			FLslider 	"Amplitude",		0,       1,  0,    5,   idamp,   500,     30,    0, 250

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	20000, 	ihfco
				FLsetVal_i	1, 	ihres
				FLsetVal_i	0, 	ihmode
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	1, 	ihamp
				FLsetVal_i	0, 	ihskip

;TEXT BOXES												ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"0-Low-pass   1-High-pass   2-Band-pass   3-Band-reject   4-All-pass", 	1,        9,    12,    400,    30,     0, 200
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              bqrez                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Bqrez is an implementation of a second-order multi-mode      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"filter. Its input arguments are for filter cutoff frequency, ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"amount of resonance, a five-way switch selecting filter mode ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"and a 2-way switch selecting whether the data space for      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"feedback within the filter is initially cleared or allowed   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"to retain previously held information.                       ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"Use of resonance can create large increases in amplitude in  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"the output signal. In may be necessary, therefore, to rescale", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"the amplitude of the output signal. In this example a slider ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"has been provided to achieve this.                           ", 	1,      5,     14,    490,    15,     5, 220

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasigL, gasigR	diskin	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
kSwitch		changed	gkmode, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,        0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
		endin
	
		instr	2	;INSTRUMENT THAT DOES THE FILTERING
if	gkOnOff!=-1	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
aresL 		bqrez 	gasigL, gkfco, gkres , i(gkmode), i(gkskip)
aresR 		bqrez 	gasigR, gkfco, gkres , i(gkmode), i(gkskip)
		outs	aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER DERIVED VARIABLE gkamp 
  		endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>
</CsoundSynthesizer>



























