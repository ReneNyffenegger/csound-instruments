;Written by Iain McCurdy, 2006

;INSTR	50	-	SCANS FOR I-RATE CONTROLLER CHANGES
;INSTR	2	-	FOF TONE GENERATOR
;INSTR	3	-	EQ
;INSTR	4	-	DRY OUTPUT
;INSTR	5	-	CHORUS
;INSTR	100	-	REVERB
;INSTR	102	-	DELAY
;INSTR	300	-	RESETS GLOBAL AUDIO VARIABLE (gasend)
;INSTR	500	-	SAVE SNAPSHOT
;INSTR	501	-	LOAD SANPSHOT BANK
;INSTR	502	-	SAVE SNAPSHOT BANK
;INSTR	503	-	RETRIEVE SNAPSHOT

;UNFORTUNATELY 'SNAPSHOTS' DON'T SAVE THE STATUS OF BUTTON BANKS - PERHAPS THIS WILL BE FIXED IN FUTURE VERSIONS OF CSOUND

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -M0 -b4096
</CsOptions>

<CsInstruments>
sr 			= 		44100
kr 			= 		4410
ksmps 			= 		10
nchnls 			= 		2


			FLpanel	"fof X 6", 1010, 680, 0, 0

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,      4,     0,     0,      0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    380,    60,   500, 335	;EQ
ih		 	FLbox  	" ", 	6,        9,    15,    125,    60,   885, 335	;CHORUS
ih		 	FLbox  	" ", 	6,        9,    15,    490,   180,     0, 200	;FUNDEMENTAL AND AMPLITUDE MODULATION
ih		 	FLbox  	" ", 	6,        9,    15,    160,   180,   333, 200	;LFO VARIABILITY
ih		 	FLbox  	" ", 	6,        9,    15,    335,    80,     0, 300	;AMPLITUDE RANDOMIZATION
ih		 	FLbox  	" ", 	6,        9,    15,    215,    60,   500, 396	;REVERB
ih		 	FLbox  	" ", 	6,        9,    15,    295,    60,   715, 396	;DELAY
ih		 	FLbox  	" ", 	6,        9,    15,    340,   140,   500, 460	;INPUT MODE
ih		 	FLbox  	" ", 	6,        9,    15,    150,   170,   850, 460	;VOICE TYPE SELECT
ih		 	FLbox  	" ", 	6,        9,    15,    250,    60,   500, 150	;GRAIN ENVELOPE
ih		 	FLbox  	" ", 	6,        9,    15,    260,   120,   500, 215	;VOWEL LFO
ih		 	FLbox  	" ", 	6,        9,    15,    245,   120,   765, 215	;VOWEL RANDOMIZATION

;TEXT BOXES											ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"Octave", 							1,        9,    12,    100,    30,   610, 565
ih		 	FLbox  	"Semitones", 							1,        9,    12,    100,    30,   690, 565
ih		 	FLbox  	"Fundemental and Amplitude LFO",				1,        2,    12,    190,    10,   5,   206
ih		 	FLbox  	"LFO Variability",						1,        2,    12,    105,    10,   355, 206
ih		 	FLbox  	"Fundemental Randomization",					1,        2,    12,    165,    10,   5,   306
ih		 	FLbox  	"Grain Envelope",						1,        2,    11,     85,    10,   505, 155
ih		 	FLbox  	"Vowel LFO",							1,        2,    12,     70,    10,   505, 222
ih		 	FLbox  	"Vowel Randomization",						1,        2,    12,    130,    10,   770, 222

;COUNTERS					IMIN | IMAX | ISTEP1 | ISTEP2 | ITYPE | IWIDTH | IHEIGHT | IX | IY | IOPCODE
gkOctave,   ihOctave 	FLcount  " ", 		4,      12,     1,        1,      2,      80,      20,    620,545,     -1
gkSemiStep, ihSemiStep 	FLcount  " ", 		0,      12,     1,        1,      2,      80,      20,    700,545,     -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   190,  190,   190		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkIPmode,   ihIPmode	FLbutBank	12,     1,     3,     30,    75,    510, 495,    -1
gkvoice, gihvoice	FLbutBank	12,     1,     5,     30,    125,   860, 495,    -1
gkLFOmode, ihLFOmode	FLbutBank	12,     1,     6,     30,    90,    510, 240,    -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES									ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"Fundemental and Vowel Input Mode", 		1,       2,    12,    220,    30,   505, 465
ih		 	FLbox  	"Sliders or MIDI", 				1,       5,    12,    120,    25,   540, 495
ih		 	FLbox  	"XY Panel", 					1,       5,    12,    70,     25,   540, 520
ih		 	FLbox  	"Counters", 					1,       5,    12,    70,     25,   540, 545
ih		 	FLbox  	"Voice", 					1,       2,    12,    50,     30,   860, 465
ih		 	FLbox  	"Bass         ", 				1,       5,    12,    70,     25,   905, 495
ih		 	FLbox  	"Tenor        ", 				1,       5,    12,    70,     25,   905, 520
ih		 	FLbox  	"Counter-Tenor", 				1,       5,    12,    70,     25,   905, 545
ih		 	FLbox  	"Alto         ", 				1,       5,    12,    70,     25,   905, 570
ih		 	FLbox  	"Soprano      ", 				1,       5,    12,    70,     25,   905, 595
ih		 	FLbox  	"Sine           ", 				1,       5,    11,   120,     15,   540, 240
ih		 	FLbox  	"Triangle       ", 				1,       5,    11,   120,     15,   540, 255
ih		 	FLbox  	"Bipolar Square ", 				1,       5,    11,   120,     15,   540, 270
ih		 	FLbox  	"Unipolar Square", 				1,       5,    11,   120,     15,   540, 285
ih		 	FLbox  	"Sawtooth Up    ", 				1,       5,    11,   120,     15,   540, 300
ih		 	FLbox  	"Sawtooth Down  ", 				1,       5,    11,   120,     15,   540, 315


