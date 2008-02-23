<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o rbjeq.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr      =  44100
ksmps   =  10
nchnls  =  1

        instr 1

a1      vco2    10000, 155.6            ; sawtooth wave
kfco    expon   8000, p3, 200           ; filter frequency
a1      rbjeq   a1, kfco, 1, kfco * 0.005, 1, 0 ; resonant lowpass
        out a1

        endin


</CsInstruments>
<CsScore>

i 1 0 5
e


</CsScore>
</CsoundSynthesizer>
