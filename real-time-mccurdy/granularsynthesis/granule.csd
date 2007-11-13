;Written by Iain McCurdy, 2006

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

;			LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"granule",  500,    700,    0,  0

;SWITCHES					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,  -1,     2,    100,     30,    0,  0,    0,       2,      0,       -1


;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp	  	FLvalue   " ",	65,      20,     0,   80
idratio	  	FLvalue   " ",	65,      20,     0,  130
idgap	  	FLvalue   " ",	65,      20,     0,  180
idgapos	  	FLvalue   " ",	65,      20,     0,  230
idsize	  	FLvalue   " ",	65,      20,     0,  280
idsizeos	FLvalue   " ",	65,      20,     0,  330
idatt	  	FLvalue   " ",	65,      20,     0,  380
iddec	  	FLvalue   " ",	65,      20,     0,  430
idpch1	  	FLvalue   " ",	65,      20,     0,  480
idpch2	  	FLvalue   " ",	65,      20,   250,  480
idpch3	  	FLvalue   " ",	65,      20,     0,  530
idpch4	  	FLvalue   " ",	65,      20,   250,  530
idseedL	  	FLvalue   " ",	65,      20,     0,  580
idseedR	  	FLvalue   " ",	65,      20,   250,  580
idskip	  	FLvalue   " ",	65,      20,     0,  630
idskipos	FLvalue   " ",	65,      20,     0,  680

;SLIDERS					      			MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",    		0,    20000,  0,    5,   idamp,   500,     30,     0,   50
gkratio, ihratio	FLslider	"Playback Ratio (i-rate)",   	.0001,    2,  0,    5,   idratio, 500,     30,     0,  100
gkgap, ihgap		FLslider	"Grain Gap",   			0,        5,  0,    5,   idgap,   500,     30,     0,  150
gkgapos, ihgapos	FLslider	"Grain Gap Offset (i-rate)",	0,      100,  0,    5,   idgapos, 500,     30,     0,  200
gksize, ihsize		FLslider	"Grain Size",			.0001,    1,  0,    5,   idsize,  500,     30,     0,  250
gksizeos, ihsizeos	FLslider	"Grain Size Offset",		0,      100,  0,    5,   idsizeos,500,     30,     0,  300
gkatt, ihatt		FLslider	"Attack",     			0,      100,  0,    5,   idatt,   500,     30,     0,  350
gkdec, ihdec		FLslider	"Decay",  			0,      100,  0,    5,   iddec,   500,     30,     0,  400
gkpch1, ihpch1		FLslider	"Pitch1",  			.5,       2,  0,    5,   idpch1,  250,     30,     0,  450
gkpch2, ihpch2		FLslider	"Pitch2",  			.5,       2,  0,    5,   idpch2,  250,     30,   250,  450
gkpch3, ihpch3		FLslider	"Pitch3",  			.5,       2,  0,    5,   idpch3,  250,     30,     0,  500
gkpch4, ihpch4		FLslider	"Pitch4",  			.5,       2,  0,    5,   idpch4,  250,     30,   250,  500
gkseedL, ihseedL	FLslider	"Seed Value (left)",		0,        1,  0,    5,   idseedL, 250,     30,     0,  550
gkseedR, ihseedR	FLslider	"Seed Value (right)",		0,        1,  0,    5,   idseedR, 250,     30,   250,  550
gkskip, ihskip		FLslider	"Inskip",    			0,        1,  0,    5,   idskip,  500,     30,     0,  600
gkskipos, ihskipos	FLslider	"Inskip Offset",		0,        1,  0,    5,   idskipos,500,     30,     0,  650

;COUNTERS				     			MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkvoices, ihvoices	FLcount  	"Number of Voices", 	1,    128,    1,     16,     1,    150,      30,   100,    0,   -1 
gkptrmode, ihptrmode	FLcount  	"Pointer Mode",      	-1,   1,      1,      2,     2,    125,      30,   250,    0,   -1 
gknumpchs, ihnumpchs	FLcount  	"No. of Pitches",	0,    4,      1,      5,     2,    125,      30,   375,    0,   -1 

