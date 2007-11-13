;Written by Iain McCurdy, 2006

;CAREFUL MONITORING OF THE OUTPUT AMPLITUDE IS NEEDED TO PREVENT DISTORTION

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
;					LABEL    | WIDTH | HEIGHT | X | Y
				FLpanel	"vlowres",  500,     250,   0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,   -1,     2,    150,     30,    0,  0,    0,      2,      0,      -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",      100,     20,    0,  80
idres				FLvalue	" ",      100,     20,    0, 130
idsep				FLvalue	" ",      100,     20,    0, 180
idamp				FLvalue	" ",      100,     20,    0, 230

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkord, ihord 			FLcount  "Number of Ordinates", 	1,    10,     1,      1,     2,     150,     30,   350, 0,    -1

;SLIDERS				            				MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkfco,ihfco			FLslider 	"Filter Cutoff (Not in Hertz!)",1,   5000,  -1,    5,    idfco,        500,     30,    0,   50
gkres,ihres			FLslider 	"Resonance",			.01,  500,  -1,    5,    idres,        500,     30,    0,  100
gksep,ihsep			FLslider 	"Separation (in oct)",		0,    100,   0,    5,    idsep,        500,     30,    0,  150
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    5,    idamp,        500,     30,    0,  200

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	5000, 	ihfco
				FLsetVal_i	1, 	ihres
				FLsetVal_i	0, 	ihsep
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	1, 	ihamp
				FLsetVal_i	1, 	ihord
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 400, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          vlowres                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"vlowres is an implementation of a resonant low-pass filter.  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Its input arguments are for filter cutoff frequency,         ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"resonance, number of parallel iterations of the filter       ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"(1 to 10) and cutoff frequency separation between the first  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"and last filters. Cutoff frequency is not in hertz and       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"resonance is not in decibels so experimentation is needed.   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"Use of high levels of resonance can cause significant        ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"increases in the overall output amplitude. It may be desired ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"to make use of the balance opcode to control these           ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"fluctuations in amplitude. Alternatively a control to scale  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"the output amplitude can be implemented (as has been done in ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"this example).                                               ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"vlowres is equivalent to multiple iterations of the lowres   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"opcode connected in parallel with cutoff frequencies spaced  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"according to a combination of the Separation and the Number  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"of Ordinates arguments. Separation defines the interval in   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"hertz between the first and last filters, intervening filter ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"cutoff frequencies are spaced evenly.                        ", 	1,      5,     14,    490,    15,     5, 380

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasigL, gasigR	diskin	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
kSwitch		changed	gkord	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,        0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
		endin
			
		instr	2
if	gkOnOff!=-1	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
aresL 		vlowres 	gasigL, gkfco, gkres, i(gkord), gksep
aresR 		vlowres 	gasigR, gkfco, gkres, i(gkord), gksep
		outs		aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
  		endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























