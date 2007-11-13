;Written by Iain McCurdy, 2006

;THIS EXAMPLE CREATES AN FLTK SLIDER (CONTROLLING THE FREQUENCY OF AN OSCILLATOR) 
;WHICH CAN ALSO BE CONTROLLED BY MIDI CONTROLLER 1 (MODULATION WHEEL)
;THE APPEARANCE OF THE FLTK SLIDER WILL ALSO BE UPDATED THROUGH THE USE OF THE FLsetVal OPCODE

<CsoundSynthesizer>

<CsOptions>
-+rtaudio=PortAudio -M0 -b4096
</CsOptions>

<CsInstruments>

sr			=		44100
kr			=		4410
ksmps			=		10
nchnls			=		2

;       		OPCODE |    "LABEL"            | WIDTH | HEIGHT | X | Y
			FLpanel	"MIDI & FLTK Combined",   1000,    200,   0,  0

;FLTK SLIDER
;NOTE THAT THE OUTPUT HANDLE VARIABLE  (gihoct) NEEDS TO BE A GLOBAL VARIABLE SO THAT IT IS ACCESSIBLE IN INSTRUMENT 1
;					            		MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X   | Y
gkoct, gihoct		FLslider 	"Pitch (Oct Format)",	6,    12,    0,    5,     -1,    750,     30,   125,  50

;TEXT BOXES
;                                         			                                                     | ITYPE | IFONT | ISIZE | IWIDTH | IHEIGHT | IX | IY
ihCC	 FLbox  "MOVE THE ON SCREEN SLIDER OR MOVE CONTINUOUS CONTROLLER 1 (MODULATION WHEEL) ON YOUR MIDI DEVICE.",     1,      6,      14,    1000,      20,     0,  150
			FLpanel_end
			FLrun

			instr 1
;OUTPUT			OPCODE		CHANNEL | CC.NUMBER | MIN | MAX
koct			ctrl7		1,            1,       6,    12
ktrig			changed		koct	;IF THE VARIABLE 'koct' CHANGES FROM ITS PREVIOUS VALUE,
						;I.E. IF THE MIDI SLIDER IS MOVED THEN THE VARIABLE ktrig WILL ASSUME THE VALUE '1', OTHERWISE IT WILL BE ZERO.
;			OPCODE      |   TRIGGER | VALUE | HANDLE
			FLsetVal	ktrig,     koct,  gihoct
;OUTPUT			OPCODE		AMPLITUDE |   FREQUENCY   | FUNCTION_TABLE
asig			oscili		10000,      cpsoct(gkoct),         1		;CREATE AN OSCILLATOR
			outs		asig, asig
			endin

</CsInstruments>

<CsScore>
f 1 0 129 10 1	;A SINE WAVE                  
i 1 0 3600     	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>