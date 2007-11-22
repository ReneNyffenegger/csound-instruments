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

;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"phaser2",     500,    300,    0,  0
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,  -1,     2,     200,     30,    0,  0,    0,      1,      0,       -1

;VALUE_DISPLAY_BOXES		WIDTH | HEIGHT | X | Y
idfreq		FLvalue	" ",      50,     20,    0,  80
idq		FLvalue	" ",      50,     20,    0, 130
idsep		FLvalue	" ",      50,     20,    0, 180
idfeedback	FLvalue	" ",      50,     20,    0, 230
idampscale	FLvalue	" ",      50,     20,    0, 280

;SLIDERS							MIN  |   MAX   | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X |  Y
gkfreq, ihfreq		FLslider	"Frequency",  		20,    20000,    -1,    5,    idfreq,       500,     30,    0,   50
gkq, ihq		FLslider	"Q",           		.0001,     4,     0,    5,    idq,          500,     30,    0,  100
gksep, ihsep		FLslider 	"Separation",         	0,         2,     0,    5,    idsep,        500,     30,    0,  150
gkfeedback, ihfeedback	FLslider	"Feedback",   		-.99,    .99,     0,    5,    idfeedback,   500,     30,    0,  200
gkampscale, ihampscale	FLslider	"Amplitude",  		0,         1,     0,    5,    idampscale,   500,     30,    0,  250

;COUNTERS					MIN |  MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkord, ihord	FLcount  "No. of Ordinates",	1,    2499,    1,     10,     1,     150,    30,    200, 0,   -1
gkmode, ihmode	FLcount  "Mode",		1,       2,    1,     10,     2,     150,    30,    350, 0,   -1

		FLsetVal_i	1174, ihfreq
		FLsetVal_i	   3, ihq
		FLsetVal_i	   8, ihord
		FLsetVal_i	   2, ihmode
		FLsetVal_i	 .75, ihsep
		FLsetVal_i	 .87, ihfeedback
		FLsetVal_i	   1, ihampscale

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 600, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          phaser2                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The phaser2 opcode is an implementation of an algorithm      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"consisting of a user definable number of second order allpass", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"filters arranged in series.                                  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"'Frequency' (kfreq) (in Hz) controls the centre frequency of ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the first filter in the series. Frequencies of subsequent    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"filters in the series are derived from this base frequency   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"using the setting given by Separation (ksep).                ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"'Q' (kq) controls the amount of Q. Higher values result in   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"narrower filter notches.                                     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"'No. of Ordinates' (kord) allows the user to define the      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"number of allpass filter stages present in the algorithm     ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"(range: 1 -2499).                                            ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"'Mode' (kmode) selects between 2 methods of spacing the      ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"frequencies of filters. When Mode is given a value of 1 the  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"frequencies are spaced at equal intervals in Hz. When Mode is", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"given a value of 2 each frequency is a power of 'Separation' ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"(ksep) multiplied to the previous frequency value.           ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"Separation (ksep) controls the frequency separation between  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"subsequent filters in the series. Its precise functioning is ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"also dependent upon the setting given to 'Mode'. Refer to the", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"Csound manual for further information regarding this         ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"parameter.                                                   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"Feedback (kfeedback) controls the amount of the signal which ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"is fed back from the output back into the input of the chain ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"of filters. This value should be less than 1 and more than   ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"-1.                                                          ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"I have included an attenuating amplitude control as this     ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"opcode can produce increases in amplitude.                   ", 	1,      5,     14,    490,    15,     5, 580

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:	
kSwitch		changed		gkord, gkmode	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
;OUTPUTS	OPCODE	FILE            | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gaSigL, gaSigR	diskin	"Seashore.wav",     1,       0,        1
		endin

		instr	2
aphaserl	phaser2		gaSigL, gkfreq, gkq, gkord, gkmode, gksep, gkfeedback	; PHASER2 IS APPLIED TO THE LEFT CHANNEL
aphaserr	phaser2		gaSigR, gkfreq, gkq, gkord, gkmode, gksep, gkfeedback	; PHASER1 IS APPLIED TO THE RIGHT CHANNEL
		outs	aphaserl * gkampscale, aphaserr * gkampscale
gaSigL		=	0	;CLEAR GLOBAL AUDIO SEND VARIABLES
gaSigR		=	0	;CLEAR GLOBAL AUDIO SEND VARIABLES
		endin
		
</CsInstruments>

<CsScore>
i 2 0 -1	;INSTRUMENT 2 (PHASER INSTRUMENT) PLAYS A HELD NOTE
f 0 3600	;'DUMMY' SCORE EVENT: KEEP THE PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























