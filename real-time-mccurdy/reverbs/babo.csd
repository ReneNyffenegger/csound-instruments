;Written by Iain McCurdy, 2006

;THE BABO OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
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
;				LABEL    | WIDTH | HEIGHT | X | Y
			FLpanel	"Babo",      500,   450,    0,  0

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1

;VALUE_DISPLAY_BOXES							WIDTH | HEIGHT | X | Y
idmix				FLvalue	" ",     			100,      20,    0,  80
idrx				FLvalue	" ",     			100,      20,    0, 130
idry				FLvalue	" ",     			100,      20,    0, 180
idrz				FLvalue	" ",     			100,      20,    0, 230
idsrcx				FLvalue	" ",     			100,      20,    0, 280
idsrcy				FLvalue	" ",     			100,      20,    0, 330
idsrcz				FLvalue	" ",     			100,      20,    0, 380
iddiff				FLvalue	" ",     			100,      20,    0, 430

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X | Y
gkmix,ihmix		FLslider 	"Dry/Wet Mix",		 		0,       1,    0,    5,  idmix,   500,    30,     0,  50
gkrx,ihrx		FLslider 	"Room Size X",		 		.1,     20,    0,    5,  idrx,    500,    30,     0, 100
gkry,ihry		FLslider 	"Room Size Y",		 		.1,     20,    0,    5,  idry,    500,    30,     0, 150
gkrz,ihrz		FLslider 	"Room Size Z",		 		.1,     20,    0,    5,  idrz,    500,    30,     0, 200
gksrcx,ihsrcx		FLslider 	"Source Location X",		 	0,       1,    0,    5,  idsrcx,  500,    30,     0, 250
gksrcy,ihsrcy		FLslider 	"Source Location Y",		 	0,       1,    0,    5,  idsrcy,  500,    30,     0, 300
gksrcz,ihsrcz		FLslider 	"Source Location Z",		 	0,       1,    0,    5,  idsrcz,  500,    30,     0, 350
gkdiff,ihdiff		FLslider 	"HF Diffusion",		 		0,       1,    0,    5,  iddiff,  500,    30,     0, 400

;SET_INITIAL_VALUES			VALUE | HANDLE
			FLsetVal_i	.5, 	ihmix
			FLsetVal_i	5, 	ihrx
			FLsetVal_i	6, 	ihry
			FLsetVal_i	4, 	ihrz
			FLsetVal_i	.5, 	ihsrcx
			FLsetVal_i	.5, 	ihsrcy
			FLsetVal_i	.5, 	ihsrcz
			FLsetVal_i	1, 	ihdiff
			FLsetVal_i	-1, 	ihOnOff

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 300, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               babo - 'Ball within the Box'                  ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"babo is a physically modelled reverberator (babo is short for", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"'ball within the box') It works quite differently from       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Csound's traditional reverberators in that instead of        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"defining the duration of the reverb effect the user defines  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the dimensions of the resonating space and the location of   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"the sound source. The acoustic reflectiveness of the         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"room boundaries is controlled by a parameter for high        ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"frequency diffusion.                                         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The room size parameters are in metres. The source location  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"parameters are also in metres but in this example they are   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"given as ratios (0 to 1) of the room's X, Y and Z dimensions.", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"The opcode also offers a variety of optional 'expert' but    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"only acessible through input from a function table of stored ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"values.                                                      ", 	1,      5,     14,    490,    15,     5, 280

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:	
kSwitch		changed		gkrx, gkry, gkrz, gksrcx, gksrcy, gksrcz, gkdiff	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,      0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gaSigL, gaSigR	diskin	"808loop.wav",     1,       0,        1
		endin

		instr	2
irx		=	i(gkrx)
iry		=	i(gkry)
irz		=	i(gkrz)
ksrcx		=	i(gksrcx) * irx	;THE ACTUAL LOCATION OF THE SOURCE SOUND IS DEFINED RELATIVE TO THE SIZE OF THE ROOM
ksrcy		=	i(gksrcy) * iry	;THE ACTUAL LOCATION OF THE SOURCE SOUND IS DEFINED RELATIVE TO THE SIZE OF THE ROOM
ksrcz		=	i(gksrcz) * irz	;THE ACTUAL LOCATION OF THE SOURCE SOUND IS DEFINED RELATIVE TO THE SIZE OF THE ROOM
idiff		=	i(gkdiff)
aRvbL, aRvbR	babo	(gaSigL + gaSigR) * .3, ksrcx, ksrcy, ksrcz, irx, iry, irz, idiff
		outs	(aRvbL * gkmix) + (gaSigL * (1 - gkmix)), (aRvbR * gkmix) + (gaSigR * (1 - gkmix))	;CREATE THE WET DRY MIX AT THE OUTPUTS
gaSigL		=	0
gaSigR		=	0	
		endin
	
</CsInstruments>

<CsScore>
i 2 0 -1
f 0 3600
</CsScore>

</CsoundSynthesizer>