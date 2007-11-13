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

;			LABEL       | WIDTH | HEIGHT | X | Y                                          
		FLpanel	"dripwater",   500,     500,   0   0
                                              
		FLcolor		-2
		FLcolor2	-2

;BUTTONS                       	                              	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM |  DUR
gk1Drip, ih1Drip	FLbutton	"Single Drip",		1,   -1,    1,     200,     30,    20, 10,    0,     2,      0,       -1
gkOnOff, ihOnOff	FLbutton	"Turn the Tap On/Off",	1,   -1,    2,     200,     30,   280, 10,    0,     1,      0,       -1

;VALUE DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp		FLvalue	" ",    100,      18,    0, 80
iddettack	FLvalue	" ",    100,      18,    0, 130
idnum		FLvalue	" ",    100,      18,    0, 180
iddamp		FLvalue	" ",    100,      18,    0, 230
idmaxshake	FLvalue	" ",    100,      18,    0, 280
idfreq		FLvalue	" ",    100,      18,    0, 330
idfreq1		FLvalue	" ",    100,      18,    0, 380
idfreq2		FLvalue	" ",    100,      18,    0, 430
idtimedelta	FLvalue	" ",    100,      18,    0, 480

;SLIDERS				     						MIN  |  MAX  |  EXP | TYPE | DISP       | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider	"Amplitude",				0,    300000,   0,     5,    idamp,        500,    30,     0, 50
gkdettack, ihdettack		FLslider	"idettack (i-rate)",			.001,      1,  -1,     5,    iddettack,    500,    30,     0, 100
gknum, ihnum			FLslider	"Number of Drips (i-rate)",		.0001,   100,   0,     5,    idnum,        500,    30,     0, 150
gkdamp, ihdamp			FLslider	"Damping (i-rate)",			0,         2,   0,     5,    iddamp,       500,    30,     0, 200
gkmaxshake,ihmaxshake		FLslider 	"Energy Feedback (i-rate)",		0,         1,   0,     5,    idmaxshake,   500,    30,     0, 250
gkfreq,ihfreq			FLslider 	"Main Resonant Frequency (i-rate)",  	200,    8000,  -1,     5,    idfreq,       500,    30,     0, 300
gkfreq1,ihfreq1			FLslider 	"1st Resonant Frequency (i-rate)",  	200,    8000,  -1,     5,    idfreq1,      500,    30,     0, 350
gkfreq2,ihfreq2			FLslider 	"2nd Resonant Frequency (i-rate)",  	200,    8000,  -1,     5,    idfreq2,      500,    30,     0, 400
gktimedelta,ihtimedelta		FLslider 	"Drip Speed (i-rate)",  		2,        .1,   0,     5,    idtimedelta,  500,    30,     0, 450

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	20000, 	ihamp
		FLsetVal_i	.01, 	ihdettack
		FLsetVal_i	10, 	ihnum
		FLsetVal_i	0, 	ihdamp
		FLsetVal_i	0, 	ihmaxshake
		FLsetVal_i	450, 	ihfreq
		FLsetVal_i	600, 	ihfreq1
		FLsetVal_i	750, 	ihfreq2
		FLsetVal_i	.5, 	ihtimedelta

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        dripwater                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"dripwater is a semi-physical model of dripping water.        ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"It is one of the PhISEM percussion opcodes. PhISEM           ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"(Physically Informed Stochastic Event Modeling) is an        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"algorithmic approach for simulating collisions of multiple   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"independent sound producing objects.                         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Sustained textures are possible if internal damping is set   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"at maximum (i.e. internal damping is insufficient to         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"eventually stop the movement of the beads).                  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"In this example two methods of triggering the opcode are     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"offered. The first is triggered using the button labelled    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"'single drip' and triggers a single cluster of drips. The    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"second is triggered with the on/off switch labelled 'Turn the", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Tap On/Off' and triggers (through the use of the schedkwhen  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"opcode) a continuous sequence of rhythmically spaced clusters", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"of drips. The time gap between drip clusters is controlled   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"using the 'Drip Speed' slider.                               ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"This opcode produces quite erratic amplitude levels so it is ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"advisable to set the amplitude slider quite low to allow some", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"headroom.                                                    ", 	1,      5,     14,    490,    15,     5, 400

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr		1
; SENSE FLTK ON/OFF SWITCH
if		gkOnOff!=-1	kgoto	CONTINUE
turnoff
CONTINUE:
;	 			ktrigger, kmintim,    kmaxnum, kinsnum, kwhen, kdur
		schedkwhen 	    1,   gktimedelta,    0,       2,      0,    -1
		endin

		instr		2
adripwater 	dripwater 	gkamp, i(gkdettack) , i(gknum), i(gkdamp) , i(gkmaxshake), i(gkfreq) , i(gkfreq1), i(gkfreq2)
		outs 		adripwater, adripwater
		endin

</CsInstruments>

<CsScore>
f 1 0 131072 10 1
f 0 3600	; ALLOWS REALTIME MIDI PLAYING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
