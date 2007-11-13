<CsoundSynthesizer>
<CsOptions>
 -odevaudio
</CsOptions>

<CsInstruments>

; FOF SYNTHESIS

sr = 44100
kr  =  441
ksmps= 100
nchnls = 1

FLcolor	20, 0, 150
FLpanel         "FOF SYNTHESIS", 370, 600, 100, 100, 4
FLlabel  1, 5, 0, 255, 255, 255
ib1  FLbox  "FOF SYNTHESIS (5 FORMANTS) - Luca Pavan", 19, 5, 14, 300, 10, 35, 10
FLsetTextType 3, ib1
FLsetTextSize 12, ib1

FLlabel  11, 5, 0, 255, 255, 255
gkvol1, gih1      FLslider        "Amplitude of 1st formant", 0, 6553, 0, 15, -1, 300, 15, 40, 30
FLsetTextSize 11, gih1
gkvol2, gih2      FLslider        "Amplitude of 2nd formant", 0, 6553, 0, 15, -1, 300, 15, 40, 60
FLsetTextSize 11, gih2
gkvol3, gih3      FLslider        "Amplitude of 3rd formant ", 0, 6553, 0, 15, -1, 300, 15, 40, 90
FLsetTextSize 11, gih3
gkvol4, gih4      FLslider        "Amplitude of 4th formant", 0, 6553, 0, 15, -1, 300, 15, 40, 120
FLsetTextSize 11, gih4
gkvol5, gih5      FLslider        "Amplitude of 5th formant", 0, 6553, 0, 15, -1, 300, 15, 40, 150

gkfrq, gih6      FLslider        "FUNDAMENTAL FREQUENCY OF SINEBURST [Hz]", 0, 3500, 0, 15, -1, 300, 15, 40, 190
FLsetTextSize 10, gih6
gkfor1, gih7      FLslider        "Frequency of 1st formant [Hz]", 0, 22050, 0, 15, -1, 300, 15, 40, 230
FLsetTextSize 11, gih7
gkfor2, gih8      FLslider        "Frequency of 2nd formant [Hz]", 0, 22050, 0, 15, -1, 300, 15, 40, 260
FLsetTextSize 11, gih8
gkfor3, gih9      FLslider        "Frequency of 3rd formant [Hz]", 0, 22050, 0, 15, -1, 300, 15, 40, 290
FLsetTextSize 11, gih9
gkfor4, gih10      FLslider       "Frequency of 4th formant [Hz]", 0, 22050, 0, 15, -1, 300, 15, 40, 320
FLsetTextSize 11, gih10
gkfor5, gih11      FLslider       "Frequency of 5th formant [Hz]", 0, 22050, 0, 15, -1, 300, 15, 40, 350
FLsetTextSize 11, gih11

gkoct, gih12     FLslider        "OCTAVIATION", 0, 10, 0, 15, -1, 300, 15, 40, 390
FLsetTextSize 10, gih12
gkbn1, gih13      FLslider        "Bandwidth of 1st formant [Hz]", 0, 8000, 0, 15, -1, 300, 15, 40, 430
FLsetTextSize 11, gih13
gkbn2, gih14      FLslider        "Bandwidth of 2nd formant [Hz]", 0, 8000, 0, 15, -1, 300, 15, 40, 460
FLsetTextSize 11, gih14
gkbn3, gih15      FLslider        "Bandwidth of 3ht formant [Hz]", 0, 8000, 0, 15, -1, 300, 15, 40, 490
FLsetTextSize 11, gih15
gkbn4, gih16      FLslider        "Bandwidth of 4th formant [Hz]", 0, 8000, 0, 15, -1, 300, 15, 40, 520
FLsetTextSize 11, gih16
gkbn5, gih17      FLslider        "Bandwidth of 5th formant [Hz]", 0, 8000, 0, 15, -1, 300, 15, 40, 550
FLsetTextSize 11, gih17

gkbut, gihb1 FLbutton "SOPRANO 'A'", 1, 1, 1, 80, 12, 40, 585, 0, 2, 0, 0
FLsetTextSize 10, gihb1
FLsetColor 20, 150, 0, gihb1
gkbut, gihb2 FLbutton "ALTO 'A'", 2, 2, 1, 80, 12, 120, 585, 0, 3, 0, 0
FLsetTextSize 10, gihb2
FLsetColor 20, 150, 0, gihb2
gkbut, gihb3 FLbutton "TENOR 'A'", 3, 3, 1, 80, 12, 200, 585, 0, 4, 0, 0
FLsetTextSize 10, gihb3
FLsetColor 20, 150, 0, gihb3
gkbut, gihb4 FLbutton "BASS 'A'", 4, 4, 1, 80, 12, 280, 585, 0, 5, 0, 0
FLsetTextSize 10, gihb4
FLsetColor 20, 150, 0, gihb4

