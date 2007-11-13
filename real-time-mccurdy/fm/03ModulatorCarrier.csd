;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL                           | WIDTH | HEIGHT | X | Y
	FLpanel	"FM Synthesis: Simple Carrier->Modulator", 500,    300,    0,  0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,  -1,     2,    150,     28,    0,  0,    0,      1,      0,       3600

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    0,   80
idindex				FLvalue	" ",     	60,       20,    0,  130
idCarAmp			FLvalue	" ",     	60,       20,    0,  280

;					            							MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, ihbasefreq		FLslider 	"Base Frequency",		 			20,    20000,  -1,    5,   idbasefreq,    400,    30,     0, 50
gkindex, ihindex		FLslider 	"Modulation Index",					0,        50,   0,    5,   idindex,       400,    30,     0, 100
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",					0,     30000,   0,    5,   idCarAmp,      500,    30,     0, 250

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    220,    70,   140, 160

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, ihCarRatio		FLtext		" ", 			.125,   8,  .001,   1,     50,     20,   190, 170
gkModRatio, ihModRatio		FLtext		" ", 			.125,   8,  .001,   1,     50,     20,   260, 170
gkPeakDev, gihPeakDev		FLtext		"Peak Deviation", 	0,  10000,     0,   1,     80,     20,   410,  65 ;DISPLAY ONLY!

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    248,  172
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    90,    15,    170,  200
ih		 	FLbox  	"Modulator Frequency", 					1,      5,     12,    90,    15,    245,  200

			FLsetVal_i	100, 	ihbasefreq
			FLsetVal_i	3, 	ihindex
			FLsetVal_i	1, 	ihCarRatio
			FLsetVal_i	1, 	ihModRatio
			FLsetVal_i	20000, 	ihCarAmp

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 560, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          FM Synthesis: Simple Modulator->Carrier            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example also employs a simple modulator carrier pairing.", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"This time, however, the FM implementation and the parameters ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"presented to the user are more typical (and more usable).    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The 'Index of Modulation' is used to control the spectral    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"intensity (brightness) of the FM timbre. This value is used  ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"in the formula: 'Peak Deviation = Index * Base Frequency' to ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"calculate the Peak Deviation (amplitude) of the modulator    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"within the code. A value box for peak deviation is provided  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"to inform the user how its value changes in relation to      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"changes made to the base frequency and the index of          ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"modulation. The value for peak deviation can not be directly ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"modified by the user, its value box in the interface is for  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"display purposes only.                                       ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"The frequencies of the carrier and modulator are calculated  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"in relation to 'Base Frequency' using a ratio between the    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"carrier frequency and the modulator frequency. This practice ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"makes it easier for the user to see when the two frequencies ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"are in a simple ratio with respect to each other.            ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"Although the code for this example makes use of two separate ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"'oscili' (oscillator) opcodes for the modulator and carrier  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"an opcode exists that will allow the FM carrier modulator    ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"pair to be implemented in a single line (foscil/foscili). The", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"advantage of emplying separate 'oscili's is that a better    ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"understanding of the innards of FM synthesis is gained and   ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"also that the algorithm can easily be expanded to create more", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"complex multi-modulator and multi-carrier algorithms.        ", 	1,      5,     14,    490,    15,     5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	instr 1
if	gkOnOff!=-1	kgoto	CONTINUE	;SENSE IF FLTK INSTRUMENT ON/OFF SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
turnoff						;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:					;A LABEL

kpeakdeviation	=	gkbasefreq * gkindex	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION

;OUTPUT		OPCODE	AMPLITUDE         |     FREQUENCY                         | FUNCTION_TABLE
aModulator	oscili	kpeakdeviation,    gkbasefreq * gkModRatio,                       1		;DEFINE THE MODULATOR WAVEFORM
aCarrier	oscili	gkCarAmp,         (gkbasefreq * gkCarRatio) + aModulator,    	  1		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
		outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
ktrig	  	metro	10	;CREATE A REPEATING TRIGGER SIGNAL
		FLsetVal 	ktrig, kpeakdeviation, gihPeakDev	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED

		endin
	
</CsInstruments>


<CsScore>
f 1 0 129 10 1	;A SINE WAVE (INTERPOLATING OSCILLATOR OPCODES ARE USED THEREFORE A SMALL TABLE SIZE (+1) CAN BE USED)
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR

</CsScore>


</CsoundSynthesizer>



























