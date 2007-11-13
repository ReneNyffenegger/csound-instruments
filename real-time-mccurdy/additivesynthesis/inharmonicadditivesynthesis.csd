;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio --midi-device=0 -b4096
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	4410	;CONTROL RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL                           | WIDTH | HEIGHT | X | Y
		FLpanel	"Inharmonic Additive Synthesis",  500,    600,    0,  0

;SWITCHES                                            		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR	p4	p5	p6	p7	p8	p9	p10	p11	p12	p13	p14	p15	p16	p17	p18	p19	p20	p21	p22	p23	p24	p25	p26	p27	p28	p29	p30	p31	p32	p33
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    150,     30,    0,  0,    0,      1,      0,      3600
gkMIDI,ihMIDI		FLbutton	"MIDI",			1,  -1,     2,     100,     28,  400,  0,   -1

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idfund				FLvalue	" ",     50,     15,     0, 320
idamp				FLvalue	" ",     50,     15,     0, 370

;GENERAL_TEXT_SETTINGS			ISIZE, IFONT, IALIGN, IRED, IGREEN, IBLUE
			FLlabel		10,      1,      3,     0,     0,      0

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X    | Y
gkPartAmp1, ihPartAmp1		FLslider 	"1",			0,     1,    0,     4,    -1,      25,    245,   85,  35
gkPartAmp2, ihPartAmp2		FLslider 	"2",			0,     1,    0,     4,    -1,      25,    245,  110,  35
gkPartAmp3, ihPartAmp3		FLslider 	"3",			0,     1,    0,     4,    -1,      25,    245,  135,  35
gkPartAmp4, ihPartAmp4		FLslider 	"4",			0,     1,    0,     4,    -1,      25,    245,  160,  35
gkPartAmp5, ihPartAmp5		FLslider 	"5",			0,     1,    0,     4,    -1,      25,    245,  185,  35
gkPartAmp6, ihPartAmp6		FLslider 	"6",			0,     1,    0,     4,    -1,      25,    245,  210,  35
gkPartAmp7, ihPartAmp7		FLslider 	"7",			0,     1,    0,     4,    -1,      25,    245,  235,  35
gkPartAmp8, ihPartAmp8		FLslider 	"8",			0,     1,    0,     4,    -1,      25,    245,  260,  35
gkPartAmp9, ihPartAmp9		FLslider 	"9",			0,     1,    0,     4,    -1,      25,    245,  285,  35
gkPartAmp10,ihPartAmp10		FLslider 	"10",			0,     1,    0,     4,    -1,      25,    245,  310,  35

;TEXT BOXES              			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Partial Strength:", 	1,      9,     12,    90,     10,     0, 281

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X    | Y
gkfund, ihfund			FLslider 	"Fundemental (Hertz)",	20,   10000,-1,     3,  idfund,  500,     20,     0, 300
gkamp,  ihamp			FLslider 	"Global Amplitude",	0,    32768, 0,     3,  idamp,   500,     20,     0, 350

;VALUE BOXES					 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkratio1,  ihratio1		FLtext		"Ratio 1", 		.125,   8,  .0001,  1,     50,     20,     0,  400
gkratio2,  ihratio2		FLtext		"Ratio 2", 		.125,   8,  .0001,  1,     50,     20,    50,  400
gkratio3,  ihratio3		FLtext		"Ratio 3", 		.125,   8,  .0001,  1,     50,     20,   100,  400
gkratio4,  ihratio4		FLtext		"Ratio 4", 		.125,   8,  .0001,  1,     50,     20,   150,  400
gkratio5,  ihratio5		FLtext		"Ratio 5", 		.125,   8,  .0001,  1,     50,     20,   200,  400
gkratio6,  ihratio6		FLtext		"Ratio 6", 		.125,   8,  .0001,  1,     50,     20,   250,  400
gkratio7,  ihratio7		FLtext		"Ratio 7", 		.125,   8,  .0001,  1,     50,     20,   300,  400
gkratio8,  ihratio8		FLtext		"Ratio 8", 		.125,   8,  .0001,  1,     50,     20,   350,  400
gkratio9,  ihratio9		FLtext		"Ratio 9", 		.125,   8,  .0001,  1,     50,     20,   400,  400
gkratio10, ihratio10		FLtext		"Ratio 10", 		.125,   8,  .0001,  1,     50,     20,   450,  400