FLpanel_end

FLrun

instr 1

a1      fof  gkvol1, gkfrq, gkfor1, gkoct, gkbn1, .003, .02, .007, 1120, 1, 2, p3
a2      fof  gkvol2, gkfrq, gkfor2, gkoct, gkbn2, .003, .02, .007, 1120, 1, 2, p3
a3      fof  gkvol3, gkfrq, gkfor3, gkoct, gkbn3, .003, .02, .007, 1120, 1, 2, p3
a4      fof  gkvol4, gkfrq, gkfor4, gkoct, gkbn4, .003, .02, .007, 1120, 1, 2, p3
a5      fof  gkvol5, gkfrq, gkfor5, gkoct, gkbn5, .003, .02, .007, 1120, 1, 2, p3
asig   sum a1, a2, a3, a4, a5
          out asig
	endin

 instr  2
	FLsetVal_i	6553, gih1 ; SOPRANO "A"
	FLsetVal_i	3276, gih2
	FLsetVal_i	1310, gih3
	FLsetVal_i	2190, gih4
	FLsetVal_i	150, gih5
	FLsetVal_i	698.456, gih6
	FLsetVal_i	800, gih7
	FLsetVal_i	1150, gih8
	FLsetVal_i	2900, gih9
	FLsetVal_i	3900, gih10
	FLsetVal_i	4950, gih11
	FLsetVal_i	0, gih12
	FLsetVal_i	80, gih13
	FLsetVal_i	90, gih14
	FLsetVal_i	120, gih15
	FLsetVal_i	130, gih16
	FLsetVal_i	140, gih17
	endin

 instr  3
	FLsetVal_i	6553, gih1 ; ALTO "A"
	FLsetVal_i	3400, gih2
	FLsetVal_i	2050, gih3
	FLsetVal_i	1092, gih4
	FLsetVal_i	653, gih5
	FLsetVal_i	261.626, gih6
	FLsetVal_i	800, gih7
	FLsetVal_i	1150, gih8
	FLsetVal_i	2800, gih9
	FLsetVal_i	3500, gih10
	FLsetVal_i	4950, gih11
	FLsetVal_i	0, gih12
	FLsetVal_i	50, gih13
	FLsetVal_i	60, gih14
	FLsetVal_i	170, gih15
	FLsetVal_i	180, gih16
	FLsetVal_i	200, gih17
	endin

 instr  4
	FLsetVal_i	6553, gih1 ; TENOR "A"
	FLsetVal_i	3276, gih2
	FLsetVal_i	3200, gih3
	FLsetVal_i	3120, gih4
	FLsetVal_i	2050, gih5
	FLsetVal_i	220, gih6
	FLsetVal_i	650, gih7
	FLsetVal_i	1080, gih8
	FLsetVal_i	2650, gih9
	FLsetVal_i	2900, gih10
	FLsetVal_i	3250, gih11
	FLsetVal_i	0, gih12
	FLsetVal_i	80, gih13
	FLsetVal_i	90, gih14
	FLsetVal_i	120, gih15
	FLsetVal_i	130, gih16
	FLsetVal_i	140, gih17
	endin

 instr  5
	FLsetVal_i	6553, gih1 ; BASS "A"
	FLsetVal_i	3200, gih2
	FLsetVal_i	3200, gih3
	FLsetVal_i	3100, gih4
	FLsetVal_i	2050, gih5
	FLsetVal_i	174.614, gih6
	FLsetVal_i	600, gih7
	FLsetVal_i	1040, gih8
	FLsetVal_i	2250, gih9
	FLsetVal_i	2450, gih10
	FLsetVal_i	2750, gih11
	FLsetVal_i	1, gih12
	FLsetVal_i	60, gih13
	FLsetVal_i	70, gih14
	FLsetVal_i	110, gih15
	FLsetVal_i	120, gih16
	FLsetVal_i	130, gih17
	endin


</CsInstruments>
<CsScore>

f1 0 512 10 1
f2  0 8192 7 0 8192 1

; score
i1   0   30000

</CsScore>
</CsoundSynthesizer>
