<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o wguide1.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>
sr = 44100
nchnls = 2
instr 1
  afrq  line    50, 10, 100
  asig  oscil   3000, afrq, 1
  aenv  expon   1,10,0.000001
  aexc  =       aenv*asig
  ares  wguide2 aexc, 500, 1200, 777, 1500, 0.2, 0.25
        out ares,asig
endin
</CsInstruments>

<CsScore>
f1 0 4096 10 1
i1 0 3
e
</CsScore>

</CsoundSynthesizer>

