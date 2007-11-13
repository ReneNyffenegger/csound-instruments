;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	44100	;CONTROL RATE
ksmps 		= 	1	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL             | WIDTH | HEIGHT | X | Y
	FLpanel	"Completed Pitch Shifter",   500,    150,    0,  0

;VALUE_DISPLAY_BOXES		WIDTH | HEIGHT | X | Y
idtrans		FLvalue   " ",	88,       20,    5,  80
iddlt		FLvalue   " ",	88,       20,    5,  130

;SWITCHES                                              	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,   -1,     2,    200,     30,    0,  0,   0,      1,      0,      -1

;SLIDERS					            		MIN | MAX | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
gktrans,ihtrans		FLslider	"Transposition (semitones)",  	-24,  24,    0,     5,   idtrans,     500,     26,    0,  50
gkdlt,ihdlt		FLslider	"Delay Time",  			.001, .2,    0,     5,   iddlt,       500,     26,    0,  100

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i   	0, 	ihtrans
		FLsetVal_i   	.05, 	ihdlt

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               delay - completed pitch shifter               ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example is an refinement of the 'Delay: Simple Pitch    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Shifter' example in that amplitude enveloping is employed to ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"prevent glitching in the sound output whenever the sawtooth  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"LFO waveform that modulates delay time instantaneously jumps ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"from a maximum to a minimum (or vice versa).                 ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Two modulated delay taps (180 degrees out of phase with each ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"other) are employed and are enveloped individually.          ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The outputs of the two delay taps are mixed to create an - as", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"smooth as possible - pitch shifted output.                   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Pitch shifting effects can also be produced using any of the ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"granular synthesis opcodes but this method has the advantage ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"that it can be applied to a streamed live audio input or a   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"signal generated within Csound and it does not rely upon a   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"stored function table.                                       ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Some experimentation with the setting for 'Delay Time' can   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"enhance the resultant sound quality. An appropriate setting  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"for 'Delay Time' is partially dependent upon the type of     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"sound material being processed. Most hardware implementations", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"of pitch shifters do not include this parameter.             ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Large values for 'Delay Time' tend to temporally smear the   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"processed sound whereas excessively small values for 'Delay  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"Time' tend to distort the harmonic content of the original   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"sound.                                                       ", 	1,      5,     14,    490,    15,     5, 480

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
;OUTPUT		OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasig		diskin	"AndItsAll.wav",     1,       0,        1
		endin

		instr	2			; PITCH SHIFTER
koctfract	=	gktrans/12			;TRANSPOSITION AS FRACTION OF AN OCTAVE
kratio		=	cpsoct(8+koctfract)/cpsoct(8)	;RATIO OF NEW FREQ TO A DECLARED BASE FREQUENCY (MIDDLE C)
krate		=	(kratio-1)/gkdlt		;SUBTRACT 1/1 SPEED

aphase1		phasor	-krate			; MOVING PHASE 1-0
aphase2		phasor	-krate, .5		; MOVING PHASE 1-0 - PHASE OFFSET BY 180 DEGREES (.5 RADIANS)

agate1		tablei	aphase1, 1, 1, 0, 1	; WINDOW FUNC =TRIANGLE
agate2		tablei	aphase2, 1, 1, 0, 1	; WINDOW FUNC =TRIANGLE

aignore		delayr	.2			; ALLOC DELAY LINE
adelsig1	deltap3	aphase1 * gkdlt		; VARIABLE TAP
		delayw	gasig			; WRITE AUDIO TO THE BEGINNING OF THE DELAY BUFFER

aignore		delayr	.2			; ALLOC DELAY LINE
adelsig2	deltap3	aphase2 * gkdlt		; VARIABLE TAP
		delayw	gasig			; WRITE AUDIO TO THE BEGINNING OF THE DELAY BUFFER
		
aGatedSig1	=	adelsig1 * agate1
aGatedSig2	=	adelsig2 * agate2
aGatedMix	=	(aGatedSig1 + aGatedSig2) * .5
		outs	aGatedMix, aGatedMix
		endin

</CsInstruments>

<CsScore>
f 1 0 1025 20 3       ; TRIANGLE WINDOW FUNCTION USED FOR AMPLITUDE ENVELOPING

;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>