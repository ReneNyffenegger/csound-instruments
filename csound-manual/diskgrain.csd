<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc    ;;;RT audio I/O
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 128

instr 1
iolaps = 2
igrsize = 0.04
ifreq = iolaps/igrsize
ips = 1/iolaps

istr = p4  /* timescale */
ipitch = p5 /* pitchscale */

a1 diskgrain "mary.wav", 32000, ifreq, ipitch, igrsize, ips*istr, 1, iolaps

out   a1
endin

</CsInstruments>
<CsScore>
f 1 0 8192 20   1   1  ;Hamming function

;           timescale   pitchscale
i 1   0   5     1           1
i 1   +   5     2           1
i 1   +   5     1          0.75
i 1   +   5     1.5        1.5
i 1   +   5     0.5        1.5

e
</CsScore>
</CsoundSynthesizer>