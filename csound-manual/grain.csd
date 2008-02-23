<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o grain.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 44100
ksmps = 1
nchnls = 1

instr 1
    insnd = 10
    ibasfrq = 44100 / ftlen(insnd)   ; Use original sample rate of insnd file

    kamp   expseg 220, p3/2, 600, p3/2, 220
    kpitch line ibasfrq, p3, ibasfrq * .8
    kdens  line 600, p3, 200
    kaoff  line 0, p3, 5000
    kpoff  line 0, p3, ibasfrq * .5
    kgdur  line .4, p3, .1
    imaxgdur =  .5

    ar  grain kamp, kpitch, kdens, kaoff, kpoff, kgdur, insnd, 5, imaxgdur, 0.0
    out ar
endin


</CsInstruments>
<CsScore>

f5  0 512  20 2                  ; Hanning window
f10 0 262144 1  "mary.wav" 0 0 0
i1 0 6
e


</CsScore>
</CsoundSynthesizer>
