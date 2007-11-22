;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
</CsOptions>

<CsInstruments>

;USING FL-BUTTONS TO CREATE ON SCRENN CONTROLS FOR PLAY, STOP, FAST FORWARD AND FAST REWIND OF A SOUND FILE
;THIS EXAMPLE ALSO MAKE USE OF THE PRESET GRAPHIC FOR BUTTONS

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2

;		OPCODE	 LABEL    | WIDTH | HEIGHT | X  | Y
		FLpanel	"Buttons",   320,    120,   100, 100

ion		=	0
ioff		=	0
itype		=	1
iwidth		=	50
iheight		=	50
ix		=	50
iy		=	35
iopcode		=	0
istarttim	=	0
idur		=	-1
;                                                                                                               p4 ;PLAYBACK SPEED
gkplay,ihb1	FLbutton  "@>",      ion,ioff, itype, iwidth, iheight, ix,     iy, iopcode, 1, istarttim, idur,  1 ;NORMAL SPEED FORWARDS
gkstop,ihb2	FLbutton  "@square", ion,ioff, itype, iwidth, iheight, ix+55,  iy, iopcode, 1, istarttim, idur,  0 ;STATIONARY
gkrew,ihb2	FLbutton  "@<<",     ion,ioff, itype, iwidth, iheight, ix+110, iy, iopcode, 1, istarttim, idur, -2 ;DOUBLE SPEED BACKWARDS
gkff,ihb2	FLbutton  "@>>",     ion,ioff, itype, iwidth, iheight, ix+165, iy, iopcode, 1, istarttim, idur,  2 ;DOUBLE SPEED FORWARDS

	FLpanel_end
	FLrun

	instr	1
aL, aR	diskin	"808loop.wav", p4, 0, 1
	outs	aL, aR
	endin
</CsInstruments>

<CsScore>
f 1 0 131072 10 1	; A SINE WAVE
f 0 3600		; RT. PERF. FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>