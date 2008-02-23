<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o prepiano.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 2;

; Instrument #1.
instr 1
;;          fund NS detune stiffness decay loss (bndry) (hammer) scan prep
aa,ab prepiano 60, 3, 10, p4, 3, 0.002, 2, 2, 1, 5000, -0.01, p5, p6, 0, 0.1, 1, 2
      outs aa*.75, ab*.75
endin
</CsInstruments>

<CsScore>
f1 0 8 2 1 0.6 10 100 0.001 ;; 1 rattle
f2 0 8 2 1 0.7 50 500 1000  ;; 1 rubber
i1 0.0 0.5 1 0.09 20
i1 0.5 .  -1 0.09 40        ;; 1 -> skip initialisation
i1 1.0 .  -1 0.09 60
i1 1.5 .  -1 0.09 80
i1 2.0 1.8  -1 0.09 100
e
</CsScore>
</CsoundSynthesizer>
