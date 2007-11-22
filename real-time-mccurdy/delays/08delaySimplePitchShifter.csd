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
;			LABEL                    | WIDTH | HEIGHT | X | Y
		FLpanel	"Simple Pitch Shifter",     500,    150,    0,  0

;SWITCHES                                              		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idtrans				FLvalue	" ",     100,    20,     0,  80
iddlt				FLvalue	" ",     100,    20,     0, 130

;SLIDERS					            				MIN |  MAX | EXP | TYPE | DISP    | WIDTH | HEIGHT | X | Y
gktrans,ihtrans			FLslider 	"Transposition (semitones)",		-24,   24,    0,    5,   idtrans,    500,     30,    0,  50
gkdlt,ihdlt			FLslider 	"Delay Time",				.001,  .2,    0,    5,   iddlt,      500,     30,    0, 100

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0, 	ihtrans
		FLsetVal_i	.05, 	ihdlt

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                  delay - simple pitch shifter               ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"If the delay time is moved in a continuous cycle using a     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"sawtooth waveform then a steady pitch shifting effect can be ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"achieved. By using a sawtooth up waveform (1.) downward      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"transpositions are achieved. By using a sawtooth down        ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"waveform (2.) upward transpoisitions are achieved.           ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"The 'Delay Time' slider controls the amplitude of the        ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"sawtooth waveform that modulates the delay time. Very short  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"settings of this parameter can lead to harmonic distortions  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"of the input signal but whilst longer 'Delay Time' settings  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"give smoother pitch shifing effects, the temporal distortion ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"of the source material becomes more marked.                  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"This is an extremely basic demonstration of this technique   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"and glitches in the audio stream are heard each time the     ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"waveform jumps back to the beginning of its cycle. In real   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"pitch shifters (and in the next example) each cycle of the   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"delay time oscillation is amplitude enveloped to mute these  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"glitches.                                                    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"1. Transpose down:   /|  /|  /|  /|  /|  /|  /|  /|  /|  /|  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"                    / | / | / | / | / | / | / | / | / | / | /", 	1,      5,     14,    490,    15,     5, 395
ih		 	FLbox  	"                   /  |/  |/  |/  |/  |/  |/  |/  |/  |/  |/ ", 	1,      5,     14,    490,    15,     5, 410
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 425
ih		 	FLbox  	"2. Transpose up:   |\\  |\\  |\\  |\\  |\\  |\\  |\\  |\\  |\\  |\\  |\\", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"                   | \\ | \\ | \\ | \\ | \\ | \\ | \\ | \\ | \\ | \\ | ", 	1,      5,     14,    490,    15,     5, 455
ih		 	FLbox  	"                   |  \\|  \\|  \\|  \\|  \\|  \\|  \\|  \\|  \\|  \\| ", 	1,      5,     14,    490,    15,     5, 470

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

		instr 	2	;FLANGER-DELAY INSTRUMENT
koctfract	=	gktrans/12			;TRANSPOSITION AS FRACTION OF AN OCTAVE
kratio		=	cpsoct(8+koctfract)/cpsoct(8)	;RATIO OF NEW FREQ TO A DECLARED BASE FREQUENCY (MIDDLE C)
krate		=	(kratio-1)/gkdlt		;SUBTRACT 1/1 SPEED

aphase		phasor	-krate			; MOVING PHASE 1-0

aignore		delayr	.2			; ALLOC DELAY LINE
adelsig		deltap3	aphase * gkdlt		; VARIABLE TAP
		delayw	gasig			; WRITE AUDIO TO THE BEGINNING OF THE DELAY BUFFER

		outs	adelsig, adelsig

gasig		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
		endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 1 0 131072 7 0 65536 1 65536 0	;POSITIVE DOMAIN TRIANGLE WAVE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