;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,      1,     0,     0,      0

; SWITCHES
;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,  -1,     2,    150,     40,    0,   0,    0,     2,     0,        -1
gkRvbOnOff,ihRvbOnOff	FLbutton	"Reverb",		1,  -1,     2,    65,      20,   510, 405,   0,     100,    0,      3600
gkDlyOnOff,ih		FLbutton	"Delay",		1,  -1,     2,    60,      20,   720, 405,   0,     102,    0,      3600
gkEQOnOff,ih		FLbutton	"EQ",			1,  -1,     2,    65,      20,   510, 345,   0,       3,    0,      3600
gkChoOnOff,ih		FLbutton	"Chorus",		1,  -1,     2,    65,      20,   890, 345,   0,       5,    0,      3600
;;;;WORK_IN_PROGRESS;;;gkPoly,ih		FLbutton	"Polyphonic (MIDI)",	1,  -1,     2,    140,     25,   660, 485,   -1

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkGet,   ihGet		FLbutBank	12,     16,    2,    680,     40,    330, 0,    0,     503,  0,   0

;                                                	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y  | OPCODE | INS | STARTTIM | IDUR
gkloadbank,ihloadbank	FLbutton	"Load Bank", 	1,    0,    11,    80,     20,   150,  0,    0,     501,     0,        0
gksavebank,ihsavebank	FLbutton	"Save Bank", 	1,    0,    11,    80,     20,   150, 20,    0,     502,     0,        0
gksavesnap,ihsavesnap	FLbutton	"Save Snapshot",3,    0,    11,    100,    20,   230,  0,    0,     500,     0,        0

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE
gkstore,ihstore 	FLcount		"Index",	0,     31,    1,      5,     21,    100,     20,     230,    20,      -1


;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,      3,     0,     0,      0

;VALUE_DISPLAY_BOXES				WIDTH | HEIGHT | X | Y
idfund			FLvalue	" ",	 	70,      18,     0, 125
idoct			FLvalue	" ",	 	70,      18,     0, 175
idoutamp		FLvalue	" ",	 	70,      18,   500,  75
idporttime		FLvalue	" ",	 	70,      18,   500, 125
idenv			FLvalue	" ",		65,      18,   510, 180
idEQ			FLvalue	" ",		65,      18,   510, 365
idVlLFOamp		FLvalue	" ",		50,      18,   655, 300
idVlLFOfrq		FLvalue	"Hz.",		50,      18,   705, 300
idVlRndamp		FLvalue	" ",		50,      18,   775, 245
idVlRndfrq		FLvalue	" ",		50,      18,   875, 245
idRvb			FLvalue	" ",		65,      18,   510, 425
idfund2			FLvalue	"Fundemental",	65,      18,     5, 385
idndx2			FLvalue	"Vowel",	65,      18,     5, 435
iddly			FLvalue	" ",		60,      18,   720, 425
idmoddep		FLvalue	" ",		50,      18,   10,  280
idmodfrq		FLvalue	" ",		50,      18,   60,  280
idvibdep		FLvalue	" ",		50,      18,  110,  280
idtrmdep		FLvalue	" ",		50,      18,  160,  280
idmoddly		FLvalue	" ",		50,      18,  210,  280
idmodris		FLvalue	" ",		50,      18,  260,  280
idamprand		FLvalue	" ",		50,      18,  360,  280
idamprandF		FLvalue	" ",		50,      18,  410,  280
idfrqrand		FLvalue	" ",		50,      18,  360,  355
idfrqrandF		FLvalue	" ",		50,      18,  410,  355

idFundRnd		FLvalue	" ",		65,      18,   10,  340

;SLIDERS					     							MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkndx, gihndx			FLslider	"A                           E                           I                           O                           U",            		0,   32768,  0,    3,   -1,   490,     25,    0, 50
gkfund, gihfund			FLslider	"Fundemental (Hz)",					1,   3000,  -1,    3,   idfund,    490,     25,    0, 100
gkoct, ihoct			FLslider	"Octaviation Factor",					0,      8,   0,    3,   idoct,     490,     25,    0, 150
gkoutamp, ihoutamp		FLslider	"Amplitude",						0,  32768,   0,    3,   idoutamp,  490,     25,  500,  50
gkporttime, ihporttime		FLslider	"Portamento on Fundemental and Formant (seconds)",	0,      1,   0,    3,   idporttime,490,     25,  500, 100
gkChoRate, ihChoRate		FLslider	"Rate",							.001,   2,   0,    3,   -1,         65,     14,   890,367
gkVlRndType,ihVlRndType		FLslider	"Interp<------------------------------------->S&H",     0,      1,   0,    3,   -1,        225,     14,   775,300
gkFundRndType,ihFundRndType	FLslider	"Interp<------->S&H",     				0,      1,   0,    3,   -1,        140,     20,   180,330

