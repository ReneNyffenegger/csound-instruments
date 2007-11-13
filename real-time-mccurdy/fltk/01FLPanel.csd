;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -b4096
</CsOptions>

<CsInstruments>

;CREATES AN EMPTY WINDOW PANEL

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	1

;MOST FLTK CODE IS PLACED IN INSTR 0 - I.E. JUST AFTER THE ORCHESTRA HEADER STATEMENTS  

ipanelheight	=	900	;PANEL HEIGHT IN PIXELS
ipanelwidth	=	400	;PANEL WIDTH IN PIXELS
ix		=	50	;HORIZONTAL POSITION OF THE PANEL ON SCREEN IN PIXELS
iy		=	50	;VERTICAL POSITION OF THE PANEL ON SCREEN IN PIXELS
		FLpanel	"A Window Panel", ipanelheight, ipanelwidth, ix, iy
		FLpanelEnd	;END OF PANEL CONTENTS
	
		FLrun		;RUN THE WIDGET THREAD

		instr	1
		endin

</CsInstruments>

<CsScore>

f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PERFORMANCE FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>