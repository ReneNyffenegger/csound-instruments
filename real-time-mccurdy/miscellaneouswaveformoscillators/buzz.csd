;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>


<CsInstruments>

sr 	= 	44100  
kr 	= 	4410
ksmps 	= 	10
nchnls 	= 	2	

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL     | WIDTH | HEIGHT | X | Y
		FLpanel	"buzz",      500,    150,    0,  0

;SWITCHES					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,  -1,     2,    150,     30,     0,  0,    0,      1,      0,       -1

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",	100,      20,    0,  80
idfreq			FLvalue	" ",	100,      20,    0,  130

;SLIDERS				     			MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp, ihamp		FLslider	"Amplitude",  		0,   10000,  0,    5,   idamp,   500,     30,    0,  50
gkfreq, ihfreq		FLslider	"Oscillator Frequency",	1,    5000, -1,    5,   idfreq,  500,     30,    0,  100

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkharm,   ihharm 	FLcount  "No. of Harmonics",	-1,   80,    1,      2,      2,   120,      30,   380, 0,    -1

;SET INITIAL VALUES		VALUE | HANDLE
		FLsetVal_i	7000, 	ihamp
		FLsetVal_i	30, 	ihharm
		FLsetVal_i	100, 	ihfreq

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Miscellaneous Waveforms : buzz               ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Buzz creates a composite tone of harmonically related sine   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"wave partials.                                               ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The user is given control of the number of partials required ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"(from the fundemental upwards) and of the the amplitude and  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the fundemental frequency of the tone.                       ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"Buzz requires the user to first supply it with a sine        ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"waveform via a function table (probably GEN 10). This table  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"should not be too small, sizes of 8192 and upwards are       ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"recommended.                                                 ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Buzz provides a useful source for subtractive synthesis.     ", 	1,      5,     14,    490,    15,     5, 220
                                                            
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr	1
if	gkOnOff!=-1	kgoto	CONTINUE	;IF FLTK ON/OFF SWITCH IS NOT OFF SKIP TO 'CONTINUE' LABEL 
turnoff						;TURNOFF INSTRUMENT
CONTINUE:     					;LABEL
ifn	=	2				;FUNCTION TABLE USED BY BUZZ OPCODE
;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | NO.OF HARMONICS | FUNCTION_TABLE
asig	buzz	gkamp,       gkfreq,    int(gkharm),            ifn
	outs	asig, asig			;SEND AUDIO OUTPUT TO THE SPEAKERS
	endin

</CsInstruments>

<CsScore>
f2 0 131072 10 1  ;SINE WAVE
f 0 3600	;DUMMY SCORE EVENT - ALLOW REALTIME PERFORMANCE FOR UP TO 1 HOUR 
</CsScore>

</CsoundSynthesizer>