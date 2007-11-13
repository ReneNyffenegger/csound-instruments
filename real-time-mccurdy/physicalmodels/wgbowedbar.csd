;Written by Iain McCurdy, 2006

;BOWED BAR PHYSICAL MODEL - RATHER UNSTABLE

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

		FLcolor		-2	;RANDOMLY COLOURIZE THE INTERFACE
		FLcolor2	-2	;RANDOMLY COLOURIZE THE INTERFACE

;			LABEL |      WIDTH | HEIGHT | X | Y
		FLpanel	"wgbowedbar", 500,    500,    0,  0

;BUTTONS                              		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,   -1,     1,    200,     30,    0,  0,    0,      2,      0,       -1

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      100,     18,    0,   80
idfreq		FLvalue	" ",      100,     18,    0,  130
idpos		FLvalue	" ",      100,     18,    0,  180
idbowpres	FLvalue	" ",      100,     18,    0,  230
idgain		FLvalue	" ",      100,     18,    0,  280
idconst		FLvalue	" ",      100,     18,    0,  330
idbowpos	FLvalue	" ",      100,     18,    0,  430
idlow		FLvalue	" ",      100,     18,    0,  480

;SLIDERS				            						MIN |   MAX  | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",					0,    30000,    0,    5,    idamp,      500,    30,     0,   50
gkfreq, ihfreq			FLslider	"Frequency",					20,   20000,   -1,    5,    idfreq,     500,    30,     0,  100
gkpos, ihpos			FLslider	"Bow Position On Bar",				0,        1,    0,    5,    idpos,      500,    30,     0,  150
gkbowpres, ihbowpres		FLslider	"Bow Pressure",					1,        5,    0,    5,    idbowpres,  500,    30,     0,  200
gkgain,ihgain			FLslider 	"Gain Of Filter",  				.8,       2,    0,    5,    idgain,     500,    30,     0,  250
gkconst,ihconst			FLslider 	"Integration Constant",				-1,       1,    0,    5,    idconst,    500,    30,     0,  300
gkbowpos,ihbowpos		FLslider 	"Bow Position Affecting Velocity Trajectory",	-1,       1,    0,    5,    idbowpos,   500,    30,     0,  400
gklow,ihlow			FLslider 	"Lowest Frequency Required",			0,     2000,    0,    5,    idlow,      500,    30,     0,  450

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gktvel, ihtvel	FLcount  "Bow Velocity: 0=ADSR 1=Exponential",	0,     1,    1,       1,     2,     235,     30,   150,350,   -1


;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	10000, 	ihamp
		FLsetVal_i	170, 	ihfreq
		FLsetVal_i	.5, 	ihpos
		FLsetVal_i	3,	ihbowpres
		FLsetVal_i	.809, 	ihgain
		FLsetVal_i	0, 	ihconst
		FLsetVal_i	0, 	ihtvel
		FLsetVal_i	0, 	ihbowpos
		FLsetVal_i	0, 	ihlow

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       wgbowedbar                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"wgbowedbar is a wave guide physical model of a bowed bar     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"based on work by Perry Cook but re-coded for Csound by John  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"ffitch.                                                      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 480

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr	1	;(ALWAYS ON - SEE SCORE) SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed		gkconst, gktvel, gkbowpos, gklow
if		kSwitch==0	kgoto	CONTINUE
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	1,             0,       0,        2,        0,    -1
CONTINUE:
	endin

		instr	2
abowedbar      	wgbowedbar 	gkamp, gkfreq, gkpos, gkbowpres, gkgain, i(gkconst), i(gktvel), i(gkbowpos), i(gklow)
		outs 		abowedbar, abowedbar

		endin
</CsInstruments>


<CsScore>
i 1 0 3600
</CsScore>
</CsoundSynthesizer>



























