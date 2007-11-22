;Written by Iain McCurdy, 2006

;THE delay OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
;THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

;ksmps MAY NEED TO BE LOW (AND kr THEREFORE HIGH) WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE

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
		FLpanel	"delayr,delayw,deltap",  500,    150,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,   -1,     2,    200,     30,    0,  0,    0,      1,      0,       -1


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",     100,    20,     0,  80
idmix				FLvalue	" ",     100,    20,     0, 130

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",		.001,  5,    0,    5,   iddlt,     500,     30,    0,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,     1,    0,    5,   idmix,     500,     30,    0, 100

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.5, 	ihdlt
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	-1, 	ihOnOff

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 620, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                      delayr delayw deltap                   ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"A common way to implement a delay line in Csound is through a", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"combination of three opcodes.                                ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Delayr is used to inititiate a delay buffer. This allocates  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"computer RAM for audio storage. Delayr's only input argument ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"is the duration of the buffer in seconds. The buffer duration", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"should be at least equal to the duration of the longest delay", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"tap required. The buffer duration can be overestimated but   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"vast overestimation is wasteful of computer resources.       ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Delayr's audio output is the audio signal read at the end of ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"the buffer. Normally this signal is left unused but it is    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"still required to exist nonetheless.                         ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Delayw is used to write audio into the beginning of the delay", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"buffer. Its only input argument is the source signal to be   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"written into the buffer. Delayw has no output arguments.     ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Deltap is used to tap the delay buffer at some point across  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"its duration. Its only input argument is the delay time      ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"(in seconds) at which to tap the audio buffer. This time     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"value should not exceed the entire duration of the buffer    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"previously defined using delayr and it should not be less    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"than ksmps (ksmps=control rate cycle duration) For this      ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"reason ksmps may need to be set low and therefore kr         ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"(kr=number of audio samples in a control-rate cycle) may need", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"to be set high in to allow very short delay times. The delay ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"time given to the deltap opcode should not be zero of a      ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"negative value. The deltap code is placed after the delayr   ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"code and before the delayw code.                             ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"There are opcodes that allow the creation of a delay in a    ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"single line of code but they do not allow the flexibilty of  ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"including further signal processing within the delay buffer. ", 	1,      5,     14,    490,    15,     5, 600

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr	1	;PLAYS FILE
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gasigL, gasigR	diskin	"808loop.wav",     1,       0,        1
		endin

		instr 		2	;DELAY INSTRUMENT
;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
abufferL	delayr	5	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigL 	deltap	gkdlt	;TAP THE DELAY LINE AT gkdlt SECONDS
		delayw	gasigL	;WRITE AUDIO INTO THE BEGINNING OF THE BUFFER

abufferR	delayr	5	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
adelsigR 	deltap	gkdlt	;TAP THE DELAY LINE AT gkdlt SECONDS
		delayw	gasigR	;WRITE AUDIO INTO THE BEGINNING OF THE BUFFER

		outs		(adelsigL * gkmix) + (gasigL * (1-gkmix)), (adelsigR * gkmix) + (gasigR * (1-gkmix))	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT
gasigL		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
gasigR		=	0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
		endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























