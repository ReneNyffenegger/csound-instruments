;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	4410	;CONTROL RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL     | WIDTH | HEIGHT | X | Y
		FLpanel	"flooper2",  500,    400,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    150,     30,    0,  0,    0,      2,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idloopstart			FLvalue	" ",     100,    20,     0, 130
idloopend			FLvalue	" ",     100,    20,     0, 180
idpitch				FLvalue	" ",     100,    20,     0, 230
idcrossfade			FLvalue	" ",     100,    20,     0, 280
idstart				FLvalue	" ",     100,    20,     0, 330
idamp				FLvalue	" ",     100,    20,     0, 380

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP       | WIDTH | HEIGHT | X | Y
gkloopstart,ihloopstart		FLslider 	"Loop Start",			0,     1,    0,    5,   idloopstart,   500,     30,    0, 100
gkloopend,ihloopend		FLslider 	"Loop End",			0,     1,    0,    5,   idloopend,     500,     30,    0, 150
gkpitch,ihpitch			FLslider 	"Pitch",			.25,   4,   -1,    5,   idpitch,       500,     30,    0, 200
gkcrossfade,ihcrossfade		FLslider 	"Crossfade (seconds)",		0,     1,    0,    5,   idcrossfade,   500,     30,    0, 250
gkstart,ihstart			FLslider 	"Start Position (i-rate)",	0,     1,    0,    5,   idstart,       500,     30,    0, 300
gkamp,ihamp			FLslider 	"Amplitude",			0, 32768,    0,    5,   idamp,         500,     30,    0, 350

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE
gkfn, ihfn 			FLcount  "Soundfile", 		1,     2,     1,      1,      2,    150,     30,   175,   0,   -1
gkmode, ihmode 			FLcount  "Loop Mode (i-rate)", 	0,     2,     1,      1,      2,    150,     30,   350,   0,   -1

;TEXT BOXES              					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "1=808loop.wav 2=AndItsAll.wav", 	1,     9,      12,   150,     30,    175, 50
ih		 FLbox  "0=forward 1=backward 2=back-and-forth",1,     9,      12,   150,     30,    350, 50


;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0, 	ihloopstart
		FLsetVal_i	1, 	ihloopend
		FLsetVal_i	1, 	ihpitch
		FLsetVal_i	.001, 	ihcrossfade
		FLsetVal_i	1, 	ihfn
		FLsetVal_i	0, 	ihstart
		FLsetVal_i	32768, 	ihamp

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 580, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           flooper2                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Flooper2 plays a soundfile with a user definable loop.       ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Loop start and end points can be changed at k-rate (i.e.     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"while the loop is already playing).                          ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Pitch is defined as a ratio of the original pitch of the     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"sample. I.e. a pitch value of 1 plays the soundfile back at  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"its original speed, a pitch value of 2 plays it back at twice", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"its original speed, a pitch value of 0.5 plays it back at    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"half its original speed and so on...                         ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The start time parameter allows the user to specify from     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"where the soundfile will begin playback, i.e. before entering", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"looping.                                                     ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"In the opcode definition loop start and end points and start ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"time are given in seconds. For convenience in this example   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"the relevant sliders define these parameters as fractions of ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"the entire duration of the soundfile. (Subsequent rescaling  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"is done within the instrument code.) This allows the user to ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"swap between soundfiles of differring lengths without the    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"need to re-adjust the FLTK slider ranges.                    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"The source sound for flooper2 should be stored in a GEN01    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"function table.                                              ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"A parameter is provided to define a crossfade time for when  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"the file loops. Note that crossfade times are limited to the ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"current duration of the loop.                                ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"Three looping modes are offered. Details are provided in the ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"interface opposite.                                          ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"This example allows the user to choose between two source    ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"samples.                                                     ", 	1,      5,     14,    490,    15,     5, 560

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr	1	;(ALWAYS ON - SEE SCORE) SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed	gkfn, gkstart, gkmode	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;					ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
			schedkwhen	kSwitch,             0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
	endin

		instr	2	;FLOOPER2 INSTRUMENT
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
ifn		=	i(gkfn)
ifilelength	=	nsamp(ifn)/sr
kloopstart	=	ifilelength*gkloopstart
kloopend	=	ifilelength*gkloopend
asig 		flooper2 gkamp, gkpitch, kloopstart, kloopend, gkcrossfade, ifn, i(gkstart), i(gkmode);, ifenv, iskip
		outs	asig, asig
		endin

</CsInstruments>

<CsScore>
; THE SOUND FILE USED IN THE GRANULATION
; NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH     | IN_SKIP | FORMAT | CHANNEL
f  1        0      524288       1       "808loop.wav"       0         4        1 
f  2        0      524288       1       "AndItsAll.wav"     0         4        1 

;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























