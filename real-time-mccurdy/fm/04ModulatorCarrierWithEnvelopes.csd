;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio --midi-device=0 -b4096
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	44100
ksmps	=	1
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL                        | WIDTH | HEIGHT | X | Y
	FLpanel	"Carrier -> Modulator, with envelopes", 500,     550,   0,  0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    220,    70,   140, 160
ih		 	FLbox  	" ", 	6,        9,    15,    490,    70,     5, 470

;BUTTONS							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR  | p4(CarRatio) | p5(ModRatio) | p6(BasFrq) | p7(index) | p8(NdxAtt) | p9(NdxDec) | p10(NdxSlev) | p11(NdxRel) | p12(NdxDel | p13(AmpAtt) | p14(AmpDec) | p15(AmpSlev) | p16(AmpRel) | p17(AmpDel)
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,  -1,     2,     150,     28,    0,  0,    0,      1,      0,       3600
gkMIDI,ihMIDI			FLbutton	"MIDI",		1,  -1,     2,     100,     28,  400,  0,   -1
gkMetalPlate,ihMetalPlate	FLbutton	"Metal Plate",	1,  -1,     1,     100,     28,   35,500,    0,      2,      0,       .001,      1,             1.377,        325,           5,        .001,           3,          0,               .5,         0,          .001,           7,            0,            .5,           0
gkClarinet,ihClarinet		FLbutton	"Clarinet",	1,  -1,     1,     100,     28,  145,500,    0,      2,      0,       .001,      1,             2.0005,       260,        5.33,        .001,        .715,       .852,             .111,         0,          .087,        .402,         .785,          .102,           0
gkTrumpet,ihTrumpet		FLbutton	"Trumpet",	1,  -1,     1,     100,     28,  255,500,    0,      2,      0,       .001,      1,             1.0003,       410,        8.79,         .001,       .139,       .616,             .111,         0,          .018,        .402,         .785,          .102,           0
gkBassoon,ihBassoon		FLbutton	"Bassoon",	1,  -1,     1,     100,     28,  365,500,    0,      2,      0,       .001,      5,             1,             65,        5.33,        .001,        .715,       .852,             .111,         0,          .087,        .402,         .785,          .102,           0


;GENERAL_TEXT_SETTINGS		SIZE | FONT | ALIGN | RED | GREEN | BLUE
		FLlabel		13,     1,      3,     0,     0,      0

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    0,   80
idindex				FLvalue	" ",     	60,       20,    0,  130
idCarAmp			FLvalue	" ",     	60,       20,    0,  280
idndxatt			FLvalue	" ",     	50,       18,    0,  360
idndxdec			FLvalue	" ",     	50,       18,   50,  360
idndxslev			FLvalue	" ",     	50,       18,  100,  360
idndxrel			FLvalue	" ",     	50,       18,  150,  360
idndxdel			FLvalue	" ",     	50,       18,  200,  360
idampatt			FLvalue	" ",     	50,       18,    0,  440
idampdec			FLvalue	" ",     	50,       18,   50,  440
idampslev			FLvalue	" ",     	50,       18,  100,  440
idamprel			FLvalue	" ",     	50,       18,  150,  440
idampdel			FLvalue	" ",     	50,       18,  200,  440

;SLIDERS				            				MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq,gihbasefreq		FLslider 	"Base Frequency",		20,    20000,  -1,    5,   idbasefreq,    500,    30,     0,  50
gkindex,gihindex		FLslider 	"Modulation Index",		0,        20,   0,    5,   idindex,       500,    30,     0, 100
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",		0,     30000,   0,    5,   idCarAmp,      500,    30,     0, 250

;KNOBS								MIN  | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkndxatt, gihndxatt		FLknob 		"Attack",	.005,   8,    0,    1,  idndxatt,  40,   5, 302
gkndxdec, gihndxdec		FLknob 		"Decay",	0,     15,    0,    1,  idndxdec,  40,  55, 302
gkndxslev,gihndxslev		FLknob 		"Sustain",	0,      1,    0,    1,  idndxslev, 40, 105, 302
gkndxrel, gihndxrel		FLknob 		"Release",	0,     15,    0,    1,  idndxrel,  40, 155, 302
gkndxdel, gihndxdel		FLknob 		"Delay",	0,      8,    0,    1,  idndxdel,  40, 205, 302
gkampatt, gihampatt		FLknob 		"Attack",	.005,   8,    0,    1,  idampatt,  40,   5, 382
gkampdec, gihampdec		FLknob 		"Decay",	0,     15,    0,    1,  idampdec,  40,  55, 382
gkampslev,gihampslev		FLknob 		"Sustain",	0,      1,    0,    1,  idampslev, 40, 105, 382
gkamprel, gihamprel		FLknob 		"Release",	0,     15,    0,    1,  idamprel,  40, 155, 382
gkampdel, gihampdel		FLknob 		"Delay",	0,      8,    0,    1,  idampdel,  40, 205, 382

;VALUE BOXES					 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, gihCarRatio		FLtext		" ", 			.125,   8,  .0001,  1,     50,     20,   190, 170
gkModRatio, gihModRatio		FLtext		" ", 			.125,   8,  .0001,  1,     50,     20,   260, 170

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    248,  172
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    90,    15,    170,  200
ih		 	FLbox  	"Modulator Frequency", 					1,      5,     12,    90,    15,    245,  200
ih		 	FLbox  	"INDEX ENVELOPE    ", 					1,       1,    14,    170,    30,   250, 310
ih		 	FLbox  	"AMPLITUDE ENVELOPE", 					1,       1,    14,    170,    30,   250, 390
ih		 	FLbox  	"P r e s e t s :", 					1,       3,    12,    100,    15,   200, 475

;SET INITIAL VALUES
			FLsetVal_i	325,	gihbasefreq
			FLsetVal_i	5,	gihindex
			FLsetVal_i	1, 	gihCarRatio
			FLsetVal_i	1.377, 	gihModRatio
			FLsetVal_i	20000, 	ihCarAmp
			FLsetVal_i	.005, 	gihndxatt
			FLsetVal_i	3, 	gihndxdec
			FLsetVal_i	0, 	gihndxslev
			FLsetVal_i	.5, 	gihndxrel
			FLsetVal_i	0, 	gihndxdel
			FLsetVal_i	.005, 	gihampatt
			FLsetVal_i	7, 	gihampdec
			FLsetVal_i	0, 	gihampslev
			FLsetVal_i	.5, 	gihamprel
			FLsetVal_i	0, 	gihampdel

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 280, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"        FM Synthesis: Modulator->Carrier with envelopes      ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"To create more interesting timbres and to exploit FM         ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"synthesis's strengths the parameters involved in the         ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"synthesis should be dynamically modulated. In this example an", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"ADSR envelope is used to partly control the index of         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"modulation Therefore varying the spectral intensity of the   ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"timbre as the note progresses. (A second ADSR envelope is    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"used to control the amplitude of the tone.)                  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Some presets are included to give the user some idea of what ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"is possible, but bear in mind that this is still a very      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"simple example.                                              ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"This example is also playable from a MIDI keyboard if the    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'MIDI' switch is activated.                                  ", 	1,      5,     14,    490,    15,     5, 260

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr 1		;FM INSTRUMENT
		if		gkMIDI==1	then	;IF MIDI SWITCH IS ON...
icps		cpsmidi				;READ NOTE INFORMATION FROM LIVE MIDI INPUT (CREATE A VARIABLE 'icps' BASED ON RECEIVED NOTE INFORMATION)
iamp		ampmidi	10000			;READ VELOCITY INFORMATION FROM LIVE MIDI INPUT (CREATE A VARIABLE 'iamp' BASED ON RECEIVED VELOCITY INFORMATION)
kbasefreq	=	icps
kCarAmp		=	iamp
		elseif		gkOnOff==1	then	;IF FLTK ON/OFF SWITCH IS ON...
kbasefreq	=	gkbasefreq
kCarAmp		=	gkCarAmp
		else					;IF FLTK SWITCH AND MIDI ARE BOTH OFF...
turnoff			;TURN INSTRUMENT OFF
		endif

kndxenv 	madsr 	i(gkndxatt), i(gkndxdec), i(gkndxslev) + .0000001, i(gkndxrel) , i(gkndxdel)	;LINE SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
kpeakdeviation	=	kbasefreq * gkindex * kndxenv
aModulator	oscili	kpeakdeviation, kbasefreq * gkModRatio,1
kampenv 	mxadsr 	i(gkampatt), i(gkampdec), i(gkampslev) + .0000001, i(gkamprel) , i(gkampdel)	;EXPONENTIAL ENVELOPE WITH MIDI RELEASE MECHANISM
aCarrier	oscili	kCarAmp * kampenv, (kbasefreq * gkCarRatio) + aModulator, 1
	outs	aCarrier, aCarrier
	endin

	instr	2	;PRESET
;	OPCODE		TRIGGER | VALUE | DESTINATION_HANDLE
	FLsetVal 	1,          p4,    gihCarRatio
	FLsetVal 	1,          p5,    gihModRatio
	FLsetVal 	1,          p6,    gihbasefreq
	FLsetVal 	1,          p7,    gihindex
	FLsetVal 	1,          p8,    gihndxatt
	FLsetVal 	1,          p9,    gihndxdec
	FLsetVal 	1,          p10,    gihndxslev
	FLsetVal 	1,          p11,    gihndxrel
	FLsetVal 	1,          p12,    gihndxdel
	FLsetVal 	1,          p13,    gihampatt
	FLsetVal 	1,          p14,    gihampdec
	FLsetVal 	1,          p15,    gihampslev
	FLsetVal 	1,          p16,    gihamprel
	FLsetVal 	1,          p17,    gihampdel
	endin

</CsInstruments>


<CsScore>
f 1 0 129 10 1
f 0 3600
</CsScore>


</CsoundSynthesizer>



























