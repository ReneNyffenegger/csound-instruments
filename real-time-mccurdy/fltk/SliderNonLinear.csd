;Written by Iain McCurdy

;DEMONSTRATION OF HOW TO CREATE A SLIDER DERIVED VARIABLE WITH A NON-LINEAR MOVEMENT

;COULD BE USED TO CREATE A 3-WAY CROSSFADER
				
<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	2

;       OPCODE |    "LABEL"        | WIDTH | HEIGHT | X | Y
	FLpanel	"NON-LINEAR SLIDER",  900,    250,   10, 10

;VALUE DISPLAY BOX TO DISPLAY THE OUTPUT OF THE SLIDER
;HANDLE        | OPCODE | "LABEL" | WIDTH | HEIGHT | POS_X | POS_Y
 idval	    	FLvalue    " ",      50,     20,      9,      55

;CREATE A SLIDER WHICH WILL POINT TO LOCATIONS WITHIN FUNCTION TABLE 2 (WHICH HAS 1024 LOCATIONS, PLUS ZERO!) 
;OUTPUT | O.P.HANDLE |    OPCODE       |     "LABEL"      | MIN | MAX | EXP | TYPE | DISPLAY_HANDLE | WIDTH | HEIGHT | POS_X | POS_Y
gkval,    ihval         FLslider	"Table Location",    0,   1024,  0,     3,      idval,         750,    30,     125,     50

;CREATE A VALUATOR THAT WILL ALLOW US TO DISPLAY THE FREQUENCY VALUE CALCULATED IN INSTR 1
;						MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X | Y
gkfreq, gihfreq	FLtext		"Frequency",	100, 1000,  .001,    1,    100,     30,    9, 105

;INITIALISE THE SLIDER
;       OPCODE     | INITIAL_VALUE | DESTINATION_HANDLE
	FLsetVal_i       0,              ihval

;A TEXT BOX IS CREATED TO EXPLAIN WHAT WILL HAPPEN
;                                       										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCC	FLbox  "FREQUENCY VALUES BEGIN AT 200 Hz, RISE TO 300 Hz, FALL TO 100 Hz AND FINALLY RISE TO 1000 Hz.        ",   1,    14,    15,    820,     25,    5, 175
ihCC	FLbox  "This is achieved by rescaling the output of the slider with a GEN 07 break point type function table.",   1,    14,    15,    820,     25,    5, 200
ihCC	FLbox  "The FLTK slider is actually outputting values to be read from this table.                            ",   1,    14,    15,    820,     25,    5, 225

	FLpanel_end
	FLrun

	instr 1
;GENERATE FREQUENCY VARIABLE (gkfreq) FOR THE OSCILLATOR THAT WILL BE READ FROM FUNCTION TABLE 
;-USING THE POINTER VARIABLE gkval WHICH HAS BE DEFINED USING AN ON SCREEN FLTK SLIDER.
;OUTPUT VARIABLE IS A GLOBAL VARIABLE BECAUSE IT WILL BE SENT TO AN FLTK VALUATOR BOX (OUTSIDE OF THIS INSTRUMENT)
gkfreq	table	gkval, 2

;THE FOLLOWING 2 LINES OF CODE ARE USED TO DISPLAY THE VARIABLE gkfreq IN AN FLTK VALUATOR BOX
ktrig		changed	gkfreq		;IF gkfreq CHANGES A TRIGGER IMPULSE IS GENERATED
FLsetVal 	ktrig, gkfreq, gihfreq	;IF A TRIGGER IMPULSE HAS BEEN GENERATED UPDATE SLIDER gihfreq WITH THE VALUE gkfreq

;CREATE AN OSCILLATOR
;                AMP  | FREQ | FN
asig	oscil	20000,  gkfreq, 1

	outs	asig, asig	;SEND OSCILLATOR SIGNAL TO THE STEREO OUTPUT
	endin

</CsInstruments>

<CsScore>
f 1 0 131072 10 1	;A SINE WAVE
;TABLE 2 IS USED A BIT LIKE A LINSEG (GEN 7 USED. MINUM SIGN DEFINES THAT NON-NORMALISED, RAW VALUES WILL BE USED)
;VALUES BEGIN AT 200 (Hz), RISES TO 300, FALLS TO 100 AND FINALLY RISES TO 1000
;FN | STRT | SIZE | GEN | VALUE | DUR | VALUE | DUR | VALUE | DUR | VALUE
f 2    0     1024   -7	   200	  341	 300	341    100    342   1000

i 1 0 3600	;INSTRUMENT 1 PLAYS FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>