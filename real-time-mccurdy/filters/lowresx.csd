;Written by Iain McCurdy, 2006

;MAKE ADJUSTMENTS CAUTIOUSLY - VERY UNPLEASANT SOUNDS ARE POSSIBLE WITH THIS OPCODE - PROTECT YOUR EARS!

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
;					LABEL      | WIDTH | HEIGHT | X | Y
				FLpanel	"lowresx",    500,    200,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,   -1,     2,    150,     30,    0,   0,    0,      2,     0,       -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcutoff			FLvalue	" ",      100,    20,     0,  80
idresonance			FLvalue	" ",      100,    20,     0, 130
idamp				FLvalue	" ",      100,    20,     0, 180

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gknumlayer, ihnumlayer 		FLcount  "Number of Layers", 		1,     10,    1,     10,      1,    150,     30,  200,  0,    -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,      1,    1,      1,      2,    150,     30,  350,  0,    -1

;SLIDERS				            				MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkcutoff,ihcutoff		FLslider 	"Filter Cutoff (Not in Hertz!)",1,   5000,  -1,    5,    idcutoff,     500,     30,    0,   50
gkresonance,ihresonance		FLslider 	"Resonance",			.001, 500,  -1,    5,    idresonance,  500,     30,    0,  100
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	.001,    1, -1,    5,    idamp,        500,     30,    0,  150

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	5000, 	ihcutoff
				FLsetVal_i	1, 	ihresonance
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	1, 	ihamp
				FLsetVal_i	0, 	ihskip
				FLsetVal_i	1, 	ihnumlayer
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           lowresx                           ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Lowresx is an implementation of a resonant low-pass filter.  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Its input arguments are for filter cutoff frequency,         ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"resonance, number of iterations of the filter (optional,     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"default=4) and an optional 2-way switch (default=0) to select", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"whether the data space for feedback within the filter is     ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"initially cleared or allowed to retain previously held       ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"information.                                                 ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Cutoff frequency is not in hertz and resonance is not in     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"decibels so experimentation is recommended.                  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Use of high levels of resonance can cause significant        ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"increases in the overall output amplitude. It may be desired ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"to make use of the balance opcode to control these           ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"fluctuations in amplitude. Alternatively a control to scale  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"the output amplitude can be implemented (as has been done in ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"this example).                                               ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Lowresx is equivalent to multiple iterations of the lowres   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"opcode connected in series. Extremely loud and piercing tones", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"are possible with this opcode so use with care and protect   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"your ears and speakers!                                      ", 	1,      5,     14,    490,    15,     5, 400

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasigL, gasigR	diskin	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
kSwitch		changed	gkskip, gknumlayer	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,        0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
		endin

		instr	2
if	gkOnOff!=-1	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
aresL 		lowresx 		gasigL, gkcutoff, gkresonance, i(gknumlayer), i(gkskip)
aresR 		lowresx 		gasigR, gkcutoff, gkresonance, i(gknumlayer), i(gkskip)
		outs		aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
  		endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























