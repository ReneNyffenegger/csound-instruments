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
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"tbvcf",   500,    300,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,   -1,    2,     150,     30,    0,  0,    0,      2,      0,      -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",      100,    20,     0,  80
idq				FLvalue	" ",      100,    20,     0, 130
iddist				FLvalue	" ",      100,    20,     0, 180
idasym				FLvalue	" ",      100,    20,     0, 230
idfrq				FLvalue	" ",      100,    20,     0, 280

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,    30,    350, 0,    -1

;SLIDERS				            				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X  | Y
gkfco,ihfco			FLslider 	"Filter Cutoff",		750,11000, -1,    5,   idfco,   500,     30,    0,   50
gkres,ihres			FLslider 	"Resonance",			0,       2,  0,    5,   idq,     500,     30,    0,  100
gkdist,ihdist			FLslider 	"Distortion",			0,       2,  0,    5,   iddist,  500,     30,    0,  150
gkasym,ihasym			FLslider 	"Asymmetry",			0,       1,  0,    5,   idasym,  500,     30,    0,  200
gkfrq,ihfrq			FLslider 	"Oscillator Frequency",		20,  20000, -1,    5,   idfrq,   500,     30,    0,  250

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	11000, 	ihfco
				FLsetVal_i	0, 	ihres
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	2, 	ihdist
				FLsetVal_i	.5, 	ihasym
				FLsetVal_i	100, 	ihfrq
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 260, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          tbvcf                              ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Tbvcf attempts to emulate the resonant low-pass filter on the", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Roland TB-303 Bassline ® synthesiser.                        ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The opcode includes input arguments for cutoff frequency,    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"resonance, distortion and asymmetry of the resonance.        ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"The lower limit for cutoff frequency must be set somewhat    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"higher than expected. In this example that limit is set to   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"700 Hz, setting the cutoff frequency much below this can     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"cause crashes. High cutoff setting can also cuase crashes.   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The input signal used in this example is a triangle waveform,", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"the frequency of which is adjustable using an on-screen      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"slider.                                                      ", 	1,      5,     14,    490,    15,     5, 240

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gir 	ftgen 	1, 0, 131072, 10, 1	;SINE WAVE FUNCTION TABLE

		instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed	gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,        0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
		endin
		
		instr		2
if	gkOnOff!=-1	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
asig		vco 		1, gkfrq, 1, 0	;GENERATE A TRIANGLE WAVE AUDIO SIGNAL (NOTE THAT tbvcf EXPECTS A SIGNAL WITHIN THE RANGE -1 TO 1)
kporttime	linseg	0,.01,.01,1,.01	;kporttime ramps up to a held value of .01 in .01 of a second
kfco		portk	gkfco, kporttime	;PORTAMENTO IS APPLIED TO THE SLIDER VARIABLE gkfco IN ORDER TO SMOOTH ITS MOVEMENT SLIGHTLY
ares 		tbvcf 		asig, kfco, gkres, gkdist, gkasym, i(gkskip)
		outs	ares * 10000, ares * 10000	;FILTER OUTPUT IS SENT TO THE AUDIO OUTPUTS AND SCALED UP IN ORDER TO BE AUDIBLE
  		endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























