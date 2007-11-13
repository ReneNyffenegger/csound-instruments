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
		FLpanel	"gbuzz",     500,    200,    0,  0

;SWITCHES                                               ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,  -1,     2,    150,     30,     0,  0,    0,      1,      0,       -1

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",      100,    20,    0,  80
idmul			FLvalue	" ",      100,    20,    0, 130
idfreq			FLvalue	" ",      100,    20,    0, 180


;SLIDERS				     			MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkamp, ihamp		FLslider	"Amplitude",  		0,   10000,   0,   5,    idamp,  500,    30,     0, 50
gkmul, ihmul		FLslider	"Amplitude Multiplier",	0,       2,   0,   5,    idmul,  500,    30,     0, 100
gkfreq, ihfreq		FLslider	"Osc. Frequency",    	1,    2000,  -1,   5,   idfreq,  500,    30,     0, 150

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkharm, ihharm 	FLcount  "No. of Harmonics",	-1,   100,    1,      1,      2,   120,      30,   380, 0,    -1
gklh, ihlh 	FLcount  "Lowest Harmonic",	1,    100,    1,      1,      2,   120,      30,   210, 0,    -1

;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	7000, 	ihamp
		FLsetVal_i	30, 	ihharm
		FLsetVal_i	0, 	ihlh
		FLsetVal_i	1, 	ihmul
		FLsetVal_i	100, 	ihfreq

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 340, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Miscellaneous Waveforms : gbuzz              ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Gbuzz creates similar sounds to the buzz opcode by stacking  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"harmonically relates cosine waves but gbuzz offers some      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"additional possibilities.                                    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"In addition to allowing us to choose the number partials     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"above the fundemental that will be present gbuzz allows us to", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"choose what the lowest partial present will be.              ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"The 'Amplitude Multiplier' control allows us to scale the    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"amplitudes of the sequence of partials. With a value of 1 all", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"amplitudes are equal, with values less than one the          ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"amplitudes of higher partials are increasingly attenuated,   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"and with values greater than 1 the lower partials are        ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"increasingly attenuated.                                     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Gbuzz requires us to supply it with a cosine wave function   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"table. This is done using GEN 09.                            ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Gbuzz provides a useful source for subtractive synthesis.    ", 	1,      5,     14,    490,    15,     5, 320
                                                           
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr	1
if	gkOnOff!=-1	kgoto	CONTINUE	;IF FLTK ON/OFF SWITCH IS NOT OFF SKIP TO 'CONTINUE' LABEL 
turnoff						;TURNOFF INSTRUMENT
CONTINUE:     					;LABEL
;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | NO.OF_HARMONICS | LOWEST_HARMONIC | POWER | FUNCTION_TABLE
asig	gbuzz 	gkamp,        gkfreq,        gkharm,            gklh,       gkmul,       1
	outs	asig, asig			;SEND AUDIO OUTPUT TO THE SPEAKERS
	endin

</CsInstruments>


<CsScore>
f 1 0 65536 9 1 1 90  	;COSINE WAVE
f 0 3600		;DUMMY SCORE EVENT - ALLOW REALTIME PERFORMANCE FOR UP TO 1 HOUR 
</CsScore>


</CsoundSynthesizer>



























