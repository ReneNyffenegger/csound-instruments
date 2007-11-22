;Written by Iain McCurdy, 2006

;DEMONSTRATION OF THE wgbow OPCODE. THIS IS A PHYSICALLY MODELLED BOWED STRING INSTRUMENT BASED ON WORK BY PERRY COOK

;kamp - AMPLITUDE

;kfreq - THE FUNDEMENTAL OF THE TONE PRODUCED

;kpres - PRESSURE OF THE BOW UPON THE STRING
;	THE OPCODE AUTHOR, JOHN FFITCH, SUGGESTS THAT WE CHOOSE VALUES WITHIN THE RANGE 1 to 5
;	HE ALSO SUGGESTS THAT A VALUE OF 3 REFLECTS NORMAL PLAYING PRESSURE

;krat - POSITION OF THE BOW ALONG THE LENGTH OF THE STRING
;	THE OPCODE AUTHOR SUGGESTS THAT WE CHOOSE VALUES WITHIN THE RANGE .025 to 0.23
;	HE ALSO SUGGESTS THAT A VALUE OF .127236 REFLECTS A NORMAL BOWING POSITION
;	STRING EFFECTS SUCH AS 'SUL PONTICELLO' (AT THE BRIDGE) AND 'FLAUTANDO' (OVER THE NECK) CAN BE IMITATED USING THIS PARAMETER
;	A VALUE OF .025 REFLECTS A 'SUL PONTICELLO' STYLE OF PLAYING AND PRODUCES A THINNER TONE
;	A VALUE OF .23 REFLECTS A 'FLAUTANDO' STYLE OF PLAYING AND PRODUCES A FLUTE-LIKE TONE
;	THESE SUGGESTED SETTINGS FOR krat ARE BASED UPON A CONVENTIONAL PLAYING TECHNIQUE OF A BOWED INSTRUMENT.
;	IF VALUES ARE CHOSEN BEYOND THESE LIMITS OTHER UNCONVENTIONAL SOUNDS ARE POSSIBLE.
;	0 = THE STRING BEING BOWED AT THE NUT (NECK), 1 = THE STRING BEING BOWED AT THE BRIDGE
;	IN ACTUALITY VALUES OF 0 AND 1 WILL PRODUCE SILENCE
;	VALUES CLOSE TO ZERO OR CLOSE TO 1 WILL PRODUCE A THIN, HARD SOUND (BOWED NEAR THE NECK END OR NEAR THE BRIDGE)
;	A VALUE OF .5 WILL PRODUCE A SOFT FLUTEY SOUND (STRING BOWED HALFWAY ALONG ITS LENGTH)

;kvibf/kvibamp - THIS OPCODE IMPLEMENTS VIBRATO THAT GOES BEYOND JUST FREQUENCY MODULATION AND INCLUDES MODULATION 
;	-UPON SEVERAL OTHER ASPECTS OF THE SOUND INCLUDING AMPLITUDE MODULATION
;	A USEFUL RANGE FOR kvibamp (AMPLITUDE OF VIBRATO) IS 0-.1 WHERE 0=NO VIBRATO AND .1=A LOT OF VIBRATO
;	kvibf IS USED TO CONTROL VIBRATO FREQUENCY, A NATURAL VIBRATYO FREQUENCY IS ABOUT 5 HZ

;ifn - A FUNCTION TABLE WAVEFORM MUST BE GIVEN TO DEFINE THE SHAPE OF THE VIBRATO, 
;	-THIS SHOULD NORMALLY BE A SINE WAVE.

;THE OPCODE OFFERS 1 FURTHER *OPTIONAL* PARAMETER:

;iminfreq - A MINIMUM FREQUENCY SETTING GIVEN TO THE ALGORITHM
;	- TYPICALLY THIS IS SET TO A VALUE BELOW THE FREQUENCY SETTING GIVEN BY kfreq (IF OMITTED IT DEFAULTS TO 50HZ)
;	- IF kfreq GOES BELOW iminfreq THE SETTING FOR kfreq NO LONGER REFLECTS THE PITCH THAT IS ACTUALLY HEARD.

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