; INITIALISATION OF SLIDERS
			FLsetVal_i   	8000, 	ihamp
			FLsetVal_i   	1, 	ihratio
			FLsetVal_i   	.01, 	ihgap
			FLsetVal_i   	50, 	ihgapos
			FLsetVal_i   	.02, 	ihsize
			FLsetVal_i   	30, 	ihsizeos
			FLsetVal_i   	30, 	ihatt
			FLsetVal_i   	30, 	ihdec
			FLsetVal_i   	16, 	ihvoices
			FLsetVal_i   	1, 	ihptrmode
			FLsetVal_i   	1, 	ihnumpchs
			FLsetVal_i   	1, 	ihpch1
			FLsetVal_i   	1, 	ihpch2
			FLsetVal_i   	1, 	ihpch3
			FLsetVal_i   	1, 	ihpch4
			FLsetVal_i   	.4, 	ihseedL
			FLsetVal_i   	.5, 	ihseedR
			FLsetVal_i   	0, 	ihskip
			FLsetVal_i   	0, 	ihskipos

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          granule                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'Granule' is a complex granular synthesis opcode which is    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"good at producing dense granular synthesis textures. Many of ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"'granule's' input arguments operate only at i-rate making it ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"slightly less useful for real-time work.                     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"As a source for granulation 'granule' uses an audio sample   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"stored in a function table. GEN 1 is well suited for this    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"purpose.                                                     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Instead of using a 'time pointer' to define from where grains", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"will begin playback, 'granule' uses a 'Playback Ratio'       ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"(iratio) parameter which defines the rate of the pointer's   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"movement through the function table in relation to the       ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"original, unmodified speed. For example a playback ratio of  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	".5 produces half-speed playback of the file, a ratio of 2    ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"produces double-speed playback and so on. It should also be  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"noted that if using the 'grain gap' parameter (i.e. giving it", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"a value other than zero) then playback will be further       ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"retarded.                                                    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"'Granule' produces granular synthesis textures by creating   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"layers of independent grain streams. The number of grain     ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"streams present is defined by the 'Number of Voices' (ivoice)", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"parameter (range: 1-128). Using a high value for 'Number of  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"Voices' increases the demand on the CPU considerably.        ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"The 'Grain Gap' parameter (kgap) is used to define the time  ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"gap in ms. between grains in a particular grain stream.      ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"'Grain Gap Offset' (igap_os) is used to define the amount of ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"random variation (as a percentage of the value given for     ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"'Grain Gap') that will be applied to the values used for the ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"time gap between grains in the granular synthesis.           ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"The 'Grain Size' parameter (kgsize) is used to define the    ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"size of the grains in ms.                                    ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"'Grain Size Offset' (igsize_os) is used to define the amount ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"of random variation (as a percentage of the value given for  ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"'Grain Size') that will be applied to the values used for the", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"the size of the grains in the granular synthesis.            ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"The shape of the amplitude envelope applied to each grain is ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"is created by defining the duration of of the attack, sustain", 	1,      5,     14,    490,    15,     5, 740
ih		 	FLbox  	"and decay portions of the envelope (ASD envelope). 'Attack'  ", 	1,      5,     14,    490,    15,     5, 760
ih		 	FLbox  	"(iatt) and 'Decay' (idec) are defined as percentages of the  ", 	1,      5,     14,    490,    15,     5, 780
ih		 	FLbox  	"entire duration (i.e. 100%) of the grain as defined by 'Grain", 	1,      5,     14,    490,    15,     5, 800
ih		 	FLbox  	"Size' and 'Grain Size Offset'. The sustain portion of the    ", 	1,      5,     14,    490,    15,     5, 820
ih		 	FLbox  	"envelope will be the durational remainder after the attack   ", 	1,      5,     14,    490,    15,     5, 840
ih		 	FLbox  	"and decay portions have been created. The sum of the values  ", 	1,      5,     14,    490,    15,     5, 860
ih		 	FLbox  	"for 'Attack' and 'Decay' must be less than or equal to 100.  ", 	1,      5,     14,    490,    15,     5, 880
ih		 	FLbox  	"The grain envelope can also be created using a stored        ", 	1,      5,     14,    490,    15,     5, 900
ih		 	FLbox  	"function table. In this case the number of this table should ", 	1,      5,     14,    490,    15,     5, 920
ih		 	FLbox  	"be given using the optional input argument 'ifnenv'. Gen 5 or", 	1,      5,     14,    490,    15,     5, 940
ih		 	FLbox  	"Gen 7 would be good choices for creating this envelope.      ", 	1,      5,     14,    490,    15,     5, 960
ih		 	FLbox  	"The 'Pointer Mode' switch is used to define how the pointer  ", 	1,      5,     14,    490,    15,     5, 980
ih		 	FLbox  	"moves through each grain. It can be though of as a 3-way     ", 	1,      5,     14,    490,    15,     5, 1000
ih		 	FLbox  	"switch. A value of 1 means that the pointer will move forward", 	1,      5,     14,    490,    15,     5, 1020
ih		 	FLbox  	"through each grain, a value of -1 means that the pointer will", 	1,      5,     14,    490,    15,     5, 1040
ih		 	FLbox  	"move backwards through each grain and a value of zero means  ", 	1,      5,     14,    490,    15,     5, 1060
ih		 	FLbox  	"that, grain by grain, the pointer will randomly choose to    ", 	1,      5,     14,    490,    15,     5, 1080
ih		 	FLbox  	"move either forwards or backwards. To be able to clearly hear", 	1,      5,     14,    490,    15,     5, 1100
ih		 	FLbox  	"the effect of this function use large grain sizes in a sparse", 	1,      5,     14,    490,    15,     5, 1120
ih		 	FLbox  	"texture.                                                     ", 	1,      5,     14,    490,    15,     5, 1140
ih		 	FLbox  	"'Granule' is capable of rendering 4 independent              ", 	1,      5,     14,    490,    15,     5, 1160
ih		 	FLbox  	"transpositions. How many trasposition are to be utilised is  ", 	1,      5,     14,    490,    15,     5, 1180
ih		 	FLbox  	"defined by the 'No. of Pitches' (ipshift) parameter. This    ", 	1,      5,     14,    490,    15,     5, 1200
ih		 	FLbox  	"value can be either 0,1,2,3, or 4. A value of zero means that", 	1,      5,     14,    490,    15,     5, 1220
ih		 	FLbox  	"each grain will be randomly transposed in the range -1 to +1 ", 	1,      5,     14,    490,    15,     5, 1240
ih		 	FLbox  	"octave. The transpositions that will be rendered are defined ", 	1,      5,     14,    490,    15,     5, 1260
ih		 	FLbox  	"by the 4 'Pitch' (ipitch#) parameters. (ipitch2 to ipitch4   ", 	1,      5,     14,    490,    15,     5, 1280
ih		 	FLbox  	"are optional arguments.) 'Number of Voices' must be equal to ", 	1,      5,     14,    490,    15,     5, 1300
ih		 	FLbox  	"or greater than 'No. of Pitches'. Transpostions are defined  ", 	1,      5,     14,    490,    15,     5, 1320
ih		 	FLbox  	"as ratios of the original pitch, i.e. 1=no tranposition, .5= ", 	1,      5,     14,    490,    15,     5, 1340
ih		 	FLbox  	"down one octave, 2=up one octave and so on.                  ", 	1,      5,     14,    490,    15,     5, 1360
ih		 	FLbox  	"'Granule' uses its own built-in pseudo-random number         ", 	1,      5,     14,    490,    15,     5, 1380
ih		 	FLbox  	"generator. The seed value used by this pseudo-random number  ", 	1,      5,     14,    490,    15,     5, 1400
ih		 	FLbox  	"generator can be defined using the optional argument iseed.  ", 	1,      5,     14,    490,    15,     5, 1420
ih		 	FLbox  	"In this example two independent 'granule opcodes are used for", 	1,      5,     14,    490,    15,     5, 1440
ih		 	FLbox  	"the left and right channels. The seed values for these two   ", 	1,      5,     14,    490,    15,     5, 1460
ih		 	FLbox  	"opcodes can be set independently (all other input values are ", 	1,      5,     14,    490,    15,     5, 1480
ih		 	FLbox  	"shared. By setting different seed values for the left and    ", 	1,      5,     14,    490,    15,     5, 1500
ih		 	FLbox  	"right channels, broad stereo effects can be created.         ", 	1,      5,     14,    490,    15,     5, 1520
ih		 	FLbox  	"'Inskip' is used to define from where the opcode will begin  ", 	1,      5,     14,    490,    15,     5, 1540
ih		 	FLbox  	"reading grains. When addressing the input argument 'igskip'  ", 	1,      5,     14,    490,    15,     5, 1560
ih		 	FLbox  	"directly this is defined in seconds. In this example the code", 	1,      5,     14,    490,    15,     5, 1580
ih		 	FLbox  	"interrogates the source sample's function table for its      ", 	1,      5,     14,    490,    15,     5, 1600
ih		 	FLbox  	"duration and the 'Inskip' slider functions as a 'ratio of the", 	1,      5,     14,    490,    15,     5, 1620
ih		 	FLbox  	"entire source sample' control. Giving 'Inskip' a value of    ", 	1,      5,     14,    490,    15,     5, 1640
ih		 	FLbox  	"zero will result in grains being initially read from the     ", 	1,      5,     14,    490,    15,     5, 1660
ih		 	FLbox  	"beginning of the source sound file, giving 'Inskip' a value  ", 	1,      5,     14,    490,    15,     5, 1680
ih		 	FLbox  	"of 0.5 will cause result in grains being initially read from ", 	1,      5,     14,    490,    15,     5, 1700
ih		 	FLbox  	"the middle of the source sound file.                         ", 	1,      5,     14,    490,    15,     5, 1720
ih		 	FLbox  	"'Inskip Offset' introduces a random offset into the 'Inskip' ", 	1,      5,     14,    490,    15,     5, 1740
ih		 	FLbox  	"(igskip) parameter. This can be used to prevent an amplitude ", 	1,      5,     14,    490,    15,     5, 1760
ih		 	FLbox  	"spike when 'Number of when Voices' is a high number and all  ", 	1,      5,     14,    490,    15,     5, 1780
ih		 	FLbox  	"of the pitch streams begin at the same time with the         ", 	1,      5,     14,    490,    15,     5, 1800
ih		 	FLbox  	"identical grains.                                            ", 	1,      5,     14,    490,    15,     5, 1820

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr	1	;(ALWAYS ON - SEE SCORE) PLAYS FILE AND SENSES FADER MOVEMENT AND RESTARTS INSTR 2 FOR I-RATE CONTROLLERS
kSwitch		changed	gkvoices, gkptrmode, gknumpchs, gkskip, gkskipos, gkpch1, gkpch2, gkpch3, gkpch4, gkatt, gkdec, gkratio, gkgapos, gksizeos, gkseedL, gkseedR
;				TRIGGER  | MINTIM | MAXNUM | INSNUM | WHEN | DUR (-1 MEANS A NOTE OF INFINITE DURATION)
		schedkwhen	kSwitch,     0,       0,        2,     0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
	endin
	
	instr	2
