;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

;A SINE WITH OSCILLATOR WITH FL-ROLLER CONTROLLED FREQUENCY

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2

;		OPCODE	LABEL              | WIDTH | HEIGHT | X | Y
		FLpanel	"Frequency Roller",   900,    400,   50, 50

imin		=	200	;MINIMUM VALUE OUTPUT BY THE ROLLER
imax		=	5000	;MAXIMUM VALUE OUTPUT BY THE ROLLER
istep		=	1	;INCREMENT WITH EACH PIXEL
iexp		=	-1	;LOGARITHMIC TYPE ROLLER SELECTED
itype		=	1	;ROLLER GRAPHIC TYPE (1=HORIZONTAL)
idisp		=	-1	;DISPLAY HANDLE (-1=NOT USED)
iwidth		=	300	;WIDTH OF THE ROLLER IN PIXELS
iheight		=	50	;HEIGHT OF THE ROLLER IN PIXELS
ix		=	300	;DISTANCE OF THE LEFT EDGE OF THE KNOB FROM THE LEFT EDGE OF THE PANEL
iy		=	50	;DISTANCE OF THE TOP EDGE OF THE KNOB FROM THE TOP EDGE OF THE PANEL
gkfreq, ihandle	FLroller	"Frequency", imin, imax, istep, iexp, itype, idisp, iwidth, iheight, ix, iy
		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD!

		instr 1
iamp		=	15000
ifn		=	1
asig		oscili	iamp, gkfreq, ifn
		outs	asig, asig
		endin	

</CsInstruments>

<CsScore>
f 1 0 129 10 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>