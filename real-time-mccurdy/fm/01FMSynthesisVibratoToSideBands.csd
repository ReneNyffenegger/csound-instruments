;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	2


	FLpanel	"FM Synthesis: Vibrato to Side Bands", 500, 200, 0, 0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"Play Example",		1,  -1,     1,    300,     50,   100, 20,    0,      1,      0,      35

;						 				MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkVibratoDepth, gihVibratoDepth		FLtext		"Vibrato Depth (Hz.)", 	0,   2000,    0,     1,   100,     20,      50, 105
gkVibratoFreq, gihVibratoFreq		FLtext		"Vibrato Rate (Hz.)", 	0,   2000,    0,     1,   100,     20,     350, 105

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 440, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          FM Synthesis: Vibrato to Side Bands                ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example demonstrates the phenomenon of side bands upon  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"which FM (frequency modulation) synthesis relies.            ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"A vibrato function is applied to the frequency control of an ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"oscillator. Gradually the amplitude (depth) and the frequency", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"(speed/rate) of the vibrato are increased.                   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"The amplitude (depth) of the vibrato moves from a value of   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	".001 to a final value of 1000. These amplitude values will be", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"added to the frequency of the oscillator. The frequency      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"(speed/rate) of the value rises from a value of 2 Hz to a    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"final value of 413 Hz.                                       ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"At the beginning of the transformation vibrato is heard but  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"as the frequency (speed/rate) of the vibrato increases we    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"lose the ability to perceive individual pitch fluctuations   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"and instead side bands (additional spectral artefacts) emerge", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"As the frequency of the vibrato function continues to        ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"increase the nature of the spectrum of the new sound         ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"is continually evolving.                                     ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"As the amplitude of the vibrato function increases beyond the", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"stage where we were still able to perceive vibrato the       ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"intensity of the sidebands and therefore the brightness of   ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"the new timbre increases.                                    ", 	1,      5,     14,    490,    15,     5, 420

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	instr 1
ifreq 	= 	300	;FREQUENCY OF THE CARRIER
ifn 	= 	1	;FUNCTION TABLE NUMBER (FOR BOTH VIBRATO AND AUDIO SIGNAL - BOTH ARE SINE WAVES)

;VIBRATO DEPTH - GRADUALLY INCREASES - WHEN VIBRATO FREQUENCY IS HIGH (MORE THAN ABOUT 15 Hz), INCREASES IN VIBRATO DEPTH ARE PERCEIVED AS INCREASES IN THE STRENGTH AND NUMBERS OF THE SIDE BANDS, I.E. SPECTRAL RICHNESS/BRIGHTNESS OF THE TIMBRE
kVibratoDepth	expseg	.001, (4), 30, (8), 1000, (25), 1000

;VIBRATO FREQUENCY - GRADUALLY BUILDS, EVENTUALLY WE ARE NO LONGER ABLE TO PERCEIVE THE PITCH FLUCTUATIONS BUT INSTEAD HEAR 'SIDE BANDS'
kVibratoFreq	expseg	2, (9), 7, (8), 350, (20), 1000

;THE MODULATOR WAVEFORM IS CREATED
aVibrato	oscili	kVibratoDepth, kVibratoFreq, ifn 

;THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM (aModulator) IS ADDED TO THE FREQUENCY OF THE CARRIER WAVEFORM 
aSignal		oscili	20000, ifreq + aVibrato, ifn 
	  	outs 	aSignal, aSignal
ktrig	  	metro	10	;CREATE A REPEATING TRIGGER SIGNAL
		FLsetVal 	ktrig, kVibratoDepth, gihVibratoDepth	;UPDATE VALUE BOX 'gihVibratoDepth' WITH THE VALUE kVibratoDepth WHENEVER A TRIGGER PULSE IS RECEIVED
		FLsetVal 	ktrig, kVibratoFreq, gihVibratoFreq	;UPDATE VALUE BOX 'gihVibratoFreq' WITH THE VALUE kVibratoFreq WHENEVER A TRIGGER PULSE IS RECEIVED
		endin
	
</CsInstruments>


<CsScore>
f 1 0 129 10 1	;A SINE WAVE (INTERPOLATING OSCILLATOR OPCODES ARE USED THEREFORE A SMALL TABLE SIZE (+1) CAN BE USED)
f 0 3600		;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR

</CsScore>


</CsoundSynthesizer>



