;KNOBS								imin, imax, iexp, itype,   idisp,  iwidth, ix, iy [, icursorsize]
gkmoddep, gihmoddep	FLknob 		"ModDep", 		0,    1,      0,    1,    idmoddep,  40,   15,  225; [, icursorsize]
gkmodfrq, ihmodfrq	FLknob 		"ModFrq", 		0,    10,     0,    1,    idmodfrq,  40,   65, 225; [, icursorsize]
gkvibdep, ihvibdep	FLknob 		"VibDep", 		0,     .1,    0,    1,    idvibdep,  40,   115, 225; [, icursorsize]
gktrmdep, ihtrmdep	FLknob 		"TrmDep", 		0,     1,     0,    1,    idtrmdep,  40,   165, 225; [, icursorsize]
gkmoddly, ihmoddly	FLknob 		"ModDly", 		0,     3,     0,    1,    idmoddly,  40,   215, 225; [, icursorsize]
gkmodris, ihmodris	FLknob 		"ModRis", 		0,     3,     0,    1,    idmodris,  40,   265, 225; [, icursorsize]
gkamprand, ihamprand 	FLknob 		"AmpOS",		0,       1,   0,    1,    idamprand, 40,   365, 225; [, icursorsize]
gkamprandF, ihamprandF 	FLknob 		"AmpOSF",		0,       10,  0,    1,    idamprandF,40,   415, 225; [, icursorsize]
gkfrqrand, ihfrqrand 	FLknob 		"FrqOS",		0,       5,   0,    1,    idfrqrand, 40,   365, 300; [, icursorsize]
gkfrqrandF, ihfrqrandF 	FLknob 		"FrqOSF",		0,       10,  0,    1,    idfrqrandF,40,   415, 300; [, icursorsize]

gkFundRndA, ihFundRndA 	FLknob 		"RandAmp",		0,        2,  0,    1,    idFundRnd,40,  80, 320; [, icursorsize]
gkFundRndF, ihFundRndF 	FLknob 		"RandFrq",		.00001,  30,  0,    1,    idFundRnd,40, 130, 320; [, icursorsize]

gkris, ihris 		FLknob 		"Rise",			.001,  .05,   0,    1,    idenv,  40,   595, 155; [, icursorsize]
gkdur, ihdur 		FLknob 		"Dur.", 		.017,    1,   0,    1,    idenv,  40,   645, 155; [, icursorsize]
gkdec, ihdec 		FLknob 		"Dec.", 		.001,  .05,   0,    1,    idenv,  40,   695, 155; [, icursorsize]
gkVlLFOAmp, ihVlLFOAmp 	FLknob 		"Depth",		0,       32768,0,   1,    idVlLFOamp,40,660, 245; [, icursorsize]
gkVlLFOFrq, ihVlLFOFrq 	FLknob 		"Rate",			0,       20,  0,    1,    idVlLFOfrq,40,710, 245; [, icursorsize]
gkVlRndAmp, ihVlRndAmp 	FLknob 		"Rnd.Amt",		0,       32768,0,   1,    idVlRndamp,40,830, 240; [, icursorsize]
gkVlRndFrq, ihVlRndFrq 	FLknob 		"Rnd.Frq",		0,       50,  0,    1,    idVlRndfrq,40,930, 240; [, icursorsize]
gkHPF, ihHPF 		FLknob 		"HPF", 			20,  20000,  -1,    1,    idEQ,   40,   580, 340; [, icursorsize]
gkcf, ihcf 		FLknob 		"Cutoff", 		100,  8000,  -1,    1,    idEQ,   40,   630, 340; [, icursorsize]
gkgain, ihgain 		FLknob 		"Gain", 		0,    15,     0,    1,    idEQ,   40,   680, 340; [, icursorsize]
gkq, ihq 		FLknob 		"Res.", 		.707, 10,     0,    1,    idEQ,   40,   730, 340; [, icursorsize]
gkLPF, ihLPF		FLknob 		"LPF", 			20,   20000, -1,    1,    idEQ,   40,   780, 340; [, icursorsize]
gkEQlev, ihEQlev	FLknob 		"Level", 		0,    3,      0,    1,    idEQ,   40,   830, 340; [, icursorsize]
gkChoDep, ihChoDep	FLknob 		"Depth", 		0,    1,      0,    1,    -1,     40,   960, 340; [, icursorsize]

gkrndfund, ihrndfund	FLknob 		"Random Fundemental", 	0,     .1,    0,    1,    -1,     40,   950, 140; [, icursorsize]
gkrvbmix, ihrvbmix	FLknob 		"Mix", 			0,     1,     0,    1,    idRvb,  40,   580, 400; [, icursorsize]
gkrvbtim, ihrvbtim	FLknob 		"Size", 		0,     1,     0,    1,    idRvb,  40,   625, 400; [, icursorsize]
gkhfdiff, ihhfdiff	FLknob 		"HF.Diff", 		0,     1,     0,    1,    idRvb,  40,   670, 400; [, icursorsize]
gkDlyMix, ihDlyMix	FLknob 		"Mix", 			0,     1,     0,    1,    iddly,  40,   785, 400; [, icursorsize]
gkDlyTim, ihDlyTim	FLknob 		"Time",			.001,  2,     0,    1,    iddly,  40,   830, 400; [, icursorsize]
gkDlyFB,  ihDlyFB	FLknob 		"F.B.",			0,     .95,   0,    1,    iddly,  40,   875, 400; [, icursorsize]
gkDlyModDep,ihDlyModDep	FLknob 		"ModDep",		0,     1,     0,    1,    iddly,  40,   920, 400; [, icursorsize]
gkDlyModFrq,ihDlyModFrq	FLknob 		"ModFrq",		0,     10,    0,    1,    iddly,  40,   965, 400; [, icursorsize]