;			LABEL | WIDTH | HEIGHT | X | Y
		FLpanel	"wgbow", 500,    400,    0   0

;BUTTONS                              	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"Bow",	1,   -1,     2,    200,     30,    0,  0,    0,      2,      0,      -1

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      100,     18,    0,   80
idfreq		FLvalue	" ",      100,     18,    0,  130
idpres		FLvalue	" ",      100,     18,    0,  180
idrat		FLvalue	" ",      100,     18,    0,  230
idvibf		FLvalue	" ",      100,     18,    0,  280
idvibamp	FLvalue	" ",      100,     18,    0,  330
idminfreq	FLvalue	" ",      100,     18,    0,  380

;SLIDERS				            						MIN |   MAX   | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",					0,    30000,     0,    5,    idamp,      500,     30,    0,   50
gkfreq, ihfreq			FLslider	"Frequency",					20,   20000,    -1,    5,    idfreq,     500,     30,    0,  100
gkpres, ihpres			FLslider	"Bow Pressure",					1,        5,     0,    5,    idpres,     500,     30,    0,  150
gkrat, ihrat			FLslider	"Bow Position",					.006,  .988,     0,    5,    idrat,      500,     30,    0,  200
gkvibf,ihvibf			FLslider 	"Vibrato Frequency",  				0,       30,     0,    5,    idvibf,     500,     30,    0,  250
gkvibamp,ihvibamp		FLslider 	"Vibrato Amplitude",  				0,       .1,     0,    5,    idvibamp,   500,     30,    0,  300
gkminfreq,ihminfreq		FLslider 	"Minimum Frequency (i-rate and optional)",	20,   20000,    -1,    5,    idminfreq,  500,     30,    0,  350

;SET INITIAL VALUES FOR SLIDERS
		FLsetVal_i	10000, 	ihamp
		FLsetVal_i	170, 	ihfreq
		FLsetVal_i	3, 	ihpres
		FLsetVal_i	.127236,ihrat
		FLsetVal_i	4.5, 	ihvibf
		FLsetVal_i	.008, 	ihvibamp
		FLsetVal_i	20, 	ihminfreq

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           wgbow                             ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"wgbow is a wave guide physical model of a bowed string based ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"on work by Perry Cook but re-coded for Csound by John ffitch.", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Bow pressure represents the downward pressure of the bow upon", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"the string and should be a value between 1 and 5. The author ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"suggests a value of about 3 to represent normal bow pressure.", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Bow position represents the position of the bow along the    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"length of the string.                                        ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Bow position represents the position of the bow along the    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"length of the string. The opcode author suggests that we     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"choose values within the range .025 to 0.23. He also suggests", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"that a value of .127236 reflects a normal bowing position.   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"String effects such as 'sul ponticello' (at the bridge) and  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'flautando' (over the neck) can be imitated using this       ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"parameter. A value of .025 reflects a 'sul ponticello' style ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"of playing and produces a thinner tone. A value of .23       ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"reflects a 'flautando' style of playing and produces a flute-", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"-like tone.                                                  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Vibrato is implemented within the opcode and does not need to", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"be applied separately to the frequency parameter. Vibrato is ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"implemented so that it only takes effect after a short time  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"delay. This time delay is retriggered if bow position is     ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"changed during note performance.                             ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"Minimum frequency (optional) defines the lowest frequency at ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"which the model will play.                                   ", 	1,      5,     14,    490,    15,     5, 480

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr	1	;(ALWAYS ON - SEE SCORE) SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed		gkminfreq
;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,       0,       0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
	endin

	instr	2
if	gkOnOff!=-1	goto	CONTINUE ; SENSE FLTK ON/OFF SWITCH
			turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
CONTINUE:
ifn		=	1	;WAVEFORM FUNCTION TABLE FOR THE SHAPE OF THE VIBRATO - SHOULD NORMALLY JUST BE A SINE WAVE OR SOMETHING SIMILAR
abow	wgbow	gkamp, gkfreq, gkpres, gkrat, gkvibf, gkvibamp, ifn, i(gkminfreq)
	outs 	abow, abow
	endin

</CsInstruments>

<CsScore>
f1 0 4096 10 1	;SINE WAVE (USED FOR VIBRATO)
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>