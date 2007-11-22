;Written by Iain McCurdy

;A SINGLE SLIDER IS USE TO CONTROL 3 DIFFERENT VARIABLE WHICH MOVE IN DIFFERENT WAYS

;FOR SIMPLICITY I WOULD SUGGEST THAT THE SLIDER MOVES WITHIN THE RANGE 0 TO 1

;THE OUTPUT OF THIS SLIDER WILL BE RESCALED IN 3 DIFFERENT WAYS TO CREATE 3 DIFFERENT VARIABLES
;-WHICH WILL BE USED TO DEFINE THE FREQUENCIES OF 3 DIFFERENT OSCILLATORS

;THE FREQUENCIES OF THESE OSCILLATORS WILL BE DISPLAYED IN FLTK VALUATOR BOXES
			
<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	2

;       OPCODE |             "LABEL"          | WIDTH | HEIGHT | X | Y
	FLpanel	"SINGLE SLIDER MULTI-VARIABLE",  900,    500,    0,  0

;VALUE DISPLAY BOX TO DISPLAY THE OUTPUT OF THE SLIDER
;HANDLE        | OPCODE | "LABEL" | WIDTH | HEIGHT | POS_X | POS_Y
 idval	    	FLvalue    " ",      80,     20,      9,      55

;CREATE A SLIDER, RANGE 0 TO 1   
;OUTPUT | O.P.HANDLE |    OPCODE       |    "LABEL"   | MIN | MAX | EXP | TYPE | DISPLAY_HANDLE | WIDTH | HEIGHT | POS_X | POS_Y
gkval,    ihval         FLslider	"Range: 0-1",    0,    1,    0,     3,      idval,         750,    30,     125,     50

;CREATE 3 VALUATORS THAT WILL ALLOW US TO DISPLAY THE 3 FREQUENCY VALUES CALCULATED IN INSTRUMENT 1
;						        MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X | Y
gkfreq1, gihfreq1	FLtext		"Freq. 1",	200,  300,   0,     1,     80,      20,    9, 105
gkfreq1, gihfreq2	FLtext		"Freq. 2",	100,  500,   0,     1,     80,      20,    9, 155
gkfreq1, gihfreq3	FLtext		"Freq. 3",	250,  350,   0,     1,     80,      20,    9, 205

;INITIALISE THE SLIDER POSITION
;       OPCODE     | INITIAL_VALUE | DESTINATION_HANDLE
	FLsetVal_i       0,              ihval

;SOME TEXT BOXES ARE CREATED TO DESCRIBE WHAT WILL HAPPEN
;                                       					               		       TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCC	FLbox  "3 OSCILLATORS ARE CREATED, THE FREQUENCIES OF WHICH ARE ALL CONTROLLED FROM A SINGLE SLIDER.",   1,    14,    15,    800,     30,    5,  250
ihCC	FLbox  "OSCILLATOR 1 MOVES FROM 200 TO 300 Hz                                                       ",   1,    14,    15,    800,     30,    5,  275
ihCC	FLbox  "OSCILLATOR 2 MOVES FROM 100 TO 500 Hz                                                       ",   1,    14,    15,    800,     30,    5,  300
ihCC	FLbox  "OSCILLATOR 3 MOVES FROM 350 TO 250 Hz                                                       ",   1,    14,    15,    800,     30,    5,  325
ihCC	FLbox  "The slider itself only outputs values within the range 0 to 1. The values it outputs are    ",   1,    14,    15,    800,     30,    5,  350
ihCC	FLbox  "mathematically tranformed within the code to provide the ranges of values required by the   ",   1,    14,    15,    800,     30,    5,  375
ihCC	FLbox  "three oscillators.                                                                          ",   1,    14,    15,    800,     30,    5,  400

	FLpanel_end
	FLrun

	instr 1
;THREE FREQUENCY VARIABLE ARE CREATED DERIVED FROM THE SLIDER OUTPUT (RANGE 0 TO 1)
;OSCILLATOR 1: DESIRED RANGE 200 - 300 Hz
kfreq1		=	(gkval*100) + 200

;OSCILLATOR 2: DESIRED RANGE 100 - 500 Hz
kfreq2		=	(gkval*400) + 100

;OSCILLATOR 3: DESIRED RANGE 350 - 250 Hz
kfreq3		=	(gkval*-100) + 350

;THE FOLLOWING 6 LINES OF CODE ARE USED TO DISPLAY THE VARIABLES kfreq1, kfreq2 & kfreq3  IN FLTK VALUATOR BOXES
ktrig1		changed	kfreq1			;IF kfreq1 CHANGES A TRIGGER IMPULSE (trig1) IS GENERATED                                   
FLsetVal 	ktrig1, kfreq1, gihfreq1        ;IF A TRIGGER IMPULSE (trig1) HAS BEEN GENERATED UPDATE SLIDER gihfreq1 WITH THE VALUE kfreq1
ktrig2		changed	kfreq2			;IF kfreq2 CHANGES A TRIGGER IMPULSE (trig2) IS GENERATED                                   
FLsetVal 	ktrig2, kfreq2, gihfreq2        ;IF A TRIGGER IMPULSE (trig2) HAS BEEN GENERATED UPDATE SLIDER gihfreq2 WITH THE VALUE kfreq2
ktrig3		changed	kfreq3			;IF kfreq3 CHANGES A TRIGGER IMPULSE (trig3) IS GENERATED                                   
FLsetVal 	ktrig3, kfreq3, gihfreq3        ;IF A TRIGGER IMPULSE (trig3) HAS BEEN GENERATED UPDATE SLIDER gihfreq3 WITH THE VALUE kfreq3

;CREATE THE 3 OSCILLATORS
;               	 AMP  | FREQ | FN
asig1		oscil	6000,  kfreq1, 1
asig2		oscil	6000,  kfreq2, 1
asig3		oscil	6000,  kfreq3, 1


		outs	asig1+asig2+asig3, asig1+asig2+asig3
		endin

</CsInstruments>

<CsScore>
f 1 0 4096 10 1
i 1 0 3600
</CsScore>

</CsoundSynthesizer>