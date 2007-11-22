;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

;USING THE OPCODE FLvalue TO DISPLAY THE OUTPUT OF A SLIDER 

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2

		FLpanel	"Value Display Box", 900, 200, 50, 50
		
iwidth		=	80	;WIDTH OF THE VALUE DISPLAY BOX IN PIXELS                                            
iheight		=	20	;HEIGHT OF THE VALUE DISPLAY BOX IN PIXELS                                           
ix		=	35	;DISTANCE OF THE LEFT EDGE OF THE VALUE DISPLAY BOX FROM THE LEFT EDGE OF THE PANEL  
iy		=	55	;DISTANCE OF THE TOP EDGE OF THE VALUE DISPLAY BOX FROM THE TOP EDGE OF THE PANEL    
idisp		FLvalue	"Hertz", iwidth, iheight, ix, iy

gkfreq, ihandle	FLslider	"Frequency", 200, 5000, -1, 5, idisp, 750, 30, 125, 50
		FLsetVal_i	500, ihandle
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