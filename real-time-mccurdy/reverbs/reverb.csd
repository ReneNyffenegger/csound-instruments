;Written by Iain McCurdy, 2006

;THE REVERB OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
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
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"reverb",  500,    150,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,  -1,     2,     200,     30,    0,  0,    0,      1,      0,      -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idmix				FLvalue	" ",       60,    18,    15,  80
idrvbtime			FLvalue	" ",       60,    18,    15,  130

;SLIDERS					            	MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X | Y
gkmix,ihmix		FLslider 	"Dry/Wet Mix",		0,     1,    0,    5,   idmix,      500,    30,     0,  50
gkrvbtime,ihrvbtime	FLslider 	"Reverb time",		.001,  20,   0,    5,   idrvbtime,  500,    30,     0,  100

;SET INITIAL VALUES OF FLTK VALUATORS
;					VALUE | HANDLE
			FLsetVal_i	.5, 	ihmix
			FLsetVal_i	.5, 	ihrvbtime

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 530, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           reverb                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"reverb is a basic reverberation unit. Within the opcode an   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"algorithm consisting of four parallel comb filters and two   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"series allpass filters is employed (shown below).            ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Its only obligatory input argument besides the input audio   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"signal is for reverb time in seconds. An optional 2-way      ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"switch defines the initial disposition of the delay loop data", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"(0=cleared, 1=previous data retained).                       ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"It should be bourne in mind that the 'reverb' algorithm      ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"represents quite a basic reverb algorithm and that with      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"transient input audio granularity in the reverb effect       ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"becomes quite evident. (0=no filtering, 1=more filtering)    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"In this example a Dry/Wet Mix crossfader is also implemented.", 	1,      5,     14,    490,    15,     5, 240

ih		 	FLbox  	"          +----+                                             ", 	1,      5,     14,    490,    15,     5,  30+260
ih		 	FLbox  	"       +--|comb|--+                                          ", 	1,      5,     14,    490,    15,     5,  45+260
ih		 	FLbox  	"       |  +----+  |                                          ", 	1,      5,     14,    490,    15,     5,  60+260
ih		 	FLbox  	"       |          |                                          ", 	1,      5,     14,    490,    15,     5,  75+260
ih		 	FLbox  	"       |  +----+  |                                          ", 	1,      5,     14,    490,    15,     5,  90+260
ih		 	FLbox  	"       +--|comb|--+                                          ", 	1,      5,     14,    490,    15,     5, 105+260
ih		 	FLbox  	"       |  +----+  |  +-------+  +-------+                    ", 	1,      5,     14,    490,    15,     5, 120+260
ih		 	FLbox  	" IN-->-+          +--|allpass|--|allpass|-->-OUT             ", 	1,      5,     14,    490,    15,     5, 135+260
ih		 	FLbox  	"       |  +----+  |  +-------+  +-------+                    ", 	1,      5,     14,    490,    15,     5, 150+260
ih		 	FLbox  	"       +--|comb|--+                                          ", 	1,      5,     14,    490,    15,     5, 165+260
ih		 	FLbox  	"       |  +----+  |                                          ", 	1,      5,     14,    490,    15,     5, 180+260
ih		 	FLbox  	"       |          |                                          ", 	1,      5,     14,    490,    15,     5, 195+260
ih		 	FLbox  	"       |  +----+  |                                          ", 	1,      5,     14,    490,    15,     5, 210+260
ih		 	FLbox  	"       +--|comb|--+                                          ", 	1,      5,     14,    490,    15,     5, 225+260
ih		 	FLbox  	"          +----+                                             ", 	1,      5,     14,    490,    15,     5, 240+260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 255+260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 270+260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 285+260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 300+260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 315+260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 330+260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 345+260

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gaSigL	init	0	;SET INITIAL VALUES FOR GLOBAL AUDIO SEND VARIABLES
gaSigR	init	0	;SET INITIAL VALUES FOR GLOBAL AUDIO SEND VARIABLES

	
		instr	1	;FILE PLAYING INSTRUMENT
if gkOnOff!=-1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:	
;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
gaSigL, gaSigR	diskin	"808loop.wav",     1,       0,       1
		endin

		instr	2	;REVERBERATING INSTRUMENT
aRvbL		reverb	gaSigL*.3, gkrvbtime	;CREATE LEFT CHANNEL REVERB
aRvbR		reverb	gaSigR*.3, gkrvbtime	;CREATE RIGHT CHANNEL REVERB
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