;Written by Iain McCurdy, 2006

;THE NREVERB OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
;THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;				LABEL    | WIDTH | HEIGHT | X | Y
			FLpanel	"nreverb",  500,    200,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,  -1,     2,    200,     30,     0,  0,    0,      1,      0,      -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idmix				FLvalue	" ",      60,      18,   15,  80
idrvbtime			FLvalue	" ",      60,      18,   15,  130
idHFDiff			FLvalue	" ",      60,      18,   15,  180

;SLIDERS					            			MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkmix,ihmix		FLslider 	"Dry/Wet Mix",		 		0,      1,    0,    5,   idmix,      500,    30,     0,  50
gkrvbtime,ihrvbtime	FLslider 	"Reverb time",		 		.001,   20,   0,    5,   idrvbtime,  500,    30,     0,  100
gkHFDiff,ihHFDiff	FLslider 	"High Freq Diffusion",		 	0,      1,    0,    5,   idHFDiff,   500,    30,     0,  150

;SET INITIAL VALUES OF FLTK VALUATORS
;					VALUE | HANDLE
			FLsetVal_i	.5, 	ihmix
			FLsetVal_i	.5, 	ihrvbtime
			FLsetVal_i	.5, 	ihHFDiff

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 680, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          nreverb                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"nreverb is a reverberation unit within which is contained an ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"algorithm consisting of six parallel comb filters and five   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"series allpass filters (as shown below).                     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Obligatory input arguments besides the input audio signal are", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"for reverb time in seconds and for high frequency diffusion  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"(range: 0 to 1). Use of high frequency diffusion activates   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"low pass filters within the algorithm which can help improve ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"the simulation of a real acoustic space.                     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"An optional 2-wayswitch defines the initial disposition of   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"the delay loop data (0=cleared, 1=previous data retained).   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"It should be bourne in mind that the 'reverb' algorithm      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"represents quite a basic reverb algorithm and that with      ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"transient input audio granularity in the reverb effect       ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"becomes quite evident.                                       ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"In this example a Dry/Wet Mix crossfader is also implemented.", 	1,      5,     14,    490,    15,     5, 300

ih		 	FLbox  	"       +----+                                                ", 	1,      5,     14,    490,    15,     5,  30+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5,  45+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5,  60+300
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    15,     5,  75+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5,  90+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 105+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 120+300
ih		 	FLbox  	"     +        +                                              ", 	1,      5,     14,    490,    15,     5, 135+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 150+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 165+300
ih		 	FLbox  	"     | +----+ | +-----+ +-----+ +-----+ +-----+ +-----+      ", 	1,      5,     14,    490,    15,     5, 180+300
ih		 	FLbox  	"IN-->|        |-|alpas|-|alpas|-|alpas|-|alpas|-|alpas|-->OUT", 	1,      5,     14,    490,    15,     5, 195+300
ih		 	FLbox  	"     | +----+ | +-----+ +-----+ +-----+ +-----+ +-----+      ", 	1,      5,     14,    490,    15,     5, 210+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 225+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 240+300
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    15,     5, 255+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 270+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 285+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 300+300
ih		 	FLbox  	"     |        |                                              ", 	1,      5,     14,    490,    15,     5, 315+300
ih		 	FLbox  	"     | +----+ |                                              ", 	1,      5,     14,    490,    15,     5, 330+300
ih		 	FLbox  	"     +-|comb|-+                                              ", 	1,      5,     14,    490,    15,     5, 345+300
ih		 	FLbox  	"       +----+                                                ", 	1,      5,     14,    490,    15,     5, 360+300

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gaSigL	init	0
gaSigR	init	0

	
	instr	1	;FILE PLAYING INSTRUMENT
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:	
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gaSigL, gaSigR	diskin	"808loop.wav",     1,       0,       1
		endin

		instr	2	;REVERB INSTRUMENT
aRvbL		nreverb	gaSigL*.3, gkrvbtime, gkHFDiff	;CREATE LEFT CHANNEL REVERB 
aRvbR		nreverb	gaSigR*.3, gkrvbtime, gkHFDiff	;CREATE RIGHT CHANNEL REVERB
		outs	(aRvbL * gkmix * .5) + (gaSigL * (1 - gkmix)), (aRvbR * gkmix * .5) + (gaSigR * (1 - gkmix))	;MIX SOURCE SIGNAL AND REVERB SIGNAL AT THE OUTPUT AND IMPLEMENT WET/DRY CONTROL USING THE FLTK SLIDER VARIABLE gkmix
gaSigL		=	0	;CLEAR GLOBAL AUDIO SEND VARIABLES
gaSigR		=	0	;CLEAR GLOBAL AUDIO SEND VARIABLES
		endin
	
</CsInstruments>

<CsScore>
i 2 0 -1	;INSTRUMENT 2 (REVERBERATING INSTRUMENT) PLAYS A HELD NOTE
f 0 3600	;'DUMMY' SCORE EVENT: KEEP THE PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>