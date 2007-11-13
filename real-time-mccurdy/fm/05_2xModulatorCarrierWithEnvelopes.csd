;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
;YOU MAY NEED TO CHANGE THE DEVICE NUMBER AFTER THE MIDI INPUT FLAG (-M)
-+rtaudio=PortAudio --midi-device=0 -b4096
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL                        | WIDTH | HEIGHT | X | Y
	FLpanel	"Carrier -> Modulator, with envelopes", 500,     700,   0,  0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    300,    70,   100, 160	;RATIOS
ih		 	FLbox  	" ", 	6,        9,    15,    490,    85,     5, 550	;PRESETS

;PRESETS
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkGet,   ihGet		FLbutBank	12,     6,     1,     300,     40,   190,575,    0,     503,  0,   0

;                                                	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y  | OPCODE | INS | STARTTIM | IDUR
gkloadbank,ihloadbank	FLbutton	"Load Bank", 	1,    0,    11,    80,     20,    10, 575,    0,     501,     0,        0
gksavebank,ihsavebank	FLbutton	"Save Bank", 	1,    0,    11,    80,     20,    10, 595,    0,     502,     0,        0
gksavesnap,ihsavesnap	FLbutton	"Save Snapshot",3,    0,    11,    100,    20,    90, 575,    0,     500,     0,        0

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE
gkstore,ihstore 	FLcount		"Index",	0,     5,    1,      5,     21,    100,     20,      90,    595,      -1

