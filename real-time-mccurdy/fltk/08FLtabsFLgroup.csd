;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

;A SINGLE OSCILLATOR WITH FREQUENCY, AMPLITUDE AND PANNING CONTROLS ON SEPARATE TAB CARDS

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2

;		OPCODE	 LABEL | WIDTH | HEIGHT | X | Y
		FLpanel	"Tabs",   300,    350,   100, 100
	
itabswidth	=	280	
itabsheight	=	330
ix		=	5
iy		=	5
	FLtabs	itabswidth,itabsheight, ix,iy

itab1width	=	280	
itab1height	=	300
itab1x		=	10
itab1y		=	40
		FLgroup	"Tab 1", itab1width, itab1height, itab1x, itab1y
gkfreq,i1	FLknob	"Frequency", 200, 5000, -1, 1, -1, 70, 70, 130, 20
		FLsetVal_i	400, i1
		FLgroupEnd

itab2width	=	280	
itab2height	=	300
itab2x		=	10
itab2y		=	40
		FLgroup	"Tab 2", itab2width, itab2height, itab2x, itab2y
gkamp,i2	FLknob	"Amplitude", 0, 15000, 0, 1, -1, 70, 70, 130, 20
		FLsetVal_i	15000, i2
		FLgroupEnd

itab3width	=	280	
itab3height	=	300
itab3x		=	10
itab3y		=	40
		FLgroup	"Tab 3", itab3width, itab3height, itab3x, itab3y
gkpan,i3	FLknob	"Pan position", 0, 1, 0, 1, -1, 70, 70, 130, 20
		FLsetVal_i	.5, i3
		FLgroupEnd

		FLtabsEnd
		FLpanelEnd
		FLrun		;RUN THE WIDGET THREAD

		instr 1
ifn		=	1
asig		oscili	gkamp, gkfreq, ifn
		outs	asig*(1-gkpan), asig*gkpan
		endin	

</CsInstruments>

<CsScore>
f 1 0 1024 10 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>