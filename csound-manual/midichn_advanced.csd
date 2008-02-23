<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in   No messages  MIDI in
-odac           -iadc     -d         -M0  ;;;RT audio I/O with MIDI in
; For Non-realtime ouput leave only the line below:
; -o midichn_advanced.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr	=  44100
ksmps	=  10
nchnls	=  1

	massign  1, 1		; all channels use instr 1
	massign  2, 1
	massign  3, 1
	massign  4, 1
	massign  5, 1
	massign  6, 1
	massign  7, 1
	massign  8, 1
	massign  9, 1
	massign 10, 1
	massign 11, 1
	massign 12, 1
	massign 13, 1
	massign 14, 1
	massign 15, 1
	massign 16, 1

gicnt	=  0			; note counter

	instr 1

gicnt	=  gicnt + 1	; update note counter
kcnt	init gicnt	; copy to local variable
ichn	midichn		; get channel number
istime	times		; note-on time

	if (ichn > 0.5) goto l2		; MIDI note
	printks "note %.0f (time = %.2f) was activated from the score\\n", \
		3600, kcnt, istime
	goto l1
l2:
	printks "note %.0f (time = %.2f) was activated from channel %.0f\\n", \
		3600, kcnt, istime, ichn
l1:
	endin


</CsInstruments>
<CsScore>

t 0 60
f 0 6 2 -2 0
i 1 1 0.5
i 1 4 0.5
e


</CsScore>
</CsoundSynthesizer>
