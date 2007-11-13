;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

;USING THE FLsetVal_i OPCODE TO DEFINE THE INITIAL OUTPUT VALUE AND GRAPHIC POSITION OF AN FL-SLIDER 

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2

;		OPCODE	 LABEL                     | WIDTH | HEIGHT | X | Y
		FLpanel	"Set Slider Initial Value",   900,    400,   50, 50

gkfreq,ihandle	FLslider	"Frequency", 200, 5000, -1, 3, -1, 750, 30, 125, 50

initval	=		500	;INITIAL VALUE FOR SLIDER
		FLsetVal_i	initval, ihandle

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD

		instr 1
iamp		=	15000
ifn		=	1
asig		oscili	iamp, gkfreq, ifn
		outs	asig, asig
		endin

</CsInstruments>

<CsScore>
f 1 0 1024 10 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>