;BUTTONS							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR  | p4(CarRatio) | p5(ModRatio) | p6(BasFrq) | p7(index) | p8(NdxAtt) | p9(NdxDec) | p10(NdxSlev) | p11(NdxRel) | p12(NdxDel | p13(AmpAtt) | p14(AmpDec) | p15(AmpSlev) | p16(AmpRel) | p17(AmpDel)
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,  -1,     2,     150,     28,    0,  0,    0,      1,      0,      3600
gkMIDI,ihMIDI			FLbutton	"MIDI",		1,  -1,     2,     100,     28,  400,  0,   -1

;GENERAL_TEXT_SETTINGS		SIZE | FONT | ALIGN | RED | GREEN | BLUE
		FLlabel		13,     1,      3,     0,     0,      0

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       18,    0,   80
idindex				FLvalue	" ",     	60,       18,    0,  130
idindex2			FLvalue	" ",     	60,       18,  252,  130
idCarAmp			FLvalue	" ",     	60,       18,    0,  280
idndxatt			FLvalue	" ",     	50,       18,    0,  360
idndxdec			FLvalue	" ",     	50,       18,   50,  360
idndxslev			FLvalue	" ",     	50,       18,  100,  360
idndxrel			FLvalue	" ",     	50,       18,  150,  360
idndxdel			FLvalue	" ",     	50,       18,  200,  360
idndxatt2			FLvalue	" ",     	50,       18,    0,  440
idndxdec2			FLvalue	" ",     	50,       18,   50,  440
idndxslev2			FLvalue	" ",     	50,       18,  100,  440
idndxrel2			FLvalue	" ",     	50,       18,  150,  440
idndxdel2			FLvalue	" ",     	50,       18,  200,  440
idampatt			FLvalue	" ",     	50,       18,    0,  520
idampdec			FLvalue	" ",     	50,       18,   50,  520
idampslev			FLvalue	" ",     	50,       18,  100,  520
idamprel			FLvalue	" ",     	50,       18,  150,  520
idampdel			FLvalue	" ",     	50,       18,  200,  520

;SLIDERS				            				MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq,gihbasefreq		FLslider 	"Base Frequency",		20,    20000,  -1,    5,   idbasefreq,    500,    30,     0,  50
gkindex,gihindex		FLslider 	"Modulation Index 1",		0,        20,   0,    5,   idindex,       248,    30,     0, 100
gkindex2,gihindex2		FLslider 	"Modulation Index 2",		0,        20,   0,    5,   idindex2,      248,    30,   252, 100
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",		0,     30000,   0,    5,   idCarAmp,      500,    30,     0, 250

;KNOBS								MIN  | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkndxatt, gihndxatt		FLknob 		"Attack",	.001,   8,    0,    1,  idndxatt,  40,   5, 302
gkndxdec, gihndxdec		FLknob 		"Decay",	0,     15,    0,    1,  idndxdec,  40,  55, 302
gkndxslev,gihndxslev		FLknob 		"Sustain",	0,      1,    0,    1,  idndxslev, 40, 105, 302
gkndxrel, gihndxrel		FLknob 		"Release",	0,     15,    0,    1,  idndxrel,  40, 155, 302
gkndxdel, gihndxdel		FLknob 		"Delay",	0,      8,    0,    1,  idndxdel,  40, 205, 302
gkndxatt2, gihndxatt2		FLknob 		"Attack",	.001,   8,    0,    1,  idndxatt2,  40,   5, 382
gkndxdec2, gihndxdec2		FLknob 		"Decay",	0,     15,    0,    1,  idndxdec2,  40,  55, 382
gkndxslev2,gihndxslev2		FLknob 		"Sustain",	0,      1,    0,    1,  idndxslev2, 40, 105, 382
gkndxrel2, gihndxrel2		FLknob 		"Release",	0,     15,    0,    1,  idndxrel2,  40, 155, 382
gkndxdel2, gihndxdel2		FLknob 		"Delay",	0,      8,    0,    1,  idndxdel2,  40, 205, 382
gkampatt, gihampatt		FLknob 		"Attack",	.001,   8,    0,    1,  idampatt,  40,   5, 462
gkampdec, gihampdec		FLknob 		"Decay",	0,     15,    0,    1,  idampdec,  40,  55, 462
gkampslev,gihampslev		FLknob 		"Sustain",	0,      1,    0,    1,  idampslev, 40, 105, 462
gkamprel, gihamprel		FLknob 		"Release",	0,     15,    0,    1,  idamprel,  40, 155, 462
gkampdel, gihampdel		FLknob 		"Delay",	0,      8,    0,    1,  idampdel,  40, 205, 462

;VALUE BOXES					 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, gihCarRatio		FLtext		" ", 			.125,   8,  .0001,  1,     50,     20,   130, 170
gkModRatio, gihModRatio		FLtext		" ", 			.125,   8,  .0001,  1,     50,     20,   225, 170
gkModRatio2, gihModRatio2	FLtext		" ", 			.125,   8,  .0001,  1,     50,     20,   320, 170

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    200,  172
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    295,  172
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    80,    15,    115,  200
ih		 	FLbox  	"Modulator 1 Frequency", 				1,      5,     12,    80,    15,    210,  200
ih		 	FLbox  	"Modulator 2 Frequency", 				1,      5,     12,    80,    15,    305,  200
ih		 	FLbox  	"INDEX 1 ENVELOPE  ", 					1,       1,    14,    170,    30,   250, 310
ih		 	FLbox  	"INDEX 2 ENVELOPE  ", 					1,       1,    14,    170,    30,   250, 390
ih		 	FLbox  	"AMPLITUDE ENVELOPE", 					1,       1,    14,    170,    30,   250, 470
ih		 	FLbox  	"P r e s e t s :", 					1,       3,    12,    100,    15,   200, 555

;SET INITIAL VALUES			VALUE | HANDLE
			FLsetVal_i	325,	gihbasefreq
			FLsetVal_i	5,	gihindex
			FLsetVal_i	.702,	gihindex2
			FLsetVal_i	1, 	gihCarRatio
			FLsetVal_i	1.377, 	gihModRatio
			FLsetVal_i	1.3853,	gihModRatio2
			FLsetVal_i	20000, 	ihCarAmp
			FLsetVal_i	.002, 	gihndxatt
			FLsetVal_i	3, 	gihndxdec
			FLsetVal_i	0, 	gihndxslev
			FLsetVal_i	.5, 	gihndxrel
			FLsetVal_i	0, 	gihndxdel
			FLsetVal_i	.002, 	gihndxatt2
			FLsetVal_i	3, 	gihndxdec2
			FLsetVal_i	0, 	gihndxslev2
			FLsetVal_i	.5, 	gihndxrel2
			FLsetVal_i	0, 	gihndxdel2
			FLsetVal_i	.002, 	gihampatt
			FLsetVal_i	7, 	gihampdec
			FLsetVal_i	0, 	gihampslev
			FLsetVal_i	.5, 	gihamprel
			FLsetVal_i	0, 	gihampdel

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"     FM Synthesis: 2 Modulators->Carrier with envelopes      ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"As we introduce more oscillators into the FM algorithm       ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"(either as modulators or carriers) more complex modulations  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"are possible. Spectral possibilties also increase although   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"control of discord in the timbre becomes more of an issue.   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"A simple algorithm using three oscillators is that of a      ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"carrier's frequency being modulated by the audio output of   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"two modulators simulataneously. (See diagram below.)         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"If the ratios of the two modulators are offset slightly a    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"dramatic spectral modulation is heard simular to the effect  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of lowpass filter with its cutoff modulated by an LFO.       ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"Another approach is to give the envelope of one of modulators", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"a very short percussive nature in order that it reflects     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the immediate attack of a sound such as the sound of a mallet", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"striking a resonating object the 2nd modulator can be used to", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"create the spectrum of the sustain portion or the main body  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"of the sound.                                                ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Some presets are provided - first click on 'load bank' in    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"order to access them.                                        ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"This example is also playable from a MIDI keyboard if the    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"'MIDI' switch is activated.                                  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"       2 MODULATORS AND A CARRIER FM SYNTHESIS ALGORITHM     ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	" ----------------------------------------------------------  ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"               +-------------+   +-------------+             ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"               |    oscil    |   |    oscil    |             ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"               |(modulator 1)|   |(modulator 2)|             ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"               +-----+-------+   +-----+-------+             ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"                     |                 |                     ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"                     |                 |                     ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"                     +---------+-------+                     ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"                         +-----+-----+                       ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"                         |   oscil   |                       ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"                         | (carrier) |                       ", 	1,      5,     14,    490,    15,     5, 740
ih		 	FLbox  	"                         +-----+-----+                       ", 	1,      5,     14,    490,    15,     5, 760
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    15,     5, 780
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    15,     5, 800
ih		 	FLbox  	"                              OUT                            ", 	1,      5,     14,    490,    15,     5, 820
                                                            
				FLscrollEnd
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
		
kndxenv 	madsr 	i(gkndxatt), i(gkndxdec), i(gkndxslev) + .0000001, i(gkndxrel) , i(gkndxdel)		;LINE SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
kndxenv2 	madsr 	i(gkndxatt2), i(gkndxdec2), i(gkndxslev2) + .0000001, i(gkndxrel2) , i(gkndxdel2)	;LINE SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
kpeakdeviation	=	kbasefreq * gkindex * kndxenv
kpeakdeviation2	=	kbasefreq * gkindex2 * kndxenv2
aModulator	oscili	kpeakdeviation, kbasefreq * gkModRatio,1
aModulator2	oscili	kpeakdeviation2, kbasefreq * gkModRatio2,1
aampenv 	mxadsr 	i(gkampatt), i(gkampdec), i(gkampslev) + .0000001, i(gkamprel) , i(gkampdel)	;EXPONENTIAL SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
aCarrier	oscili	kCarAmp * aampenv, (kbasefreq * gkCarRatio) + aModulator + aModulator2, 1
	outs	aCarrier, aCarrier
	endin

			instr		500
inumsnap	inumval FLsetsnap	i(gkstore)
			endin

			instr		501
			FLloadsnap	"05_2xModulatorCarrierWithEnvelopes.snap"
			endin

			instr		502
			FLsavesnap	"05_2xModulatorCarrierWithEnvelopes.snap"
			endin

			instr		503
inumel			FLgetsnap	i(gkGet)
			endin			

</CsInstruments>


<CsScore>
f 1 0 129 10 1
f 0 3600
</CsScore>


</CsoundSynthesizer>



























