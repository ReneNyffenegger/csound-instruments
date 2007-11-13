;Written by Iain McCurdy, 2006

;THE freeverb OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
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
		FLpanel	"freeverb", 500,    200,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idFreq				FLvalue	" ",     100,    20,     0,  80
idHFDamp			FLvalue	" ",     100,    20,     0, 130
idmix				FLvalue	" ",     100,    20,     0, 180

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     30,   350, 0,    -1

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkRoomSize,ihRoomSize		FLslider 	"Room Size",			0,     1,    0,    5,   idFreq,    500,     30,    0,  50
gkHFDamp,ihHFDamp		FLslider 	"High Frequency Damping",	0,     1,    0,    5,   idHFDamp,  500,     30,    0, 100
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,     1,    0,    5,   idmix,     500,     30,    0, 150

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.5, 	ihRoomSize
		FLsetVal_i	.5, 	ihHFDamp
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	-1, 	ihOnOff

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 745, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           freeverb                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"freeverb is a Csound implementation of Jezar's Freeverb      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"reverb plugin effect. This algorithm uses 8 parallel comb    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"filters followed by 4 series allpass filters (as show below).", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The opcode is stereo and this algorithm is applied separately", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"on both channels. The comb and allpass filters on the right  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"channel are detuned with respect to those on the left in     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"order to create a stereo effect. Input arguments include room", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"size and high frequency damping.                             ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Optional arguments are for a value defining the expected     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"sample rate (default=44100) and an optional 2-way switch     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"is provided, if non-zero initialisation will, whenever       ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"possible, be skipped.                                        ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"       +----+                                                ", 	1,      5,     14,    490,    15,     5, 300-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 315-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 330-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    15,     5, 345-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 360-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 375-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 390-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    15,     5, 405-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 420-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 435-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 450-20
ih		 	FLbox  	"     +        +                                              ", 	1,      5,     14,    490,    15,     5, 465-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 480-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 495-20
ih		 	FLbox  	"     | +----+ | +-------+ +-------+ +-------+ +-------+      ", 	1,      5,     14,    490,    15,     5, 510-20
ih		 	FLbox  	"IN-->|        |-|allpass|-|allpass|-|allpass|-|allpass|-->OUT", 	1,      5,     14,    490,    15,     5, 525-20
ih		 	FLbox  	"     | +----+ | +-------+ +-------+ +-------+ +-------+      ", 	1,      5,     14,    490,    15,     5, 540-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 555-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 570-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    15,     5, 585-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 600-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 615-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 630-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    15,     5, 645-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 660-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 675-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 690-20
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    15,     5, 705-20
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 720-20
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 735-20
ih		 	FLbox  	"       +----+                                                ", 	1,      5,     14,    490,    15,     5, 750-20

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
kSwitch		changed		gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1	
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gaSigL, gaSigR	diskin	"808loop.wav",     1,       0,        1
		endin

		instr 		2
		denorm		gaSigL, gaSigR	;DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
arvbL, arvbR 	freeverb 	gaSigL, gaSigR, gkRoomSize, gkHFDamp , sr, i(gkskip)
amixL		ntrpol		gaSigL, arvbL, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
amixR		ntrpol		gaSigR, arvbR, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
		outs		amixL, amixR
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



























