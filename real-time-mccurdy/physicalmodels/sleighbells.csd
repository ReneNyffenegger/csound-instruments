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
;			LABEL        | WIDTH | HEIGHT | X | Y
		FLpanel	"sleighbells",  500,    450,    0   0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"Jingle!",		1,  -1,     1,    200,     30,   150, 10,    0,     1,      0,      -1

		FLcolor		-2	;RANDOMLY COLOURIZE THE INTERFACE
		FLcolor2	-2	;RANDOMLY COLOURIZE THE INTERFACE

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      100,     18,    0,   80
iddettack	FLvalue	" ",      100,     18,    0,  130
idnum		FLvalue	" ",      100,     18,    0,  180
iddamp		FLvalue	" ",      100,     18,    0,  230
idmaxshake	FLvalue	" ",      100,     18,    0,  280
idfreq		FLvalue	" ",      100,     18,    0,  330
idfreq1		FLvalue	" ",      100,     18,    0,  380
idfreq2		FLvalue	" ",      100,     18,    0,  430

;SLIDERS				            					MIN | MAX   | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",				0,    30000,   0,    5,    idamp,        500,    30,     0,   50
gkdettack, ihdettack		FLslider	"idettack (i-rate)",			.001,     1,  -1,    5,    iddettack,    500,    30,     0,   100
gknum, ihnum			FLslider	"Number of Bells (i-rate)",		.0001,  100,   0,    5,    idnum,        500,    30,     0,   150
gkdamp, ihdamp			FLslider	"Damping (i-rate)",			0,       .3,   0,    5,    iddamp,       500,    30,     0,   200
gkmaxshake,ihmaxshake		FLslider 	"Energy Feedback (i-rate)",		0,        1,   0,    5,    idmaxshake,   500,    30,     0,   250
gkfreq,ihfreq			FLslider 	"Main Resonant Frequency (i-rate)",  	200,   8000,  -1,    5,    idfreq,       500,    30,     0,   300
gkfreq1,ihfreq1			FLslider 	"1st Resonant Frequency (i-rate)",  	200,   8000,  -1,    5,    idfreq1,      500,    30,     0,   350
gkfreq2,ihfreq2			FLslider 	"2nd Resonant Frequency (i-rate)",  	200,   8000,  -1,    5,    idfreq2,      500,    30,     0,   400

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	20000, 	ihamp
		FLsetVal_i	.01, 	ihdettack
		FLsetVal_i	23, 	ihnum
		FLsetVal_i	.17, 	ihdamp
		FLsetVal_i	0, 	ihmaxshake
		FLsetVal_i	2500, 	ihfreq
		FLsetVal_i	5300, 	ihfreq1
		FLsetVal_i	6500, 	ihfreq2

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        sleigbells                           ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"sleigbells is a semi-physical model of sleighbells.          ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"It is one of the PhISEM percussion opcodes. PhISEM           ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"(Physically Informed Stochastic Event Modeling) is an        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"algorithmic approach for simulating collisions of multiple   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"independent sound producing objects.                         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Sustained textures are possible if internal damping is set   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"at maximum (i.e. internal damping is insufficient to         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"eventually stop the movement of the beads).                  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Note that the opcode needs to be 're-shaken' in order to     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"hear the changes made to i-rate controls.                    ", 	1,      5,     14,    490,    15,     5, 220

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr		1
asleighbells	sleighbells	gkamp, i(gkdettack) , i(gknum), i(gkdamp) , i(gkmaxshake), i(gkfreq) , i(gkfreq1), i(gkfreq2)
		outs 		asleighbells, asleighbells
		endin

</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
