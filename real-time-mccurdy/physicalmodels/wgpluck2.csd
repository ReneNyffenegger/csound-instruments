;Written by Iain McCurdy, 2006

;wgpluck2_FLTK.csd
;DEMONSTRATION OF THE wgpluck2 OPCODE WHICH IS AN IMPLEMENTATION OF THE KARPLUS-STRONG PHYSICAL MODEL OF A PLUCKED STRING.
;IT USES SIMPLE MATHEMATICAL PRINCIPLES AND AN IN-BUILT DELAY LINE TO IMITATE THE SOUND OF A STRING BEING PLUCKED.
;THE 'VIRTUAL BASS' VST INSTRUMENT THAT COMES WITH CUBASE IS BASED ON THIS ALGORITHM

;TAKING AN ELECTRIC GUITAR OR BASS GUITAR AS ITS CUE THIS OPCODE OFFERS INPUT PARAMETERS FOR:

;iplk - THE POSITION ALONG THE STRING'S LENGTH AT WHICH IT IS PLUCKED
;	VALUES FOR iplk SHOULD BE GREATER THAT 0 AND LESS THAN 1
;	0 = THE STRING BEING PLUCKED AT THE NUT (NECK), 1 = THE STRING BEING PLUCKED AT THE BRIDGE
;	IN ACTUALITY VALUES OF 0 AND 1 WILL PRODUCE SILENCE
;	VALUES CLOSE TO ZERO OR CLOSE TO 1 WILL PRODUCE A THIN, HARD SOUND (PLUCKED NEAR THE NECK END OR NEAR THE BRIDGE)
;	A VALUE OF .5 WILL PRODUCE A SOFT FLUTEY SOUND (STRING PLUCKED HALFWAY ALONG ITS LENGTH, I.E. 12TH FRET)
;	IF YOU'VE A GUITAR OR ANY STRINGED INSTRUMENT HANDY, TRY IT OUT. 

;kpick - LOCATION OF THE PICK-UP UNDERNEATH THE VIBRATING STRING
;	AGAIN VALUES GREATER THAN 0 AND LESS THAN 1 ARE EXPECTED HERE, 
;	0 MEANING THE PICK-UP IS UNDER THE NUT (NECK END), 1 MEANING IT IS UNDER THE BRIDGE, .5 MEANING UNDER THE 12TH FRET FOR AN OPEN STRING
;	SIMILAR SPECTRAL RESULTS APPLY REGARDING WHETHER THE PICK-UP IS CLOSE TO THE BRIDGE OR HALFWAY ALON THE STRING AND SO ON...
;	THIS PARAMETER CAN BE VARIED AT K-RATE - I.E. THE PICK-UP CAN MOVE DURING A NOTE!
;	MOVING THE PICK-UP DURING A NOTE CAUSES A 'FLANGING' EFFECT

;krefl - COEFFICIENT OF REFLECTION, I.E. AMOUNT OF DAMPING OF THE STRING AT THE BRIDGE
;	IMAGINE DAMPING THE STRING WITH THE HEEL OF YOUR HAND WHILE PLUCKING A STRING.
;	ONCE AGAIN VALUES SHOULD BE GREATER THAN 0 AND LESS THAN 1, DON'T ACTUALLY USE 0 OR 1
;	A VALUE CLOSE TO ZERO REPRESENTS VERY LITTLE DAMPING
;	A VALUE CLOSE TO 1 REPRESENTS A LOT OF DAMPING
;	WHEN USING LARGE AMOUNTS OF DAMPING THE SOUNDING PITCH OF THE PLUCKED STRING CAN DROP SLIGHTLY

;OTHER OPCODES THAT ARE ALSO BASED ON THE SAME KARPLUS-STRONG PLUCKED STRING ALGORITHM ARE pluck AND wgpluck

;THE pluck OPCODE ALSO INCLUDES SOME PHYSICALLY MODELLED DRUM SOUNDS THAT WERE USED BY SOME ANTIQUE DRUM MACHINES

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
		FLpanel	" ",     500,    250,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"Pluck!",	1,    -1,   1,     200,     30,   150, 10,    0,     1,      0,      -1


;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idplk		FLvalue	" ",      100,     18,    0,   80
idpick		FLvalue	" ",     100,     18,    0,  130
idrefl		FLvalue	" ",     100,     18,    0,  180
idcps		FLvalue	" ",     100,     18,    0,  230

;SLIDERS				            				MIN |   MAX   | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X  | Y
gkplk, ihplk			FLslider	"Pluck Position (i-rate)",	0,        1,     0,    5,    idplk,       500,    30,     0,   50
gkpick, ihpick			FLslider	"Pick-up Position (k-rate)",	0,        1,     0,    5,    idpick,      500,    30,     0,   100
gkrefl, ihrefl			FLslider	"Coefficient of Reflection",	.001,  .999,     0,    5,    idrefl,      500,    30,     0,   150
gkcps, ihcps			FLslider	"Pitch in CPS",			20,    3000,    -1,    5,    idcps,       500,    30,     0,   200

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	.98, 	ihplk
		FLsetVal_i	.1, 	ihpick
		FLsetVal_i	.6, 	ihrefl
		FLsetVal_i	100, 	ihcps

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 400, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         wgpluck2                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"wgpluck2 is another physical model implementation of a       ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"plucked string based the Karplus-Strong algorithm.           ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"wgpluck takes as its model an electric guitar or electric    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"bass guitar.                                                 ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Pluck position is a value in the range 0 to 1 representing   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"the fractional position along the string's length at which   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"the string is plucked. (0 and 1 represent the string being   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"plucked at the bridge or the nut, .5 represents the string   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"being pluck exactly halfway along its length.                ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Pick-up position is a value in the range 0 to 1 representing ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"the fractional location of the pick-up along the strings     ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"length. Pick-up position is variable at k-rate.              ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Coefficient of reflection should be a value between 0 and 1  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"(but not actually 0 or 1) and represents the amount of       ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"damping that is applied to the string as it resonates.       ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Pitch in CPS (cycles per second) controls the intended pitch.", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Use of damping causes a slight drop in pitch so retuning may ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"be necessary.                                                   ", 	1,      5,     14,    490,    15,     5, 380

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr		1
iamp	=		10000
apluck 	wgpluck2    	i(gkplk), iamp, i(gkcps), gkpick, gkrefl
	outs 		apluck, apluck
	endin

</CsInstruments>

<CsScore>
f0 3600	;'DUMMY' SCORE EVENT ALLOWS REALTIME MIDI PLAYING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>