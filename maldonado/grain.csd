<CsoundSynthesizer>
<CsOptions>
 -odevaudio
</CsOptions>

<CsInstruments>

; GRANULAR SYNTHESIS

sr = 44100
kr  =  441
ksmps= 100
nchnls = 1

FLcolor	20, 0, 150
FLpanel         "GRANULAR SYNTHESIS", 380, 380, 100, 100, 4
FLlabel  12, 5, 0, 255, 255, 255
ibox0  FLbox  "GRANULAR SYNTHESIS - Luca Pavan", 19, 5, 14, 300, 20, 35, 24
FLsetTextType 3, ibox0
FLsetTextSize 12, ibox0

FLlabel  11, 5, 0, 255, 255, 255

gkfrq, gih2      FLslider        "Frequency of grains [Hz]", 0, 22050, 0, 15, -1, 300, 20, 40, 100
gkden, gih3      FLslider        "Density of grains per second", 1, 10000 , 0, 15, -1, 300, 20, 40, 140
gkdam, gih4      FLslider        "Amplitude deviation (=> Amp+dev)", 0, 32768, 0, 15, -1, 300, 20, 40, 180
gkfrf, gih5      FLslider        "Frequency deviation (=> Freq+dev)", 0, 22050, 0, 15, -1, 300, 20, 40, 220
gkdur, gih6      FLslider        "Grain duration [s]", .1, 20, 0, 15, -1, 300, 20, 40, 260
;gkmdr, gih7      FLslider        "Maximum grain duration [s]", .01, 20, 0, 15, -1, 300, 20, 40, 300
gkvol, gih1	FLknob	"Volume", 0, 32768, 0,1, -1, 40, 25, 300
FLsetColor 20, 150, 0, gih1

FLpanel_end

FLsetVal_i	350, gih2
FLsetVal_i	120, gih3
FLsetVal_i	100, gih4
FLsetVal_i	200, gih5
FLsetVal_i	.1, gih6
FLsetVal_i	3000, gih1

FLrun

gkdur init .1

instr 1

asig    grain   gkvol, gkfrq, gkden, gkdam, gkfrf, gkdur, 1, 2, 20
out asig
   endin

</CsInstruments>
<CsScore>

f1 0 512 10 1
;f1 0 65536 1 "sound.wav" 0 0 0
f2 0 8192 20 2 456

; score
i1   0   30000

</CsScore>
</CsoundSynthesizer>
