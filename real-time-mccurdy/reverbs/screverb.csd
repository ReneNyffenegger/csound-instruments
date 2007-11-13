;Written by Iain McCurdy, 2006

;THE screverb OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
;THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

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
;			LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"screverb", 500,    300,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idfblvl				FLvalue	" ",     100,    20,     0,  80
idfco				FLvalue	" ",     100,    20,     0, 130
idpitchm			FLvalue	" ",     100,    20,     0, 180
idmix				FLvalue	" ",     100,    20,     0, 230
idamp				FLvalue	" ",     100,    20,     0, 280

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     30,   350, 0,    -1

;SLIDERS					            		MIN |  MAX  | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkfblvl, ihfblvl		FLslider 	"Feedback Level",		0,       1,    0,    5,   idfblvl,   500,     30,    0,  50
gkfco, ihfco		FLslider 	"Cutoff Frequency",		20,  20000,   -1,    5,   idfco,     500,     30,    0, 100
gkpitchm, ihpitchm	FLslider 	"Delay Time Modulation",	0,      20,    0,    5,   idpitchm,  500,     30,    0, 150
gkmix, ihmix		FLslider 	"Dry/Wet Mix",			0,       1,    0,    5,   idmix,     500,     30,    0, 200
gkamp, ihamp		FLslider 	"Amplitude",			0,       1,    0,    5,   idamp,     500,     30,    0, 250

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.7, 	ihfblvl
		FLsetVal_i	10000, 	ihfco
		FLsetVal_i	.6, 	ihamp
		FLsetVal_i	1, 	ihpitchm
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	-1, 	ihOnOff

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           screverb                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"screverb is an implementation of an 8 delay line stereo FDN  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"reverb, with feedback matrix based upon physical modeling    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"scattering junction of 8 lossless waveguides of equal        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"characteristic impedance. This opcode is based on a Csound   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"orchestra version of the described algorithm by Sean         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Costello.                                                    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Rather than explicity define reverb time, the length of the  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"reverb tail is defined by a feedback control (range 0 to 1). ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"A value of of 0 here removes the reverb effect and a value of", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"1 creates a reverb effect of infinite duration. The author   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of the opcode suggests 0.6 for a small live room sound, 0.8  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"for a small hall and 0.9 for a large hall.                   ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"First order lowpass filters are placed in the feedback loops ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"of the 8 delays lines, the cutoff frequencies of these are   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"controllable from a single input argument here represented   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"by the 'cutoff frequency' slider.                            ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Optional arguments are for a value defining the expected     ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"sample rate (default=44100), a value defining the amount of  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"delay time modulation employed (default=1).                  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"An optional 2-way switch (default=0) is provided, if non-zero", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"initialisation will, whenever possible, be skipped.          ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"In this example a dry/wet crossfader is included.            ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"High settings for feedback can create amplitude build ups so ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"a slider for rescaling amplitude is also included.           ", 	1,      5,     14,    490,    15,     5, 480

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:	
kSwitch		changed		gkpitchm, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gaSigL, gaSigR	diskin	"808loop.wav",     1,       0,        1
		endin

		instr 		2
		denorm		gaSigL, gaSigR	;DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
arvbL, arvbR 	reverbsc 	gaSigL, gaSigR, gkfblvl, gkfco, sr, i(gkpitchm), i(gkskip) 
amixL		ntrpol		gaSigL, arvbL, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
amixR		ntrpol		gaSigR, arvbR, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
		outs		amixL * gkamp, amixR * gkamp
gaSigL		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
gaSigR		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES	
		endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























