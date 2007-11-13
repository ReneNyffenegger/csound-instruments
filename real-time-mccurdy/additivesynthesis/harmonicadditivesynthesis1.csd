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
;			LABEL                 | WIDTH | HEIGHT | X | Y
		FLpanel	"Additive Synthesis 1",  500,    400,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR	p4	p5	p6	p7	p8	p9	p10	p11	p12	p13	p14	p15	p16	p17	p18	p19	p20	p21	p22	p23	p24	p25	p26	p27	p28	p29	p30	p31	p32	p33
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    150,     30,    0,  0,    0,      1,      0,       -1

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idfund				FLvalue	" ",     50,     15,     0, 320
idamp				FLvalue	" ",     50,     15,     0, 370

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
gkfund, ihfund			FLslider 	"Fundemental (Hertz)",	20,   10000,-1,     3,  idfund,  500,     20,     0, 300
gkamp,  ihamp			FLslider 	"Global Amplitude",	0,    32768, 0,     3,  idamp,   500,     20,     0, 350

;TEXT BOXES              			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Partial Strength:", 	1,      9,     12,    90,     10,     0, 281

;SET_INITIAL_VALUES		VALUE 	       | HANDLE
		FLsetVal_i	1-.55, 		ihPartAmp1	
		FLsetVal_i	1-.55, 		ihPartAmp2	
		FLsetVal_i	1-.9, 		ihPartAmp3	
		FLsetVal_i	1-.45, 		ihPartAmp4	
		FLsetVal_i	1-.5,		ihPartAmp5	
		FLsetVal_i	1-.5, 		ihPartAmp6	
		FLsetVal_i	1-.8, 		ihPartAmp7	
		FLsetVal_i	1-.3, 		ihPartAmp8	
		FLsetVal_i	1-.3, 		ihPartAmp9	
		FLsetVal_i	1-.3, 		ihPartAmp10     
		FLsetVal_i	440, 		ihfund
		FLsetVal_i	7000, 		ihamp     

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 460, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           Additive Synthesis 1 - 10 Harmonics               ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Additive synthesis is the technique whereby sine waves of    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"different frequencies are mixed and manipulated in such a way", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"that they are perceived fused and seem to form a new, more   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"complex tone. The inspiration for additive synthesis comes   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"from Fourier theory that states that any sound can be        ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"replicated as a composite of sine waves of various           ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"frequencies and phases.                                      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"In harmonic additive synthesis the sequence of frequencies   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"followed by the different sine wave oscillators follows that ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of the harmonic series in that each harmonic is a product of ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"the fundemental. For example: if the fundemental of a        ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"harmonic tone is 100 Hz. then its 1st harmonic will be at    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"200 Hz. its 2nd at 300 Hz and so on.                         ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"This example offers the user manipulation of the first 10    ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"harmonics but to synthesize bright timbres rich in higher    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"harmonics such as a violin this number will be insufficient. ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"The next example utilises more partials demonstrates some    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"ways in which the fusion of partials can be enhanced but also", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"draws attention to the shortcomings of additive synthesis.   ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Note that the fundemental can also be referred to as the 1st ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"partial, the 1 harmonic as the 2nd partial and so on.        ", 	1,      5,     14,    490,    15,     5, 440

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr 	1
if	gkOnOff!=-1	kgoto	CONTINUE	;SENSE IF FLTK SWITCH IS OFF AND IF SO TURN OFF INSTR 1
turnoff                                         ;SENSE IF FLTK SWITCH IS OFF AND IF SO TURN OFF INSTR 1
CONTINUE:                                       ;SENSE IF FLTK SWITCH IS OFF AND IF SO TURN OFF INSTR 1

;SEPARATE OSCILLATORS CREATE EACH OF THE PARTIALS
;OUTPUT		OPCODE	AMPLITUDE             | FREQUENCY        | FUNCTION_TABLE
apart1		oscil	gkamp*(1-gkPartAmp1),  gkfund, 			 1		;FUNDEMENTAL
apart2		oscil	gkamp*(1-gkPartAmp2),  gkfund+(gkfund), 	 1		;1ST HARMONIC
apart3		oscil	gkamp*(1-gkPartAmp3),  gkfund+(gkfund*2), 	 1       	;2ND HARMONIC
apart4		oscil	gkamp*(1-gkPartAmp4),  gkfund+(gkfund*3), 	 1       	;3RD HARMONIC
apart5		oscil	gkamp*(1-gkPartAmp5),  gkfund+(gkfund*4), 	 1       	;4TH HARMONIC
apart6		oscil	gkamp*(1-gkPartAmp6),  gkfund+(gkfund*5), 	 1       	;5TH HARMONIC
apart7		oscil	gkamp*(1-gkPartAmp7),  gkfund+(gkfund*6), 	 1       	;6TH HARMONIC
apart8		oscil	gkamp*(1-gkPartAmp8),  gkfund+(gkfund*7), 	 1       	;7TH HARMONIC
apart9		oscil	gkamp*(1-gkPartAmp9),  gkfund+(gkfund*8), 	 1       	;8TH HARMONIC
apart10      	oscil	gkamp*(1-gkPartAmp10), gkfund+(gkfund*9), 	 1       	;9TH HARMONIC

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
f       0       3600	;DUMMY SCORE EVENT - ALLOWS REALTIME PERFORMANCE FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>



























