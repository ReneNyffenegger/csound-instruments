<CsoundSynthesizer>
<CsOptions>
; set this to a directory where beats.aiff can be found
--env:SSDIR+=/Csound/Documentation/manual/examples
</CsOptions>
<CsInstruments>
sr      =  48000
ksmps   =  32
nchnls  =  2

       instr 1

ktrans  linseg 1, 5, 2, 10, -2
a1      diskin2 "beats.aiff", ktrans, 0, 1, 0, 32
       outs a1, a1
       endin

</CsInstruments>
<CsScore>

i 1 0 15
e

</CsScore>
</CsoundSynthesizer>