gkampatt1,  ihampatt1		FLtext		"Attack 1", 		.0001,  8,  .0001,  1,     50,     20,     0,  450
gkampatt2,  ihampatt2		FLtext		"Attack 2", 		.0001,  8,  .0001,  1,     50,     20,    50,  450
gkampatt3,  ihampatt3		FLtext		"Attack 3", 		.0001,  8,  .0001,  1,     50,     20,   100,  450
gkampatt4,  ihampatt4		FLtext		"Attack 4", 		.0001,  8,  .0001,  1,     50,     20,   150,  450
gkampatt5,  ihampatt5		FLtext		"Attack 5", 		.0001,  8,  .0001,  1,     50,     20,   200,  450
gkampatt6,  ihampatt6		FLtext		"Attack 6", 		.0001,  8,  .0001,  1,     50,     20,   250,  450
gkampatt7,  ihampatt7		FLtext		"Attack 7", 		.0001,  8,  .0001,  1,     50,     20,   300,  450
gkampatt8,  ihampatt8		FLtext		"Attack 8", 		.0001,  8,  .0001,  1,     50,     20,   350,  450
gkampatt9,  ihampatt9		FLtext		"Attack 9", 		.0001,  8,  .0001,  1,     50,     20,   400,  450
gkampatt10, ihampatt10		FLtext		"Attack 10", 		.0001,  8,  .0001,  1,     50,     20,   450,  450

gkampdec1,  ihampdec1		FLtext		"Decay 1", 		.001,  30,  .0001,  1,     50,     20,     0,  500
gkampdec2,  ihampdec2		FLtext		"Decay 2", 		.001,  30,  .0001,  1,     50,     20,    50,  500
gkampdec3,  ihampdec3		FLtext		"Decay 3", 		.001,  30,  .0001,  1,     50,     20,   100,  500
gkampdec4,  ihampdec4		FLtext		"Decay 4", 		.001,  30,  .0001,  1,     50,     20,   150,  500
gkampdec5,  ihampdec5		FLtext		"Decay 5", 		.001,  30,  .0001,  1,     50,     20,   200,  500
gkampdec6,  ihampdec6		FLtext		"Decay 6", 		.001,  30,  .0001,  1,     50,     20,   250,  500
gkampdec7,  ihampdec7		FLtext		"Decay 7", 		.001,  30,  .0001,  1,     50,     20,   300,  500
gkampdec8,  ihampdec8		FLtext		"Decay 8", 		.001,  30,  .0001,  1,     50,     20,   350,  500
gkampdec9,  ihampdec9		FLtext		"Decay 9", 		.001,  30,  .0001,  1,     50,     20,   400,  500
gkampdec10, ihampdec10		FLtext		"Decay 10", 		.001,  30,  .0001,  1,     50,     20,   450,  500

gkamprel1,  ihamprel1		FLtext		"Release 1", 		.001,   8,  .0001,  1,     50,     20,     0,  550
gkamprel2,  ihamprel2		FLtext		"Release 2", 		.001,   8,  .0001,  1,     50,     20,    50,  550
gkamprel3,  ihamprel3		FLtext		"Release 3", 		.001,   8,  .0001,  1,     50,     20,   100,  550
gkamprel4,  ihamprel4		FLtext		"Release 4", 		.001,   8,  .0001,  1,     50,     20,   150,  550
gkamprel5,  ihamprel5		FLtext		"Release 5", 		.001,   8,  .0001,  1,     50,     20,   200,  550
gkamprel6,  ihamprel6		FLtext		"Release 6", 		.001,   8,  .0001,  1,     50,     20,   250,  550
gkamprel7,  ihamprel7		FLtext		"Release 7", 		.001,   8,  .0001,  1,     50,     20,   300,  550
gkamprel8,  ihamprel8		FLtext		"Release 8", 		.001,   8,  .0001,  1,     50,     20,   350,  550
gkamprel9,  ihamprel9		FLtext		"Release 9", 		.001,   8,  .0001,  1,     50,     20,   400,  550
gkamprel10, ihamprel10		FLtext		"Release 10", 		.001,   8,  .0001,  1,     50,     20,   450,  550

