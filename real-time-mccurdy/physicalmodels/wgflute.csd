;Written by Iain McCurdy, 2006

;DEMONSTRATION OF THE wgflute OPCODE WHICH IS BASED ON PERRY COOK'S PHYSICAL MODEL OF A FLUTE

;THIS OPCODE OFFERS A LOT OF INPUT PARAMETERS

;kamp - AMPLITUDE

;kfreq - THE FUNDEMENTAL OF THE TONE PRODUCED

;KJET - A PARAMETER CONTROLLING THE AIR JET. VALUES SHOULD BE POSITIVE, AND ABOUT 0.3. THE USEFUL RANGE IS APPROXIMATELY 0.08 TO 0.56
;LOW SETTINGS FOR KJET FORCE OVERTONES FROM THE INSTRUMENT
;THIS IS PROBABLY THE MOST INSTERESTING PARAMETER IN THIS OPCODE

;iatt/idek - ATTACK AND DECAY TIMES APPARENTLY BUT THEY DON'T SEEM TO DO ANYTHING AT ALL AS FAR AS I CAN SEE!

;kngain - AMPLITUDE OF BREATH/WIND NOISE. THE FLUTE SOUND CONSISTS OF 2 MAIN ELEMENTS:
;	THE RESONANT TONE AND THE BREATH NOISE. 
;	THIS PARAMETER CONTROLS THE STRENGTH OF THE BREATH/WIND NOISE.
;	A USEFUL RANGE FOR THIS IS ABOUT 0-1
;	0=NO BREATH NOISE, 1=BREATH NOISE ONLY

;kvibf/kvibamp - THIS OPCODE IMPLEMENTS VIBRATO THAT GOES BEYOND JUST FREQUENCY MODULATION AND INCLUDES MODULATION 
;	-UPON SEVERAL OTHER ASPECTS OF THE SOUND INCLUDING AMPLITUDE MODULATION
;	A USEFUL RANGE FOR kvibamp (AMPLITUDE OF VIBRATO) IS 0-.25 WHERE 0=NO VIBRATO AND .25=A LOT OF VIBRATO
;	kvibf IS USED TO CONTROL VIBRATO FREQUENCY, A NATURAL VIBRATO FREQUENCY IS ABOUT 5 HZ

;ifn - A FUNCTION TABLE WAVEFORM MUST BE GIVEN TO DEFINE THE SHAPE OF THE VIBRATO, 
;	-THIS SHOULD NORMALLY BE A SINE WAVE.

;THE OPCODE OFFERS 3 FURTHER *OPTIONAL* PARAMETERS:

;iminfreq - A MINIMUM FREQUENCY SETTING GIVEN TO THE ALGORITHM
;	- TYPICALLY THIS IS SET TO A VALUE BELOW THE FREQUENCY SETTING GIVEN BY kfreq
;	- IF kfreq GOES BELOW iminfreq IS CAN HAVE A STRANGE EFFECT ON THE SOUND AND THE SETTING FOR kfreq NO LONGER 
;	-REFLECTS THE PITCH THAT IS ACTUALLY HEARD.

;ijetrf - AMOUNT OF REFLECTION OF THE BREATH JET. I.E. RESISTANCE OF THE AIR COLUMN ON THE FLUTE (I-RATE ONLY)

;iendrf - BREATH JET REFLECTION COEFFICIENT (I-RATE ONLY) THIS CONTROLS HOW THE BREATH JET INTERACTS WITH THE RESONANT SOUND
;	- 0=BREATH JET DOMINATES 1=RESONANCE DOMINATES

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

		FLcolor		-2	;RANDOMLY COLOURIZE THE INTERFACE
		FLcolor2	-2	;RANDOMLY COLOURIZE THE INTERFACE

;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"wgflute", 500,    600,    0,  0

;BUTTONS                              		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,   -1,     2,    200,     30,    0,  0,    0,      2,      0,       -1

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      100,    18,     0,   80
idfreq		FLvalue	" ",      100,    18,     0,  130
idjet		FLvalue	" ",      100,    18,     0,  180
idatt		FLvalue	" ",      100,    18,     0,  230
iddek		FLvalue	" ",      100,    18,     0,  280
idngain		FLvalue	" ",      100,    18,     0,  330
idvibf		FLvalue	" ",      100,    18,     0,  380
idvibamp	FLvalue	" ",      100,    18,     0,  430
idminfreq	FLvalue	" ",      100,    18,     0,  480
idjetrf		FLvalue	" ",      100,    18,     0,  530
idendrf		FLvalue	" ",      100,    18,     0,  580

