;Written by Iain McCurdy, 2006

; DEMONSTRATION OF THE phaser1 OPCODE - NOT TO BE CONFUSED WITH THE phasor OPCODE!

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
;			LABEL      | WIDTH | HEIGHT | X | Y
		FLpanel	"phaser1",    500,    150,    0,  0

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,  -1,     2,     150,     30,    0,  0,    0,      1,      0,       -1

;VALUE_DISPLAY_BOXES			WIDTH | HEIGHT | X | Y
idfreq			FLvalue	" ",      80,     20,    0,  80
idfeedback		FLvalue	" ",      80,     20,    0, 130

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkord, ihord	FLcount  "No. of Ordinates (i-rate)",	1,    4999,   1,     10,     1,     150,    30,    350, 0,   -1

;SLIDERS						MIN  |  MAX  | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
gkfreq, ihfreq		FLslider	"Frequency",  	20,    20000,  -1,    5,    idfreq,      500,     30,    0,  50
gkfeedback, ihfeedback	FLslider	"Feedback",   	-.99,    .99,   0,    5,    idfeedback,  500,     30,    0, 100

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	550, 	ihfreq
		FLsetVal_i	50,   	ihord
		FLsetVal_i	.5,  	ihfeedback

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 320, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          phaser1                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The phaser1 opcode is an implementation of an algorithm      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"consisting of a user definable number of first order allpass ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"filters arranged in series.                                  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Frequency (kfreq) (in Hz) controls the frequency at which    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"each filter shifts the phase of its output by 90 degrees.    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"No. of Ordinates (kord) allows the user to define the number ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"of allpass filter stages present in the algorithm (range: 1 -", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"4999).                                                       ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Feedback (kfeedback) controls the amount of the signal which ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"is fed back from the output back into the input of the chain ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of filters. This value should be less than 1 and more than   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"-1.                                                          ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"To create a 'classic' phaser effect the number of ordinates  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"should be less than about 8 and the frequency should be      ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"modulated by an LFO.                                         ", 	1,      5,     14,    490,    15,     5, 300

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:	
kSwitch		changed		gkord	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
;OUTPUTS	OPCODE	FILE            | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gaSigL, gaSigR	diskin	"Seashore.wav",     1,       0,        1
		endin

		instr	2
iporttime	=	.03				; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
kporttime	linseg	0,(.01),iporttime,(1),iporttime	; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
kfreq		portk		gkfreq, kporttime	; PORTAMENTO IS APPLIED TO 'SMOOTH' SLIDER MOVEMENT

aphaserl	phaser1		gaSigL, kfreq, gkord, gkfeedback	; PHASER1 IS APPLIED TO THE LEFT CHANNEL
aphaserr	phaser1		gaSigR, kfreq, gkord, gkfeedback	; PHASER1 IS APPLIED TO THE RIGHT CHANNEL
		outs	aphaserl, aphaserr	; PHASER OUTPUT ARE SENT TO THE SPEAKERS
gaSigL		=	0	;CLEAR GLOBAL AUDIO SEND VARIABLES
gaSigR		=	0	;CLEAR GLOBAL AUDIO SEND VARIABLES
		endin
		
</CsInstruments>

<CsScore>
i 2 0 -1	;INSTRUMENT 2 (PHASER INSTRUMENT) PLAYS A HELD NOTE
f 0 3600	;'DUMMY' SCORE EVENT: KEEP THE PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