;XY PANELS								MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkfund2, gkndx2, gihfund2, gihndx2	FLjoy	"X - Freq  Y - Vowel", 	 10,   2000,  0,     32768,  -1,     0,  idfund2, idndx2,  410,    280,    80,385

			FLsetVal_i	100, gihfund2
			FLsetVal_i	1126, gihndx2
			
			FLsetVal_i	0, 	gihndx
			FLsetVal_i	100, 	gihfund
			FLsetVal_i	0, 	ihoct
			FLsetVal_i	0, 	gihvoice
			FLsetVal_i	.22, 	gihmoddep
			FLsetVal_i	5.3, 	ihmodfrq
			FLsetVal_i	.5, 	ihmoddly
			FLsetVal_i	.5, 	ihmodris
			FLsetVal_i	.032, 	ihvibdep
			FLsetVal_i	.15, 	ihtrmdep
			FLsetVal_i	.5, 	ihrvbmix
			FLsetVal_i	.5, 	ihrvbtim
			FLsetVal_i	.1, 	ihhfdiff
			FLsetVal_i	.003, 	ihris
			FLsetVal_i	.02, 	ihdur
			FLsetVal_i	.007, 	ihdec
			FLsetVal_i	10000, 	ihoutamp
			FLsetVal_i	0, 	ihamprand
			FLsetVal_i	1, 	ihamprandF
			FLsetVal_i	.5, 	ihfrqrand
			FLsetVal_i	10, 	ihfrqrandF
			FLsetVal_i	20, 	ihHPF
			FLsetVal_i	300, 	ihcf
			FLsetVal_i	1, 	ihgain
			FLsetVal_i	3, 	ihq
			FLsetVal_i	20000, 	ihLPF
			FLsetVal_i	1, 	ihEQlev
			FLsetVal_i	.5, 	ihChoDep
			FLsetVal_i	.25, 	ihChoRate
			FLsetVal_i	0, 	ihVlLFOAmp
			FLsetVal_i	1, 	ihVlLFOFrq
			FLsetVal_i	0, 	ihVlRndAmp
			FLsetVal_i	1, 	ihVlRndFrq
			FLsetVal_i	0, 	ihIPmode
			FLsetVal_i	.05, 	ihporttime
			FLsetVal_i	0, 	ihrndfund
			FLsetVal_i	.5, 	ihDlyMix	
			FLsetVal_i	.9, 	ihDlyTim	
			FLsetVal_i	.3, 	ihDlyFB	        
			FLsetVal_i	0, 	ihDlyModDep	        
			FLsetVal_i	.3, 	ihDlyModFrq	        
			FLsetVal_i	1.5, 	ihFundRndF 	        
			FLsetVal_i	.002, 	ihFundRndA 	        
			FLsetVal_i	7, 	ihOctave
			FLsetVal_i	0, 	ihSemiStep
			FLsetVal_i	1, 	ihRvbOnOff
			FLsetVal_i	0, 	ihVlRndType

			FLsetTextSize 	10, 	ihHPF
			FLsetTextSize 	10, 	ihcf
			FLsetTextSize 	10, 	ihgain
			FLsetTextSize 	10, 	ihq
			FLsetTextSize 	10, 	ihLPF
			FLsetTextSize 	10, 	ihEQlev
			FLsetTextSize 	10, 	ihChoDep
			FLsetTextSize 	10, 	ihChoRate
			FLsetTextSize 	10, 	ihris
			FLsetTextSize 	10, 	ihdur
			FLsetTextSize 	10, 	ihdec
			FLsetTextSize 	10, 	ihamprand
			FLsetTextSize 	10, 	ihamprandF
			FLsetTextSize 	10, 	ihfrqrand
			FLsetTextSize 	10, 	ihfrqrandF
			FLsetTextSize 	10, 	ihVlLFOAmp
			FLsetTextSize 	10, 	ihVlLFOFrq
			FLsetTextSize 	10, 	ihVlRndAmp
			FLsetTextSize 	10, 	ihVlRndFrq
			FLsetTextSize 	10, 	gihmoddep
			FLsetTextSize 	10, 	ihmodfrq
			FLsetTextSize 	10, 	ihmoddly
			FLsetTextSize 	10, 	ihmodris
			FLsetTextSize 	10, 	ihvibdep
			FLsetTextSize 	10, 	ihtrmdep
			FLsetTextSize 	10, 	ihrvbmix
			FLsetTextSize 	10, 	ihrvbtim
			FLsetTextSize 	10, 	ihhfdiff
			FLsetTextSize 	10, 	ihrndfund
			FLsetTextSize 	10, 	ihDlyMix	
			FLsetTextSize 	10, 	ihDlyTim	
			FLsetTextSize 	10, 	ihDlyFB	        
			FLsetTextSize 	10, 	ihDlyModDep
			FLsetTextSize 	10, 	ihDlyModFrq       
			FLsetTextSize 	10, 	ihFundRndF
			FLsetTextSize 	10, 	ihFundRndA       

			FLpanel_end	;END OF PANEL CONTENTS
			FLrun		;RUN THE WIDGET THREAD!

