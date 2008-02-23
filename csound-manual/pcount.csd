<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in   No messages  MIDI in
-odac           -iadc    ; -d         -M0  ;;;RT audio I/O with MIDI in
; For Non-realtime ouput leave only the line below:
;-o pcount.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>
;Example by Anthony Kozar Dec 2006
instr 1
    inum  pcount
    print inum
endin

</CsInstruments>
<CsScore>
i1  0 3 4 5       ; has 5 pfields
i1  1 3           ; has 5 due to carry
i1  2 3 4 5 6 7   ; has 7
e
</CsScore>
</CsoundSynthesizer>