if gkOnOff!	=	-1	kgoto		CONTINUE	;SENSE FLTK ON/OFF SWITCH
		turnoff				;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:

ivoices 	= 	i(gkvoices)
iratio 		= 	i(gkratio)
iptrmode 	= 	i(gkptrmode)
ithd 		= 	0
ifn 		= 	1
inumpchs 	= 	i(gknumpchs)
ilen		=	nsamp(ifn)/sr
iskip 		= 	i(gkskip)*ilen
ilen		=	nsamp(ifn)/sr
kskipos 	= 	gkskipos*ilen
iskipos 	= 	i(kskipos)
igapos 		= 	i(gkgapos)
isizeos 	= 	i(gksizeos)
iatt 		= 	i(gkatt)
idec 		= 	i(gkdec)
iseedL 		= 	i(gkseedL)
iseedR 		= 	i(gkseedR)
ipch1 		= 	i(gkpch1)
ipch2 		= 	i(gkpch2)
ipch3 		= 	i(gkpch3)
ipch4 		= 	i(gkpch4)

aSignalL      	granule    	gkamp, ivoices, iratio, iptrmode, ithd, ifn, inumpchs, iskip, iskipos, ilen, gkgap, igapos, gksize, isizeos, iatt, idec, iseedL, ipch1, ipch2, ipch3, ipch4
aSignalR      	granule    	gkamp, ivoices, iratio, iptrmode, ithd, ifn, inumpchs, iskip, iskipos, ilen, gkgap, igapos, gksize, isizeos, iatt, idec, iseedR, ipch1, ipch2, ipch3, ipch4
		outs 		aSignalL, aSignalR
	
		endin

</CsInstruments>

<CsScore>
; THE SOUND FILE USED IN THE GRANULATION
; NUM | INIT_TIME | SIZE | GEN_ROUTINE |   FILE_PATH    | IN_SKIP | FORMAT | CHANNEL
f 1        0      524288        1       "AndItsAll.wav"      0         4        1

i 1 0 3600		;INSTRUMENT 1 PLAYS FOR 1 HOUR (ALSO KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>