;SLIDERS				            						MIN |   MAX  | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",					0,    30000,    0,    5,     idamp,     500,     30,    0,   50
gkfreq, ihfreq			FLslider	"Frequency",					20,   20000,   -1,    5,     idfreq,    500,     30,    0,  100
gkjet, ihjet			FLslider	"Air Jet",					.08,    .56,    0,    5,     idjet,     500,     30,    0,  150
gkatt, ihatt			FLslider	"Attack Time (i-rate in seconds)",		0,    	  1,    0,    5,     idatt,     500,     30,    0,  200
gkdek,ihdek			FLslider 	"Decay Time (i-rate in seconds)",  		0,        1,    0,    5,     iddek,     500,     30,    0,  250
gkngain,ihngain			FLslider 	"Amplitude of Breath Noise",  			0,        1,    0,    5,     idngain,   500,     30,    0,  300
gkvibf,ihvibf			FLslider 	"Vibrato Frequency",  				0,       30,    0,    5,     idvibf,    500,     30,    0,  350
gkvibamp,ihvibamp		FLslider 	"Vibrato Amplitude",  				0,       .3,    0,    5,     idvibamp,  500,     30,    0,  400
gkminfreq,ihminfreq		FLslider 	"Minimum Frequency (i-rate)",			20,   20000,   -1,    5,     idminfreq, 500,     30,    0,  450
gkjetrf,ihjetrf			FLslider 	"Amount of Reflection of Breath Jet (i-rate)",	0,        1,    0,    5,     idjetrf,   500,     30,    0,  500
gkendrf,ihendrf			FLslider 	"Breath Jet Reflection Coefficient (i-rate)",	0,        1,    0,    5,     idendrf,   500,     30,    0,  550

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	10000, 	ihamp
		FLsetVal_i	750, 	ihfreq
		FLsetVal_i	.3, 	ihjet
		FLsetVal_i	.1, 	ihatt
		FLsetVal_i	.1, 	ihdek
		FLsetVal_i	.1, 	ihngain
		FLsetVal_i	5, 	ihvibf
		FLsetVal_i	.1, 	ihvibamp
		FLsetVal_i	20, 	ihminfreq
		FLsetVal_i	.5, 	ihjetrf
		FLsetVal_i	.5, 	ihendrf
		FLsetVal_i	-1, 	ihOnOff

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         wgflute                             ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"wgflute is a wave guide physical model of a flute based on   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"work by Perry Cook but re-coded for Csound by John ffitch.   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Attack time is the time taken to reach full blowing pressure.", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The author suggests that 0.1 corresponds to normal playing.  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Decay time is the time taken for the system to stop producing", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"sound after blowing has stopped. The author suggests that 0.1", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"produces a smooth natural sounding end to a note.            ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Air jet defines the strength of the air jet blown into the   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"flute and therefore controls the playing of overtones.       ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Values for air jet should be positive and the useful range is", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"approximately 0.08 to 0.56. The author suggests a value of   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"0.3 as representing an air jet of typical strength.          ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Amplitude of breath noise controls the amount of simulated   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"wind noise in the composite tone produced. The suggested     ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"range is 0 to 0.5.                                           ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Vibrato is implemented within the opcode and does not need to", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"be applied separately to the frequency parameter. Natural    ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"vibrato occurs at about 5 hertz.                             ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Minimum frequency (optional) defines the lowest frequency at ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"which the model will play.                                   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"Amount of Reflection of Breath Jet (optional, default=0.5)   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"defines the amount of reflection in the breath jet that.     ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"powers the flute.                                            ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"Breath Jet Reflection Coefficient (optional, default=0.5) is ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"used in conjunction with the Amount of Reflection of Breath  ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"Jet in the calculation of the pressure differential.         ", 	1,      5,     14,    490,    15,     5, 480

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr		1	;(ALWAYS ON - SEE SCORE) SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed		gkminfreq, gkjetrf, gkendrf, gkatt, gkdek
if		gkOnOff!=1	kgoto	SKIP
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,       0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
SKIP:
		endin

		instr		2
; SENSE FLTK ON/OFF SWITCH
if		gkOnOff!=-1	kgoto	CONTINUE
turnoff
CONTINUE:

ifn		=	1	;WAVEFORM FUNCTION TABLE FOR THE SHAPE OF THE VIBRATO - SHOULD NORMALLY JUST BE A SINE WAVE OR SOMETHING SIMILAR
;AN AUDIO SIGNAL IS CREATED USING THE wgflute OPCODE. NOTE THAT I-RATE VARIABLES MUST BE CONVERTED TO I-RATE FROM K-RATE SLIDERS
aflute		wgflute	gkamp, gkfreq, gkjet, i(gkatt), i(gkdek), gkngain, gkvibf, gkvibamp, ifn, i(gkminfreq), i(gkjetrf), i(gkendrf)
		outs 	aflute, aflute
		endin
</CsInstruments>

<CsScore>
f 1 0 131072 10 1	;SINE WAVE (USED FOR VIBRATO)
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>
</CsoundSynthesizer>