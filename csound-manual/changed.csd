<CsoundSynthesizer>
<CsOptions>
-odac -B441 -b441
</CsOptions>
<CsInstruments>

sr     =        44100
kr     =        100
ksmps  =        441
nchnls =        2

       instr    1
ksig oscil 2,0.5,1
kint = int(ksig)
ktrig changed kint
printk 0.2, kint
printk2 ktrig
	endin

</CsInstruments>
<CsScore>
f 1 0 1024 10 1
i 1 0 20


</CsScore>
</CsoundSynthesizer>
