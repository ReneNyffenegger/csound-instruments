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
				FLpanel	"atone",  500,     100,   0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,  -1,     2,    150,     30,    0,   0,    0,      2,     0,       -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idhp				FLvalue	" ",      100,    20,     0,  80

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,    30,    350, 0,    -1


;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkhp, ihhp			FLslider 	"Filter Cutoff",	20,  20000, -1,    5,    idhp,   500,     30,    0,  50

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	20, 	ihhp
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	0, 	ihskip
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 180, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              atone                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Atone is an implementation of a second-order high-pass filter", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Its input arguments are for cutoff frequency (half-power     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"point) and a 2-way switch selecting whether the data space   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"for feedback within the filter is initially cleared or       ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"allowed to retain previously held information.               ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Multiple iterations of the atone opcode applied to the signal", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"path in series can be used to create a sharper cutoff slope. ", 	1,      5,     14,    490,    15,     5, 160

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
		
		instr	2	;INSTRUMENT THAT DOES THE FILTERING
if	gkOnOff!=-1	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
aresL 		atone 	gasigL, gkhp, i(gkskip)
aresR 		atone 	gasigR, gkhp, i(gkskip)
		outs	aresL, aresR	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS
  		endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























