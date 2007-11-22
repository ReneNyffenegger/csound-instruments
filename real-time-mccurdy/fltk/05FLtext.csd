;Written by Iain McCurdy, 2006

<CsoundSynthesizer>
-+rtaudio=PortAudio -b4096
<CsOptions>

</CsOptions>

<CsInstruments>

;A SINE WITH OSCILLATOR WITH FL-TEXT BOX CONTROLLED FREQUENCY
;EITHER CLICK AND DRAG OR DOUBLE CLICK AND TYPE TO CHANGE FREQUENCY VALUE

sr		=	44100
kr		=	4410
ksmps		=	10
nchnls		=	2

;		OPCODE	LABEL               | WIDTH | HEIGHT | X | Y
		FLpanel	"Frequency Text Box",  260,    630,   50, 50

imin		=	20	;MINIMUM VALUE OUTPUT BY THE TEXT BOX
imax		=	5000	;MAXIMUM VALUE OUTPUT BY THE TEXT BOX
istep		=	1	;STEP SIZE
itype		=	1	;TEXT BOX GRAPHIC TYPE
iwidth		=	70	;WIDTH OF THE TEXT BOX IN PIXELS
iheight		=	30	;HEIGHT OF THE TEXT BOX IN PIXELS
ix		=	100	;DISTANCE OF THE LEFT EDGE OF THE TEXT BOX FROM THE LEFT EDGE OF THE PANEL
iy		=	270	;DISTANCE OF THE TOP EDGE OF THE TEXT BOX FROM THE TOP EDGE OF THE PANEL
gkfreq,ihandle	FLtext		"Frequency", imin, imax, istep, itype, iwidth, iheight, ix, iy

;SET INITIAL VALUE OF THE TEXT BOX (FLtext) DOESN'T SEEM TO WORK CORRECTLY UNLESS YOU DO THIS
		FLsetVal_i	200, ihandle

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
f 1 0 1024 10 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>