gasend			init		0
gaDlySend		init		0

;			massign ichnl, insnum[, ireset]
			massign 1,        1;[, ireset]

			instr		1
;READ VALUES FOR FREQUENCY FROM A MIDI KEYBOARD 
icps			cpsmidi
;CREATE A K-RATE GLOBAL VARIABLE FROM MIDI FREQ. VALUES

gkfund			init		icps

#define	NAME		#ndx#
k$NAME			ctrl7		1,2,0,32768
ktrig$NAME		changed		k$NAME
			FLsetVal	ktrig$NAME, k$NAME, gih$NAME

#define	NAME		#moddep#
k$NAME			ctrl7		1,1,0,1
ktrig$NAME		changed		k$NAME
			FLsetVal	ktrig$NAME, k$NAME, gih$NAME

;;;;WORK_IN_PROGRESS;;;if	gkPoly!=-1	kgoto	SKIP1								;MONOPHONIC MODE
;INSTR 2 IS INSTRUCTED TO PLAY A VERY LONG NOTE - ONLY ONE NOTE AT A TIME IS ALLOWED            ;MONOPHONIC MODE
;					KTRIGGER, KMINTIM, KMAXNUM, KINSNUM, KWHEN, KDUR        ;MONOPHONIC MODE
			schedkwhen      1,           0,       1,       2,      0,   3600        ;MONOPHONIC MODE
;;;;WORK_IN_PROGRESS;;;SKIP1:                                                                                          ;MONOPHONIC MODE

;;;;WORK_IN_PROGRESS;;;if	gkPoly!=1	kgoto	SKIP2								;POLYPHONIC MODE
;;;;WORK_IN_PROGRESS;;;;INSTR 2 IS INSTRUCTED TO PLAY A VERY LONG NOTE - ONLY ONE NOTE AT A TIME IS ALLOWED            ;POLYPHONIC MODE
;;;;WORK_IN_PROGRESS;;;;					KTRIGGER, KMINTIM, KMAXNUM, KINSNUM, KWHEN, KDUR        ;POLYPHONIC MODE
;;;;WORK_IN_PROGRESS;;;;                                   "SCORECHAR" | INSNUM | DELAY |  DUR				;POLYPHONIC MODE
;;;;WORK_IN_PROGRESS;;;			event_i 	"i",         2,      0,    3600                         ;POLYPHONIC MODE
;;;;WORK_IN_PROGRESS;;;SKIP2:                                                                                          ;POLYPHONIC MODE
			endin

			instr	50	; SCANS FOR I-RATE CHANGES
kvoice			=		int(gkvoice)
kLFOmode		=		int(gkLFOmode)
;***********TEST FOR VARIABLE CHANGE (REPEAT FOR ALL I-RATE VARIABLES USED)*************************************************
kswitch			changed		kvoice, kLFOmode
if			kswitch=0	kgoto	CONTINUE
if			gkOnOff=-1	kgoto	CONTINUE	
;***************************************************************************************************************************

;***********RESTART INSTRUMENT 2 (WHEN I-RATE VARIABLE CHANGES)*************************************************************
;					ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR
			schedkwhen	1,             0,       0,        2,        0,    -1
;***************************************************************************************************************************
CONTINUE:
			endin
	
			instr 		2
if			gkOnOff=1	kgoto	KEEP_PLAYING
gkNumInstr1 		active 		1
if			gkNumInstr1!=0	kgoto	KEEP_PLAYING
			turnoff
KEEP_PLAYING:

if			gkNumInstr1!=0	kgoto	CONTINUE
; SENSE FLTK ON/OFF SWITCH
if	gkOnOff!=-1	kgoto	CONTINUE
			turnoff
CONTINUE:  

kenv			expsegr		.001, .03, 1.5, .3, 1, .01, .001

kporttime		linseg		0,.001,1,1,1		;PORTAMENTO FUNCTION
kporttime		=		kporttime * gkporttime	;PORTAMENTO FUNCTION

iolaps 			= 		14850	;MAXIMUM NUMBER OF OVERLAPS (OVERESTIMATE)
ifna 			= 		101	;WAVEFORM FOR GRAIN CONTENTS
ifnb 			= 		102	;EXPONENTIAL SHAPE USED FOR GRAIN ENVELOPING
itotdur 		= 		3600	;NOTE WILL LAST FOR 1 HOUR (OVERESTIMATE)

;FUNDEMENTAL/FORMANT INPUT FORMAT
ivoice			table		i(gkvoice), 103
if	gkIPmode!=0	kgoto	SKIP1
kndx			=	gkndx
kfund			=	gkfund
SKIP1:
if	gkIPmode!=1	kgoto	SKIP2
kndx			=		gkndx2
kfund			=		gkfund2
SKIP2:
if	gkIPmode!=2	kgoto	SKIP3
kndx			=	gkndx
kfund			=		cpspch(gkOctave+(gkSemiStep*.01))
SKIP3:

;FUNDEMENTAL_RANDOM_OFFSET
irandfundrange		=		i(gkrndfund)
ifundrand		random		irandfundrange, -irandfundrange
kFundRndi		randomi		gkFundRndA, -gkFundRndA, gkFundRndF
kFundRndh		randomh		gkFundRndA, -gkFundRndA, gkFundRndF
kFundRnd		ntrpol		kFundRndi, kFundRndh, gkFundRndType
kfund			=		kfund*(1+ifundrand)*(1+kFundRnd)

