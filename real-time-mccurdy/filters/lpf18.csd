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
				FLpanel	"lpf18",   500,    250,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,   -1,     2,    150,     30,    0,  0,    0,      1,      0,      -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",     100,    20,   0, 80
idres				FLvalue	" ",     100,    20,   0,130
iddist				FLvalue	" ",     100,    20,   0,180
idfrq				FLvalue	" ",     100,    20,   0,230

;SLIDERS				            				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X  | Y
gkfco,ihfco			FLslider 	"Filter Cutoff",		20,  19000, -1,    5,    idfco,  500,     30,    0,   50
gkres,ihres			FLslider 	"Resonance",			0,       1,  0,    5,    idres,  500,     30,    0,  100
gkdist,ihdist			FLslider 	"Distortion",			0,      11,  0,    5,   iddist,  500,     30,    0,  150
gkfrq,ihfrq			FLslider 	"Oscillator Frequency",		20,  20000, -1,    5,    idfrq,  500,     30,    0,  200

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	19000, 	ihfco
				FLsetVal_i	0, 	ihres
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	0, 	ihdist
				FLsetVal_i	100, 	ihfrq
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 320, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          lpf18                              ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Lpf18 is a implementation of a 3-pole resonant low-pass      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"filter. The '18' refers to the statistic that states that    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"amplitude drops off at 18 decibels per octave beyond the     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"cutoff frequency.                                            ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"The opcode's input arguments include cutoff frequency,       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"resonance and distortion.                                    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"Use of resonance and distortion can cause an increase in     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"amplitude. To accomodate this phenomenon this example        ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"includes a control to scale down the output amplitude.       ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"An alternative approach would be to make use of the balance  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"opcode to dynamically control the output signal.             ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"The input signal used in this example is a triangle waveform,", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the frequency of which is adjustable using an on-screen      ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"slider.                                                      ", 	1,      5,     14,    490,    15,     5, 300

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gir 	ftgen 	1, 0, 131072, 10, 1	;SINE WAVE FUNCTION TABLE

		instr	1
if	gkOnOff!=-1	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
asig		vco 	1, gkfrq, 1, 0	;GENERATE A TRIANGLE WAVE AUDIO SIGNAL (NOTE THAT lpf18 EXPECTS A SIGNAL WITHIN THE RANGE -1 TO 1)
kporttime	linseg	0,.01,.01,1,.01	;kporttime ramps up to a held value of .01 in .01 of a second
kfco		portk	gkfco, kporttime	;PORTAMENTO IS APPLIED TO THE SLIDER VARIABLE gkfco IN ORDER TO SMOOTH ITS MOVEMENT SLIGHTLY
ares 		lpf18 	asig,  kfco, gkres, gkdist
		outs	ares * 32768, ares * 32768	;FILTER OUTPUT IS SENT TO THE AUDIO OUTPUTS AND SCALED UP IN ORDER TO BE AUDIBLE
  		endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