;SET_INITIAL_VALUES		VALUE 	       | HANDLE
		FLsetVal_i	1-.05, 		ihPartAmp1	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.1, 		ihPartAmp2	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.23, 		ihPartAmp3	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-1, 		ihPartAmp4	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.2,		ihPartAmp5	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.18, 		ihPartAmp6	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.1, 		ihPartAmp7	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.067,		ihPartAmp8	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		ihPartAmp9	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.3, 		ihPartAmp10    	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP

		FLsetVal_i	272/437,	ihratio1
		FLsetVal_i	538/437,	ihratio2
		FLsetVal_i	874/437,	ihratio3
		FLsetVal_i	1281/437,	ihratio4
		FLsetVal_i	1755/437,	ihratio5
		FLsetVal_i	2264/437,	ihratio6
		FLsetVal_i	2813/437,	ihratio7
		FLsetVal_i	3389/437,	ihratio8
		FLsetVal_i	4822/437,	ihratio9
		FLsetVal_i	5255/437,	ihratio10

		FLsetVal_i	.003,	ihampatt1
		FLsetVal_i	.003,	ihampatt2
		FLsetVal_i	.003,	ihampatt3
		FLsetVal_i	.003,	ihampatt4
		FLsetVal_i	.003,	ihampatt5
		FLsetVal_i	.003,	ihampatt6
		FLsetVal_i	.003,	ihampatt7
		FLsetVal_i	.003,	ihampatt8
		FLsetVal_i	.003,	ihampatt9
		FLsetVal_i	.003,	ihampatt10

		FLsetVal_i	4.5,	ihampdec1
		FLsetVal_i	7.22,	ihampdec2
		FLsetVal_i	9.26,	ihampdec3
		FLsetVal_i	9.42,	ihampdec4
		FLsetVal_i	8.7,	ihampdec5
		FLsetVal_i	4.98,	ihampdec6
		FLsetVal_i	4.5,	ihampdec7
		FLsetVal_i	2.22,	ihampdec8
		FLsetVal_i	2.42,	ihampdec9
		FLsetVal_i	1.34,	ihampdec10

		FLsetVal_i	.3,	ihamprel1
		FLsetVal_i	.4,	ihamprel2
		FLsetVal_i	.5,	ihamprel3
		FLsetVal_i	.32,	ihamprel4
		FLsetVal_i	.25,	ihamprel5
		FLsetVal_i	.1,	ihamprel6
		FLsetVal_i	.04,	ihamprel7
		FLsetVal_i	.02,	ihamprel8
		FLsetVal_i	.01,	ihamprel9
		FLsetVal_i	.005,	ihamprel10

		FLsetVal_i	437, 		ihfund
		FLsetVal_i	7000, 		ihamp     

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 520, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"      Inharmonic Additive Synthesis 2 - 30 HARMONICS         ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"In inharmonic additive synthesis the partial spacings do not ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"follow the harmonic series and so in this example each of the", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"partials is individually tunable.                            ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The fundemental is defined using the 'Fundemental' slider.   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"(Note that the lowest partial is not necessarily the         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"perceived fundemental of the tone. Curiously in the default  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"timbre produced by this example, which is that of a tubular  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"bell, the perceived fundemental of 437 Hz is not present at  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"all! The fundemental is actually 1 octave below the 3rd      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"partial.) The frequencies of subsequent partials are derived ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"using ratios.                                                ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"A simple ADR envelope is implemented independently for each  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"partial in order to permit the creation of dynamic spectra.  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"This example is designed for producing percussive sounds only", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"and therefore has no sustain portion in any of the amplitude ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"envelopes.                                                   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Notice how, in general, the higher partials tend to decay    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"quicker.                                                     ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"Also when damped, i.e. if the envelopes enter their release  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"stages, the higher partials tend to decay quicker.           ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"The data for the default sound in this example was derived   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"from a sonogram sound analysis program.                      ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"This example also allow pitch control from a MIDI keyboard by", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"first activating the 'MIDI switch in the interface.          ", 	1,      5,     14,    490,    15,     5, 500

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr 	1
if	gkMIDI==1	then
icps		cpsmidi				;READ NOTE INFORMATION FROM LIVE MIDI INPUT (CREATE A VARIABLE 'icps' BASED ON RECEIVED NOTE INFORMATION)
iamp		ampmidi	10000			;READ VELOCITY INFORMATION FROM LIVE MIDI INPUT (CREATE A VARIABLE 'iamp' BASED ON RECEIVED VELOCITY INFORMATION)
kfund	=	icps
kamp	=	iamp
elseif	gkOnOff==1	then
kfund	=	gkfund
kamp	=	gkamp
else
turnoff			;TURN INSTRUMENT OFF
endif

;AMPLITUDE ENVELOPE (WITH MIDI RELEASE SEGMENT)
aenv1		expsegr	.001, i(gkampatt1), 1, i(gkampdec1), .001, i(gkamprel1), .001
aenv2		expsegr	.001, i(gkampatt2), 1, i(gkampdec2), .001, i(gkamprel2), .001
aenv3		expsegr	.001, i(gkampatt3), 1, i(gkampdec3), .001, i(gkamprel3), .001
aenv4		expsegr	.001, i(gkampatt4), 1, i(gkampdec4), .001, i(gkamprel4), .001
aenv5		expsegr	.001, i(gkampatt5), 1, i(gkampdec5), .001, i(gkamprel5), .001
aenv6		expsegr	.001, i(gkampatt6), 1, i(gkampdec6), .001, i(gkamprel6), .001
aenv7		expsegr	.001, i(gkampatt7), 1, i(gkampdec7), .001, i(gkamprel7), .001
aenv8		expsegr	.001, i(gkampatt8), 1, i(gkampdec8), .001, i(gkamprel8), .001
aenv9		expsegr	.001, i(gkampatt9), 1, i(gkampdec9), .001, i(gkamprel9), .001
aenv10		expsegr	.001, i(gkampatt10),1, i(gkampdec10),.001, i(gkamprel10), .001

;SEPARATE OSCILLATORS CREATE EACH OF THE PARTIALS
;OUTPUT		OPCODE	AMPLITUDE	         | FREQUENCY    | FUNCTION_TABLE
apart1		oscil	kamp*aenv1*(1-gkPartAmp1),  kfund*gkratio1, 		1
apart2		oscil	kamp*aenv2*(1-gkPartAmp2),  kfund*gkratio2, 	1
apart3		oscil	kamp*aenv3*(1-gkPartAmp3),  kfund*gkratio3, 	1
apart4		oscil	kamp*aenv4*(1-gkPartAmp4),  kfund*gkratio4, 	1
apart5		oscil	kamp*aenv5*(1-gkPartAmp5),  kfund*gkratio5, 	1
apart6		oscil	kamp*aenv6*(1-gkPartAmp6),  kfund*gkratio6, 	1
apart7		oscil	kamp*aenv7*(1-gkPartAmp7),  kfund*gkratio7, 	1
apart8		oscil	kamp*aenv8*(1-gkPartAmp8),  kfund*gkratio8, 	1
apart9		oscil	kamp*aenv9*(1-gkPartAmp9),  kfund*gkratio9, 	1
apart10      	oscil	kamp*aenv10*(1-gkPartAmp10), kfund*gkratio10, 	1
                                                          
;SUM THE 10 OSCILLATORS:
amix		sum	apart1,\
			apart2,\
			apart3,\
			apart4,\
			apart5,\
			apart6,\
			apart7,\
			apart8,\
			apart9,\
			apart10
			
	outs	amix, amix	;SEND MIXED SIGNAL TO THE OUTPUTS
	endin		


</CsInstruments>

<CsScore>
f 1 0 4096 10 1	;A SINE WAVE
;INSTR | START | DURATION
f       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>