;VOWEL_MODULATION
;kvowelLFO		oscil		gkVlLFOAmp, gkVlLFOFrq, 101
kvowelLFO		lfo		gkVlLFOAmp, gkVlLFOFrq, i(gkLFOmode)
kvowelRndi		randomi		-gkVlRndAmp, gkVlRndAmp, gkVlRndFrq
kvowelRndh		randomh		-gkVlRndAmp, gkVlRndAmp, gkVlRndFrq
kvowelRnd		ntrpol		kvowelRndi, kvowelRndh, gkVlRndType
kndx			=		kndx+kvowelLFO+kvowelRnd
kndx			mirror		kndx, 0, 32768

;FOF_AMPLITUDE_BANDWIDTH_&_FORMANT_DERIVATION
k1form 			table		kndx, 1+ivoice
k1amp 			table 		kndx, 6+ivoice
k1amp			=		ampdb(k1amp)
k1band 			table 		kndx, 11+ivoice

k2form 			table		kndx, 2+ivoice
k2amp 			table 		kndx, 7+ivoice
k2amp			=		ampdb(k2amp)
k2band 			table 		kndx, 12+ivoice

k3form 			table		kndx, 3+ivoice
k3amp 			table 		kndx, 8+ivoice
k3amp			=		ampdb(k3amp)
k3band 			table 		kndx, 13+ivoice

k4form 			table		kndx, 4+ivoice
k4amp 			table 		kndx, 9+ivoice
k4amp			=		ampdb(k4amp)
k4band 			table 		kndx, 14+ivoice

k5form 			table		kndx, 5+ivoice
k5amp 			table 		kndx, 10+ivoice
k5amp			=		ampdb(k5amp)
k5band 			table 		kndx, 15+ivoice

k1form			portk		k1form, kporttime
k2form			portk		k2form, kporttime
k3form			portk		k3form, kporttime
k4form			portk		k4form, kporttime
k5form			portk		k5form, kporttime
k1band			portk		k1band, kporttime
k2band			portk		k2band, kporttime
k3band			portk		k3band, kporttime
k4band			portk		k4band, kporttime
k5band			portk		k5band, kporttime
kfund			portk		kfund,  kporttime

;VIBRATO
kamprnd			randomi		-gkamprand, gkamprand, gkamprandF
kmoddep			=		gkmoddep+kamprnd
kmoddep			limit		kmoddep, 0, 1
kfrqrnd			randomi		-gkfrqrand, gkfrqrand, gkfrqrandF
kmodfrq			=		gkmodfrq+kfrqrnd
kmoddep			limit		kmoddep, 0, 10
kmodenv			linseg		0, i(gkmoddly)+.00001, 0, i(gkmodris), 1, 1, 1
kvib			oscili		gkvibdep*kmodenv*gkmoddep, kmodfrq, 101
kvib			=		kvib+1
kfund			=		kfund*kvib
ktrm			oscil		gktrmdep*.5*kmodenv*kmoddep, gkmodfrq, 101
ktrm			=		ktrm+.5

a1 			fof 		k1amp, kfund, k1form, gkoct, k1band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
a2 			fof 		k2amp, kfund, k2form, gkoct, k2band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
a3 			fof 		k3amp, kfund, k3form, gkoct, k3band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
a4 			fof 		k4amp, kfund, k4form, gkoct, k4band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
a5 			fof 		k5amp, kfund, k5form, gkoct, k5band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
avoice			=		(a1+a2+a3+a4+a5) * ktrm * gkoutamp * kenv
gasend			=		avoice 
			endin

			instr		3	;EQ
aEQ 			pareq 		gasend, gkcf, ampdb(gkgain), gkq
aEQ			buthp		aEQ, gkHPF
aEQ			butlp		aEQ, gkLPF
gasend			=		aEQ*gkEQlev
; SENSE FLTK ON/OFF SWITCH
if			gkEQOnOff!=-1	kgoto	CONTINUE
			turnoff
CONTINUE:   
			endin

			instr		4	;DRY_OUTPUT
			outs		gasend*(1-gkrvbmix), gasend*(1-gkrvbmix)
			endin


			instr		5	;CHORUS
; SENSE FLTK ON/OFF SWITCH
if	gkChoOnOff!=-1	kgoto	CONTINUE
			turnoff
CONTINUE: 
atim1 			jspline 	.005*gkChoDep, 4  *gkChoRate, 4.1*gkChoRate
atim2 			jspline 	.005*gkChoDep, 4.1*gkChoRate, 4.2*gkChoRate
atim3 			jspline 	.005*gkChoDep, 4.2*gkChoRate, 4.3*gkChoRate
aignore			delayr		.01
atap1			deltap3		abs(atim1)+.001
atap2			deltap3		abs(atim2)+.001
atap3			deltap3		abs(atim3)+.001
			delayw		gasend
			outs		atap1+(atap2*.7), atap3+(atap2*.7)
			endin


			instr 		100	;REVERB
			denorm		gasend	;DENORMALIZE AUDIO SIGNAL
arvbL, arvbR 		freeverb 	gasend, gasend, gkrvbtim, gkhfdiff, sr
			outs		arvbL*gkrvbmix, arvbR*gkrvbmix
; SENSE FLTK ON/OFF SWITCH
if	gkRvbOnOff!=-1	kgoto	CONTINUE
			turnoff
CONTINUE: 
			endin

			instr		102	; PING PONG DELAY
