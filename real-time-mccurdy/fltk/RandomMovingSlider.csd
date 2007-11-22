;Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
</CsOptions>

<CsInstruments>

sr			=	44100
kr			=	4410
ksmps			=	10
nchnls			=	1

			FLpanel	"Randomly Moving Slider", 500, 250, 0, 0

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idFreq				FLvalue	" ",     50,      18,    0, 180

;SLIDER					        				MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkslider,gihslider	FLslider 	" ",					0,     1,    0,    5,        -1,    500,     30,    0,    30                             
gkMin,	ihMin		FLslider 	" ",					0,     1,    0,    3,        -1,    500,     15,    0,   100
gkMax,	ihMax		FLslider 	"Range",				0,     1,    0,    3,        -1,    500,     15,    0,   115
gkFreq,	ihFreq		FLslider 	"Freq",					.001, 10,    0,    3,    idFreq,    500,     30,    0,   150
gki_h,	ihi_h		FLslider 	"Interpolating <-> Sample and Hold",	0,     1,    0,    3,        -1,    500,     30,    0,   200

			FLsetVal_i   	0, 	ihMin	
			FLsetVal_i   	1, 	ihMax	
			FLsetVal_i   	2, 	ihFreq	

			FLpanel_end
			FLrun
			
			instr 1
kslideri		randomi		gkMin, gkMax, gkFreq		;GENERATE INTERPOLATING RANDOM VALUES
ksliderh		randomh		gkMin, gkMax, gkFreq		;GENERATE SAMPLE AND HOLD TYPE RANDOM VALUES
kslider			ntrpol		kslideri, ksliderh, gki_h   	;CROSSFADE BETWEEN INTERPOLATING AND SAMPLE AND HOLD TYPE RANDOM VALUES
ktrig			changed		kslider   			;CREATE A TRIGGER (MOMENTARY 1 VALUE) EACH TIME kx CHANGES
			FLsetVal	ktrig, kslider, gihslider  	;SEND VALUE kslider TO FLTK SLIDER
			endin


</CsInstruments>

<CsScore>
i 1 0 3600     	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>