; SENSE FLTK ON/OFF SWITCH
if	gkDlyOnOff!=-1	kgoto	CONTINUE
			turnoff
CONTINUE:   

iporttime		init		.2
kporttime		linseg		0,.001,iporttime,1,iporttime

kDlyTim			portk		gkDlyTim, kporttime
kDlyMod			lfo		gkDlyModDep, gkDlyModFrq, 0
kDlyTim			=		kDlyTim+kDlyMod
kDlyTim			limit		kDlyTim, .001, 2
aDlyTim			interp		kDlyTim

imaxdelay		=		2		;MAXIMUM DELAY TIME

;LEFT CHANNEL OFFSETTING DELAY (NO FEEDBACK!)
aBuffer			delayr		imaxdelay*.5
aLeftOffset		deltap3		aDlyTim*.5
			delayw		gasend*gkDlyMix
		
;LEFT CHANNEL DELAY WITH FEEDBACK
aFBsigL			init		0
aBuffer			delayr		imaxdelay
aDlySigL		deltap3		aDlyTim
			delayw		aLeftOffset + aFBsigL
aFBsigL			=		aDlySigL * gkDlyFB

;RIGHT CHANNEL DELAY WITH FEEDBACK
aFBsigR			init		0
aBuffer			delayr		imaxdelay
aDlySigR		deltap3		aDlyTim
			delayw		(gasend*gkDlyMix) + aFBsigR
aFBsigR			=		aDlySigR * gkDlyFB	
			outs		aDlySigL+aLeftOffset, aDlySigR
gasend			=		0	
			endin

			instr		300
gasend			=		0
			endin

			instr		500
inumsnap	inumval FLsetsnap	i(gkstore)
			endin

			instr		501
			FLloadsnap	"FOFx6.snap"
			endin

			instr		502
			FLsavesnap	"FOFx6.snap"
			endin

			instr		503
inumel			FLgetsnap	i(gkGet)
			endin			
</CsInstruments>

<CsScore>
f 101 0 4096 10 1			;SINE WAVE
f 102 0 1024 19 0.5 0.5 270 0.5		;EXPONENTIAL CURVE USED TO DEFINE THE ENVELOPE SHAPE OF FOF PULSES
f 103 0 16 -2 0 15 30 45 60		;INDEXING USED BY VOICE SELECTER BUTTON 

;BASS
f 1  0 32768 -7 600	10922	400	10922	250	10924	350	;FREQ
f 2  0 32768 -7 1040	10922	1620	10922	1750	10924	600	;FREQ
f 3  0 32768 -7	2250	10922	2400	10922	2600	10924	2400	;FREQ
f 4  0 32768 -7	2450	10922	2800	10922	3050	10924	2675	;FREQ
f 5  0 32768 -7	2750	10922	3100	10922	3340	10924	2950	;FREQ
f 6  0 32768 -7	0	10922	0	10922	0	10924	0	;dB
f 7  0 32768 -7	-7	10922	-12	10922	-30	10924	-20	;dB
f 8  0 32768 -7	-9	10922	-9	10922	-16	10924	-32	;dB
f 9  0 32768 -7	-9	10922	-12	10922	-22	10924	-28	;dB
f 10 0 32768 -7	-20	10922	-18	10922	-28	10924	-36	;dB
f 11 0 32768 -7	60	10922	40	10922	60	10924	40	;BAND WIDTH
f 12 0 32768 -7	70	10922	80	10922	90	10924	80	;BAND WIDTH
f 13 0 32768 -7	110	10922	100	10922	100	10924	100	;BAND WIDTH
f 14 0 32768 -7	120	10922	120	10922	120	10924	120	;BAND WIDTH
f 15 0 32768 -7	130	10922	120	10922	120	10924	120	;BAND WIDTH
;TENOR
f 16 0 32768 -7 650 	8192	400 	8192	290	8192	400	8192	350	;FREQ
f 17 0 32768 -7 1080 	8192	1700    8192	1870	8192	800	8192	600	;FREQ
f 18 0 32768 -7	2650	8192	2600    8192	2800	8192	2600	8192	2700	;FREQ
f 19 0 32768 -7	2900	8192	3200    8192	3250	8192	2800	8192	2900	;FREQ
f 20 0 32768 -7	3250	8192	3580    8192	3540	8192	3000	8192	3300	;FREQ
f 21 0 32768 -7	0	8192	0	8192	0	8192	0	8192	0	;dB
f 22 0 32768 -7	-6	8192	-14	8192	-15	8192	-10	8192	-20	;dB
f 23 0 32768 -7	-7	8192	-12	8192	-18	8192	-12	8192	-17	;dB
f 24 0 32768 -7	-8	8192	-14	8192	-20	8192	-12	8192	-14	;dB
f 25 0 32768 -7	-22	8192	-20	8192	-30	8192	-26	8192	-26	;dB
f 26 0 32768 -7	80	8192	70	8192	40	8192	40	8192	40	;BAND WIDTH
f 27 0 32768 -7	90	8192	80	8192	90	8192	80	8192	60	;BAND WIDTH
f 28 0 32768 -7	120	8192	100	8192	100	8192	100	8192	100	;BAND WIDTH
f 29 0 32768 -7	130	8192	120	8192	120	8192	120	8192	120	;BAND WIDTH
f 30 0 32768 -7	140	8192	120	8192	120	8192	120	8192	120	;BAND WIDTH
;COUNTER TENOR
f 31 0 32768 -7 660	8192	440	8192	270	8192	430	8192	370	;FREQ
f 32 0 32768 -7 1120	8192	1800	8192	1850	8192	820	8192	630	;FREQ
f 33 0 32768 -7	2750	8192	2700	8192	2900	8192	2700	8192	2750	;FREQ
f 34 0 32768 -7	3000	8192	3000	8192	3350	8192	3000	8192	3000	;FREQ
f 35 0 32768 -7	3350	8192	3300	8192	3590	8192	3300	8192	3400	;FREQ
f 36 0 32768 -7	0	8192	0	8192	0	8192	0	8192	0	;dB
f 37 0 32768 -7	-6	8192	-14	8192	-24	8192	-10	8192	-20	;dB
f 38 0 32768 -7	-23	8192	-18	8192	-24	8192	-26	8192	-23	;dB
f 39 0 32768 -7	-24	8192	-20	8192	-36	8192	-22	8192	-30	;dB
f 40 0 32768 -7	-38	8192	-20	8192	-36	8192	-34	8192	-30	;dB
f 41 0 32768 -7	80	8192	70	8192	40	8192	40	8192	40	;BAND WIDTH
f 42 0 32768 -7	90	8192	80	8192	90	8192	80	8192	60	;BAND WIDTH
f 43 0 32768 -7	120	8192	100	8192	100	8192	100	8192	100	;BAND WIDTH
f 44 0 32768 -7	130	8192	120	8192	120	8192	120	8192	120	;BAND WIDTH
f 45 0 32768 -7	140	8192	120	8192	120	8192	120	8192	120	;BAND WIDTH
;ALTO
f 46 0 32768 -7	800	8192	400	8192	350	8192	450	8192	325	;FREQ
f 47 0 32768 -7	1150	8192	1600	8192	1700	8192	800	8192	700	;FREQ
f 48 0 32768 -7	2800	8192	2700	8192	2700	8192	2830	8192	2530	;FREQ
f 49 0 32768 -7	3500	8192	3300	8192	3700	8192	3500	8192	2500	;FREQ
f 50 0 32768 -7	4950	8192	4950	8192	4950	8192	4950	8192	4950	;FREQ
f 51 0 32768 -7	0	8192	0	8192	0	8192	0	8192	0	;dB
f 52 0 32768 -7	-4	8192	-24	8192	-20	8192	-9	8192	-12	;dB
f 53 0 32768 -7	-20	8192	-30	8192	-30	8192	-16	8192	-30	;dB
f 54 0 32768 -7	-36	8192	-35	8192	-36	8192	-28	8192	-40	;dB
f 55 0 32768 -7	-60	8192	-60	8192	-60	8192	-55	8192	-64	;dB
f 56 0 32768 -7	50	8192	60	8192	50	8192	70	8192	50	;BAND WIDTH
f 57 0 32768 -7	60	8192	80	8192	100	8192	80	8192	60	;BAND WIDTH
f 58 0 32768 -7	170	8192	120	8192	120	8192	100	8192	170	;BAND WIDTH
f 59 0 32768 -7	180	8192	150	8192	150	8192	130	8192	180	;BAND WIDTH
f 60 0 32768 -7	200	8192	200	8192	200	8192	135	8192	200	;BAND WIDTH
;SOPRANO
f 61 0 32768 -7	800	8192	350	8192	270	8192	450	8192	325	;FREQ
f 62 0 32768 -7	1150	8192	2000	8192	2140	8192	800	8192	700	;FREQ
f 63 0 32768 -7	2900	8192	2800	8192	2950	8192	2830	8192	2700	;FREQ
f 64 0 32768 -7	3900	8192	3600	8192	3900	8192	3800	8192	3800	;FREQ
f 65 0 32768 -7	4950	8192	4950	8192	4950	8192	4950	8192	4950	;FREQ
f 66 0 32768 -7	0	8192	0	8192	0	8192	0	8192	0	;dB
f 67 0 32768 -7	-6	8192	-20	8192	-12	8192	-11	8192	-16	;dB
f 68 0 32768 -7	-32	8192	-15	8192	-26	8192	-22	8192	-35	;dB
f 69 0 32768 -7	-20	8192	-40	8192	-26	8192	-22	8192	-40	;dB
f 70 0 32768 -7	-50	8192	-56	8192	-44	8192	-50	8192	-60	;dB
f 71 0 32768 -7	80	8192	60	8192	60	8192	70	8192	50	;BAND WIDTH
f 72 0 32768 -7	90	8192	90	8192	90	8192	80	8192	60	;BAND WIDTH
f 73 0 32768 -7	120	8192	100	8192	100	8192	100	8192	170	;BAND WIDTH
f 74 0 32768 -7	130	8192	150	8192	120	8192	130	8192	180	;BAND WIDTH
f 75 0 32768 -7	140	8192	200	8192	120	8192	135	8192	200	;BAND WIDTH

;f 201 0 32768 -7 1	16384	0	16384	0	;A
;f 202 0 32768 -7 0	16384	1	16384	0	;A
;f 203 0 32768 -7 0	16384	0	16384	1	;A

i 4   0 3600	;DRY OUTPUT
i 50  0 3600	;SENSING I-RATE CONTROLLER CHANGES
i 300 0 3600	;RESETTING OF GLOBAL AUDIO VARIABLES
</CsScore>

</CsoundSynthesizer>

