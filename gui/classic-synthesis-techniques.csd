<CsoundSynthesizer>
<CsOptions>
-+q0 -+p8 -b882 -+O -m0 -odevaudio
</CsOptions>

<CsInstruments>

;=============================================
;
;         CLASSIC SOUND SYNTHESIS TECHNIQUES 
;
;      	      GUI Instruments Collection
;
;	            LUCA PAVAN - 2001
;
;                         pavan@panservice.it
;=============================================

;=============================================
;	Runs with DirectCsound 5.1
;=============================================

sr    = 44100
kr    =     441
ksmps= 100
nchnls=     1

;sr  = 44100
;kr  =   2205
;ksmps= 20
;nchnls=   1

;sr  = 44100
;kr  =   4900 
;ksmps=   9
;nchnls=   1

FLcolor 10, 5, 5
FLpanel "CLASSIC SOUND SYNTHESIS TECHNIQUES - Luca Pavan", 620, 550, 50, 50, 5
FLtabs 610, 560, 5, 5
FLlabel 11, 5, 0, 255, 255, 255
FLcolor 150, 20, 0

FLgroup "MAIN", 600, 505, 10, 40, 1
FLlabel 12, 5, 0, 255, 255, 255
ib1_i FLbox "CLASSIC SOUND SYNTHESIS TECHNIQUES", 19, 5, 14, 500, 20, 60, 84
FLsetTextType 3, ib1_i
FLsetTextSize 24, ib1_i
ib2_i FLbox "GUI Instruments Collection", 19, 5, 12, 400, 20, 110, 130
FLsetTextType 3, ib2_i
FLsetTextSize 24, ib2_i
ib3_i FLbox "by", 19, 5, 11, 300, 20, 160, 170
FLsetTextType 3, ib3_i
ib4_i FLbox "LUCA PAVAN - 2001", 19, 5, 13, 300, 20, 160, 210
FLsetTextType 3, ib4_i
ib5_i FLbox "pavan@panservice.it", 19, 5, 13, 300, 20, 160, 240
FLsetTextType 3, ib5_i
ib6_i FLbox "Version 1.0", 19, 5, 11, 300, 20, 160, 280
FLsetTextType 3, ib6_i
FLgroup_end

;=============================================
;
;		INSTRUMENT PANELS		
;
;=============================================

FLgroup "ADDITIVE", 600, 505, 10, 40, 1
FLlabel 12, 5, 0, 255, 255, 255
ib1x FLbox "ADDITIVE SYNTHESIS", 19, 5, 14, 300, 20, 160, 64
FLsetTextType 3, ib1x
FLsetTextSize 24, ib1x
ib1x1 FLbox "[11 oscillators]", 19, 5, 11, 300, 20, 160, 84
FLsetTextType 3, ib1x1
gkfrqx1, gih1x1 FLslider "Frequency 1 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 80, 140
gkfrqx2, gih1x2 FLslider "Frequency 2 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 80, 200
gkfrqx3, gih1x3 FLslider "Frequency 3 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 80, 260
gkfrqx4, gih1x4 FLslider "Frequency 4 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 80, 320
gkfrqx5, gih1x5 FLslider "Frequency 5 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 80, 380
gkfrqx6, gih1x6 FLslider "Frequency 6 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 80, 440
gkfrqx7, gih1x7 FLslider "Frequency 7 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 360, 140
gkfrqx8, gih1x8 FLslider "Frequency 8 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 360, 200
gkfrqx9, gih1x9 FLslider "Frequency 9 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 360, 260
gkfrqx10, gih1x10 FLslider "Frequency 10 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 360, 320
gkfrqx11, gih1x11 FLslider "Frequency 11 [Hz]", 0, 22000, 0, 15, -1, 200, 20, 360, 380
gkvolx1, gih3x1 FLknob "Volume", 0, 32768, 0,1, -1, 40, 25, 118
gkvolx2, gih3x2 FLknob "Volume", 0, 32768, 0,1, -1, 40, 25, 178
gkvolx3, gih3x3 FLknob "Volume", 0, 32768, 0,1, -1, 40, 25, 238
gkvolx4, gih3x4 FLknob "Volume", 0, 32768, 0,1, -1, 40, 25, 298
gkvolx5, gih3x5 FLknob "Volume", 0, 32768, 0,1, -1, 40, 25, 358
gkvolx6, gih3x6 FLknob "Volume", 0, 32768, 0,1, -1, 40, 25, 418
gkvolx7, gih3x7 FLknob "Volume", 0, 32768, 0,1, -1, 40, 300, 118
gkvolx8, gih3x8 FLknob "Volume", 0, 32768, 0,1, -1, 40, 300, 178
gkvolx9, gih3x9 FLknob "Volume", 0, 32768, 0,1, -1, 40, 300, 238
gkvolx10, gih3x10 FLknob "Volume", 0, 32768, 0, 1, -1, 40, 300, 298
gkvolx11, gih3x11 FLknob "Volume", 0, 32768, 0, 1, -1, 40, 300, 358
gkonx, gihb1x FLbutton "ON/OFF", 1, 0, 4, 60, 20, 30, 90, 0, 7, 0, p3
FLsetTextType 3, gihb1x
FLsetFont 2, gihb1x
FLsetTextSize 10, gihb1x
FLsetColor 255, 4, 4, gihb1x
gkbut, gihb1 FLbutton "Risset beating effect", 1, 1, 1, 80, 35, 480, 440, 0, 8, 0, 0
FLsetTextSize 10, gihb1
FLsetColor 20, 150, 0, gihb1
FLsetColor 20, 150, 0, gih3x1
FLsetColor 20, 150, 0, gih3x2
FLsetColor 20, 150, 0, gih3x3
FLsetColor 20, 150, 0, gih3x4
FLsetColor 20, 150, 0, gih3x5
FLsetColor 20, 150, 0, gih3x6
FLsetColor 20, 150, 0, gih3x7
FLsetColor 20, 150, 0, gih3x8
FLsetColor 20, 150, 0, gih3x9
FLsetColor 20, 150, 0, gih3x10
FLsetColor 20, 150, 0, gih3x11
FLgroup_end

FLgroup "RNG", 600, 505, 10, 40, 1
FLlabel 12, 5, 0, 255, 255, 255
ib1 FLbox "RING MODULATION", 19, 5, 14, 300, 20, 160, 64
FLsetTextType 3, ib1
FLsetTextSize 24, ib1
gkcar, gih1 FLslider "Carrier [Hz]", 0, 22000, 0, 15, -1, 300, 20, 40, 140
gkmod, gih2 FLslider "Modulator [Hz]", 0, 22000,  0, 15, -1, 300, 20, 40, 180
gkvol, gih3 FLknob "Volume", 0, 32768, 0, 1, -1, 40, 25, 240
ibsid FLbox "Sidebands [Hz]", 19, 5, 14, 300, 20, 120, 235
gisd1 FLvalue "c-m", 60, 20, 200, 260
FLsetColor 255, 255, 255, gisd1
gisd2 FLvalue "c+m", 60, 20, 280, 260
FLsetColor 255, 255, 255, gisd2
gkon, gihb1 FLbutton "ON/OFF", 1, 0, 4, 60, 20, 30, 100, 0, 1, 0, p3
FLsetTextType 3, gihb1
FLsetFont 2, gihb1
FLsetTextSize 10, gihb1
FLsetColor 255, 4, 4, gihb1
FLsetColor 20, 150, 0, gih3
FLgroup_end

FLgroup "FM", 600, 505, 10, 40, 1
FLlabel 12, 5, 0, 255, 255, 255
ib2 FLbox "BASIC FM SYNTHESIS", 19, 5, 14, 300, 20, 160, 64
FLsetTextType 3, ib2
FLsetTextSize 24, ib2
FLlabel 11, 5, 0, 255, 255, 255
gkcar1, gih1a FLslider "Carrier Frequency",  0, 22000, 0, 15, -1, 300, 20, 40, 140
gicar FLvalue "c", 45, 20, 210, 275
FLsetColor 255, 255, 255, gicar
FLsetTextSize 18, gicar
ib_j FLbox ":", 19, 5, 14, 10, 20, 258, 275
FLsetTextSize 20, ib_j
gimod FLvalue "m", 45, 20, 270, 275
FLsetColor 255, 255, 255, gimod
FLsetTextSize 18, gimod
gkmod1, gih2a FLslider "Modulator Frequency", 0, 22000, 0, 15, -1, 300, 20, 40, 180
gkidx, gih3a FLslider "Index",  0, 20, 0,15, -1, 300, 20, 40, 220
gkvol1, gih4a FLknob "Volume", 0, 32768, 0, 1, -1, 40, 25, 260
FLsetColor 20, 150, 0, gih4a
gkon1, gihb1a FLbutton "ON/OFF", 1, 0, 4, 60, 20, 30, 100, 0, 1, 0, p3
FLsetTextType 3, gihb1a
FLsetFont 2, gihb1a
FLsetTextSize 10, gihb1a
FLsetColor 255, 4, 4, gihb1a
FLgroup_end

FLgroup "GRAINS", 600, 505, 10, 40, 1
ib3 FLbox "SIMPLE GRANULAR SYNTHESIS", 19, 5, 14, 350, 20, 140, 64
FLsetTextType 3, ib3
FLsetTextSize 24, ib3
FLlabel 11, 5, 0, 255, 255, 255
gkfrq, gih2b  FLslider   "Frequency of grains [Hz]", 0, 22050, 0, 15, -1, 300, 20, 40, 140
gkden, gih3b  FLslider   "Density of grains per second", 1, 10000 , 0, 15, -1, 300, 20, 40, 180
gkdam, gih4b  FLslider   "Amplitude deviation (=> Amp+dev)", 0, 32768, 0, 15, -1, 300, 20, 40, 220
gkfrf, gih5b  FLslider   "Frequency deviation (=> Freq+dev)", 0, 22050, 0, 15, -1, 300, 20, 40, 260
gkdur, gih6b  FLslider   "Grain duration [s]", .1, 20, 0, 15, -1, 300, 20, 40, 300
;gkmdr, gih7b  FLslider  "Maximum grain duration [s]", .01, 20, 0, 15, -1, 300, 20, 40, 340
gkvol3, gih1b  FLknob    "Volume", 0, 32768, 0,1, -1, 40, 25, 340
FLsetColor 20, 150, 0, gih1b
gkon2, gihb1b FLbutton "ON/OFF", 1, 0, 4, 60, 20, 30, 100, 0, 1, 0, p3
FLsetTextType 3, gihb1b
FLsetFont 2, gihb1b
FLsetTextSize 10, gihb1b
FLsetColor 255, 4, 4, gihb1b
FLgroup_end

FLgroup "FOF", 600, 505, 10, 40, 1
ib1y FLbox "FOF SYNTHESIS", 19, 5, 14, 300, 20, 160, 64
FLsetTextType 3, ib1y
FLsetTextSize 24, ib1y
ib1y1 FLbox "[5 formants]", 19, 5, 11, 300, 20, 160, 84
FLsetTextType 3, ib1y1
FLlabel 11, 5, 0, 255, 255, 255
gkvol1y, gih1y FLslider "Amplitude of 1st formant", 0, 6553, 0, 15, -1, 240, 15, 40, 135
gkvol2y, gih2y FLslider "Amplitude of 2nd formant", 0, 6553, 0, 15, -1, 240, 15, 40, 165
gkvol3y, gih3y FLslider "Amplitude of 3rd formant", 0, 6553, 0, 15, -1, 240, 15, 40, 195
gkvol4y, gih4y FLslider "Amplitude of 4th formant", 0, 6553, 0, 15, -1, 240, 15, 40, 225
gkvol5y, gih5y FLslider "Amplitude of 5th formant", 0, 6553, 0, 15, -1, 240, 15, 40, 255
gkfrqy, gih6y  FLslider "FUNDAMENTAL FREQUENCY OF SINEBURST [Hz]", 0, 3500, 0, 15, -1, 240, 25, 340, 325
FLsetTextSize 10, gih6y
gkfor1, gih7y  FLslider "Frequency of 1st formant [Hz]", 0, 22050, 0, 15, -1, 240, 15, 340, 135
gkfor2, gih8y  FLslider "Frequency of 2nd formant [Hz]", 0, 22050, 0, 15, -1, 240, 15, 340, 165
gkfor3, gih9y  FLslider "Frequency of 3rd formant [Hz]", 0, 22050, 0, 15, -1, 240, 15, 340, 195
gkfor4, gih10y FLslider "Frequency of 4th formant [Hz]", 0, 22050, 0, 15, -1, 240, 15, 340, 225
gkfor5, gih11y FLslider "Frequency of 5th formant [Hz]", 0, 22050, 0, 15, -1, 240, 15, 340, 255
gkoct, gih12y  FLslider "OCTAVIATION", 0, 10, 0, 15, -1, 240, 25, 340, 380
FLsetTextSize 10, gih12y
gkbn1, gih13y FLslider "Bandwidth of 1st formant [Hz]", 0, 8000, 0, 15, -1, 240, 15, 40, 295
gkbn2, gih14y FLslider "Bandwidth of 2nd formant [Hz]", 0, 8000, 0, 15, -1, 240, 15, 40, 325
gkbn3, gih15y FLslider "Bandwidth of 3ht formant [Hz]", 0, 8000, 0, 15, -1, 240, 15, 40, 355
gkbn4, gih16y FLslider "Bandwidth of 4th formant [Hz]", 0, 8000, 0, 15, -1, 240, 15, 40, 385
gkbn5, gih17y FLslider "Bandwidth of 5th formant [Hz]", 0, 8000, 0, 15, -1, 240, 15, 40, 415
gkony, gihb1by FLbutton "ON/OFF", 1, 0, 4, 60, 20, 30, 100, 0, 1, 0, p3
FLsetTextType 3, gihb1by
FLsetFont 2, gihb1by
FLsetTextSize 10, gihb1by
FLsetColor 255, 4, 4, gihb1by
gkbut1, gihb1y FLbutton "SOPRANO 'A'", 1, 1, 1, 80, 12, 115, 460, 0, 10, 0, 0
FLsetTextSize 10, gihb1y
FLsetColor 20, 150, 0, gihb1y
gkbut2, gihb2y FLbutton "ALTO 'A'", 2, 2, 1, 80, 12, 195, 460, 0, 11, 0, 0
FLsetTextSize 10, gihb2y
FLsetColor 20, 150, 0, gihb2y
gkbut3, gihb3y FLbutton "TENOR 'A'", 3, 3, 1, 80, 12, 275, 460, 0, 12, 0, 0
FLsetTextSize 10, gihb3y
FLsetColor 20, 150, 0, gihb3y
gkbut5, gihb5y FLbutton "C.TENOR 'A'", 3, 3, 1, 80, 12, 355, 460, 0, 14, 0, 0
FLsetTextSize 10, gihb5y
FLsetColor 20, 150, 0, gihb5y
gkbut4, gihb4y FLbutton "BASS 'A'", 4, 4, 1, 80, 12, 435, 460, 0, 13, 0, 0
FLsetTextSize 10, gihb4y
FLsetColor 20, 150, 0, gihb4y
gkbut1a, gihb1ya FLbutton "SOPRANO 'E'", 1, 1, 1, 80, 12, 115, 475, 0, 15, 0, 0
FLsetTextSize 10, gihb1ya
FLsetColor 20, 150, 0, gihb1ya
gkbut2a, gihb2ya FLbutton "ALTO 'E'", 2, 2, 1, 80, 12, 195, 475, 0, 16, 0, 0
FLsetTextSize 10, gihb2ya
FLsetColor 20, 150, 0, gihb2ya
gkbut3a, gihb3ya FLbutton "TENOR 'E'", 3, 3, 1, 80, 12, 275, 475, 0, 17, 0, 0
FLsetTextSize 10, gihb3ya
FLsetColor 20, 150, 0, gihb3ya
gkbut5a, gihb5ya FLbutton "C.TENOR 'E'", 3, 3, 1, 80, 12, 355, 475, 0, 19, 0, 0
FLsetTextSize 10, gihb5ya
FLsetColor 20, 150, 0, gihb5ya
gkbut4a, gihb4ya FLbutton "BASS 'E'", 4, 4, 1, 80, 12, 435, 475, 0, 18, 0, 0
FLsetTextSize 10, gihb4ya
FLsetColor 20, 150, 0, gihb4ya
gkbut1b, gihb1yb FLbutton "SOPRANO 'I'", 1, 1, 1, 80, 12, 115, 490, 0, 20, 0, 0
FLsetTextSize 10, gihb1yb
FLsetColor 20, 150, 0, gihb1yb
gkbut2b, gihb2yb FLbutton "ALTO 'I'", 2, 2, 1, 80, 12, 195, 490, 0, 21, 0, 0
FLsetTextSize 10, gihb2yb
FLsetColor 20, 150, 0, gihb2yb
gkbut3b, gihb3yb FLbutton "TENOR 'I'", 3, 3, 1, 80, 12, 275, 490, 0, 22, 0, 0
FLsetTextSize 10, gihb3yb
FLsetColor 20, 150, 0, gihb3yb
gkbut5b, gihb5yb FLbutton "C.TENOR 'I'", 3, 3, 1, 80, 12, 355, 490, 0, 24, 0, 0
FLsetTextSize 10, gihb5yb
FLsetColor 20, 150, 0, gihb5yb
gkbut4b, gihb4yb FLbutton "BASS 'I'", 4, 4, 1, 80, 12, 435, 490, 0, 23, 0, 0
FLsetTextSize 10, gihb4yb
FLsetColor 20, 150, 0, gihb4yb
gkbut1c, gihb1yc FLbutton "SOPRANO 'O'", 1, 1, 1, 80, 12, 115, 505, 0, 25, 0, 0
FLsetTextSize 10, gihb1yc
FLsetColor 20, 150, 0, gihb1yc
gkbut2c, gihb2yc FLbutton "ALTO 'O'", 2, 2, 1, 80, 12, 195, 505, 0, 26, 0, 0
FLsetTextSize 10, gihb2yc
FLsetColor 20, 150, 0, gihb2yc
gkbut3c, gihb3yc FLbutton "TENOR 'O'", 3, 3, 1, 80, 12, 275, 505, 0, 27, 0, 0
FLsetTextSize 10, gihb3yc
FLsetColor 20, 150, 0, gihb3yc
gkbut5c, gihb5yc FLbutton "C.TENOR 'O'", 3, 3, 1, 80, 12, 355, 505, 0, 29, 0, 0
FLsetTextSize 10, gihb5yc
FLsetColor 20, 150, 0, gihb5yc
gkbut4c, gihb4yc FLbutton "BASS 'O'", 4, 4, 1, 80, 12, 435, 505, 0, 28, 0, 0
FLsetTextSize 10, gihb4yc
FLsetColor 20, 150, 0, gihb4yc
gkbut1d, gihb1yd FLbutton "SOPRANO 'U'", 1, 1, 1, 80, 12, 115, 520, 0, 30, 0, 0
FLsetTextSize 10, gihb1yd
FLsetColor 20, 150, 0, gihb1yd
gkbut2d, gihb2yd FLbutton "ALTO 'U'", 2, 2, 1, 80, 12, 195, 520, 0, 31, 0, 0
FLsetTextSize 10, gihb2yd
FLsetColor 20, 150, 0, gihb2yd
gkbut3d, gihb3yd FLbutton "TENOR 'U'", 3, 3, 1, 80, 12, 275, 520, 0, 32, 0, 0
FLsetTextSize 10, gihb3yd
FLsetColor 20, 150, 0, gihb3yd
gkbut5d, gihb5yd FLbutton "C.TENOR 'U'", 3, 3, 1, 80, 12, 355, 520, 0, 34, 0, 0
FLsetTextSize 10, gihb5yd
FLsetColor 20, 150, 0, gihb5yd
gkbut4d, gihb4yd FLbutton "BASS 'U'", 4, 4, 1, 80, 12, 435, 520, 0, 33, 0, 0
FLsetTextSize 10, gihb4yd
FLsetColor 20, 150, 0, gihb4yd
FLgroup_end

FLgroup "PLUCK", 600, 505, 10, 40, 1
ib4 FLbox "PLUCK", 19, 5, 14, 300, 20, 160, 64
FLsetTextType 3, ib4
FLsetTextSize 24, ib4
FLlabel 11, 5, 0, 255, 255, 255
gkfrq1, gih1c FLslider "Frequency [Hz]", 1, 22000, 0, 15, -1, 300, 20, 40, 140
gkbuf, gih2c FLslider "Buffer size [Hz]", 0, 4096,  0, 15, -1, 300, 20, 40, 180
gkvol4, gih3c FLknob "Volume", 0, 32768, 0, 1, -1, 40, 25, 220
gkon3, gihb1c FLbutton "ON/OFF", 1, 0, 4, 60, 20, 30, 100, 0, 1, 0, p3
gkdec, gih4c FLcount "Method of natural decay", 1, 6, 1, 2, 1, 100, 20, 120, 230, 0, 1, 0, p3
FLsetColor 20, 150, 0, gih4c
gkipm1, gih5c FLcount "1st value for smoothing", 0, 10, .1, .5, 1, 90, 20, 120, 290, 0, 1, 0, p3
FLsetColor 20, 150, 0, gih5c
gkipm2, gih6c FLcount "2nd value for smoothing", 0, 10, .1, .5, 1, 90, 20, 220, 290, 0, 1, 0, p3
FLsetColor 20, 150, 0, gih6c
FLsetTextType 3, gihb1c
FLsetFont 2, gihb1c
FLsetTextSize 10, gihb1c
FLsetColor 255, 4, 4, gihb1c
FLsetColor 20, 150, 0, gih3c
FLgroup_end

FLgroup "BUZZ", 600, 505, 10, 40, 1
ib5 FLbox "BUZZ", 19, 5, 14, 300, 20, 160, 64
FLsetTextType 3, ib5
FLsetTextSize 24, ib5
FLlabel 11, 5, 0, 255, 255, 255
gkfnd, gih1d FLslider "Frequency of the fundamental [Hz]", 0, 22000, 0, 15, -1, 300, 20, 40, 140
gknum, gih2d FLcount "Maximum number of harmonics", 0, 500, 1, 5, 1, 100, 20, 140, 220, 0, 1, 0, p3
FLsetColor 20, 150, 0, gih2d
gkvol5, gih3d FLknob "Volume", 0, 32768, 0,1, -1, 40, 25, 260
gkon4, gihb1d FLbutton "ON/OFF", 1, 0, 4, 60, 20, 30, 100, 0, 1, 0, p3
FLsetTextType 3, gihb1d
FLsetFont 2, gihb1d
FLsetTextSize 10, gihb1d
FLsetColor 255, 4, 4, gihb1d
FLsetColor 20, 150, 0, gih3d
FLgroup_end

FLgroup "FILTERS", 600, 505, 10, 40, 1
ib5 FLbox "BASIC FILTERS", 19, 5, 14, 300, 20, 160, 64
FLsetTextType 3, ib5
FLsetTextSize 24, ib5
ib5_b FLbox "[Source: white noise]", 19, 5, 11, 300, 20, 160, 84
FLsetTextType 3, ib5_b
FLlabel 11, 5, 0, 255, 255, 255

ib5_a FLbox "HIPASS", 19, 5, 14, 100, 20, 65, 114
FLsetTextType 3, ib5_a
FLsetTextSize 16, ib5_a
FLlabel 11, 5, 0, 255, 255, 255
gkfrq2, gih1e FLslider "Center frequency [Hz]", 0, 22000, 0, 15, -1, 200, 20, 90, 180
gkvol6, gih3e FLknob "Volume", 0, 32768, 0, 1, -1, 40, 75, 220
gkon5, gihb1e FLbutton "ON/OFF", 1, 0, 4, 60, 20, 80, 150, 0, 35, 0, p3
FLsetTextType 3, gihb1e
FLsetFont 2, gihb1e
FLsetTextSize 10, gihb1e
FLsetColor 255, 4, 4, gihb1e
FLsetColor 20, 150, 0, gih3e

ib5_b FLbox "LOWPASS", 19, 5, 14, 100, 20, 330, 114
FLsetTextType 3, ib5_b
FLsetTextSize 16, ib5_b
FLlabel 11, 5, 0, 255, 255, 255
gkfrq2_a, gih1e_a FLslider "Center frequency [Hz]", 0, 22000, 0, 15, -1, 200, 20, 350, 180
gkvol6_a, gih3e_a FLknob "Volume", 0, 32768, 0, 1, -1, 40, 335, 220
gkon5_a, gihb1e_a FLbutton "ON/OFF", 1, 0, 4, 60, 20, 340, 150, 0, 36, 0, p3
FLsetTextType 3, gihb1e_a
FLsetFont 2, gihb1e_a
FLsetTextSize 10, gihb1e_a
FLsetColor 255, 4, 4, gihb1e_a
FLsetColor 20, 150, 0, gih3e_a

ib5_b FLbox "BANDPASS", 19, 5, 14, 100, 20, 75, 304
FLsetTextType 3, ib5_b
FLsetTextSize 16, ib5_b
FLlabel 11, 5, 0, 255, 255, 255
gkfrq2_b, gih1e_b FLslider "Center frequency [Hz]", 0, 22000, 0, 15, -1, 200, 20, 90, 370
gkbnd_b, gih2e_b FLslider "Bandwidth [Hz]", 0, 22000, 0, 15, -1, 200, 20, 90, 410
gkvol6_b, gih3e_b FLknob "Volume", 0, 32768, 0, 1, -1, 40, 75, 450
gkon5_b, gihb1e_b FLbutton "ON/OFF", 1, 0, 4, 60, 20, 80, 340, 0, 1, 0, p3
FLsetTextType 3, gihb1e_b
FLsetFont 2, gihb1e_b
FLsetTextSize 10, gihb1e_b
FLsetColor 255, 4, 4, gihb1e_b
FLsetColor 20, 150, 0, gih3e_b

ib5_b FLbox "BANDREJECT", 19, 5, 14, 100, 20, 345, 304
FLsetTextType 3, ib5_b
FLsetTextSize 16, ib5_b
FLlabel 11, 5, 0, 255, 255, 255
gkfrq2_c, gih1e_c FLslider "Center frequency [Hz]", 0, 22000, 0, 15, -1, 200, 20, 350, 370
gkbnd_c, gih2e_c FLslider "Bandwidth [Hz]", 0, 22000,  0, 15, -1, 200, 20, 350, 410
gkvol6_c, gih3e_c FLknob "Volume", 0, 32768, 0,1, -1, 40, 335, 450
gkon5_c, gihb1e_c FLbutton "ON/OFF", 1, 0, 4, 60, 20, 340, 340, 0, 37, 0, p3
FLsetTextType 3, gihb1e_c
FLsetFont 2, gihb1e_c
FLsetTextSize 10, gihb1e_c
FLsetColor 255, 4, 4, gihb1e_c
FLsetColor 20, 150, 0, gih3e_c
FLgroup_end

FLtabs_end
FLpanel_end

;=================================================
;
;		Csound Instruments
;
;=================================================

FLrun

   FLsetVal_i 1, gih4c
   FLsetVal_i 1, gihb1
   FLsetVal_i 1900, gih1
   FLsetVal_i 800, gih2
   FLsetVal_i 8000, gih3
   FLsetVal_i 1, gihb1a
   FLsetVal_i 220, gih1a
   FLsetVal_i 440, gih2a
   FLsetVal_i 3.14, gih3a
   FLsetVal_i 8000, gih4a
   FLsetVal_i 350, gih2b
   FLsetVal_i 120, gih3b
   FLsetVal_i 100, gih4b
   FLsetVal_i 200, gih5b
   FLsetVal_i .1, gih6b
   FLsetVal_i 3000, gih1b
   FLsetVal_i 1, gihb1c
   FLsetVal_i 440, gih1c
   FLsetVal_i 256, gih2c
   FLsetVal_i 8000, gih3c
   FLsetVal_i 1, gih4c
   FLsetVal_i 1.5, gih5c
   FLsetVal_i 1.5, gih6c
   FLsetVal_i 1, gihb1d
   FLsetVal_i 150, gih1d
   FLsetVal_i 0, gih2d
   
   FLsetVal_i 8000, gih3d
   FLsetVal_i 220, gih1x1
   FLsetVal_i 440, gih1x2
   FLsetVal_i 660, gih1x3
   FLsetVal_i 880, gih1x4
   FLsetVal_i 1000, gih1x5
   FLsetVal_i 1320, gih1x6
   FLsetVal_i 0, gih1x7
   FLsetVal_i 0, gih1x8
   FLsetVal_i 0, gih1x9
   FLsetVal_i 0, gih1x10
   FLsetVal_i 0, gih1x11
   FLsetVal_i 15000, gih3x1
   FLsetVal_i 12000, gih3x2
   FLsetVal_i 10000, gih3x3
   FLsetVal_i 9000, gih3x4
   FLsetVal_i 8000, gih3x5
   FLsetVal_i 8000, gih3x6
   FLsetVal_i 0, gih3x7
   FLsetVal_i 0, gih3x8
   FLsetVal_i 0, gih3x9
   FLsetVal_i 0, gih3x10
   FLsetVal_i 0, gih3x11

   FLsetVal_i 6553, gih1y
   FLsetVal_i 3276, gih2y
   FLsetVal_i 3200, gih3y
   FLsetVal_i 3120, gih4y
   FLsetVal_i 780, gih5y
   FLsetVal_i 220, gih6y
   FLsetVal_i 650, gih7y
   FLsetVal_i 1080, gih8y
   FLsetVal_i 2650, gih9y
   FLsetVal_i 2900, gih10y
   FLsetVal_i 3250, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 80, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 120, gih15y
   FLsetVal_i 130, gih16y
   FLsetVal_i 140, gih17y   
   
   FLsetVal_i 2500, gih3e
   FLsetVal_i 1800, gih1e
   FLsetVal_i 2500, gih3e_a
   FLsetVal_i 3000, gih1e_a
   FLsetVal_i 2500, gih3e_b
   FLsetVal_i 2000, gih1e_b
   FLsetVal_i 500,  gih2e_b
   FLsetVal_i 2500, gih3e_c
   FLsetVal_i 1800, gih1e_c
   FLsetVal_i 600,  gih2e_c

gkon  init 0
gkon1 init 0
gkon2 init 0
gkon3 init 0
gkon4 init 0
gkon5 init 0
gkdur init .1

instr 1

   kenv  linen   gkvol, .05, p3, .05	; de-click
   a1    poscil  kenv, gkcar, 1		; carrier frequency
   a2    poscil  1, gkmod, 1			; modulator frequency
   FLprintk .1, gkcar-gkmod, gisd1
   FLprintk .1, gkcar+gkmod, gisd2
	out  a1*a2*gkon
endin


instr 2

    aenv linen     gkvol1, .1, p3, .1
    amod poscil    gkidx*gkmod1, gkmod1, 1	; modulator
    a1   poscil    aenv, gkcar1+amod, 1  		; carrier
    FLprintk .1, gkmod1/gkcar1, gimod
    FLprintk .1, 1, gicar        
	out    a1*gkon1
endin


instr 3

    asig    grain  gkvol3, gkfrq, gkden, gkdam, gkfrf, gkdur, 1, 2, 20
              out  asig*gkon2
endin

instr 4

    a1	pluck gkvol4, gkfrq1, gkbuf, 0, gkdec, gkipm1, gkipm2
            out 	a1*gkon3
endin

instr 5

   kenv    linen gkvol5, .05, p3, .05	; de-click
   a1       buzz kenv, gkfnd, gknum, 1	; buzz oscillator
             out a1*gkon4
endin

instr 6

   kenv  linen      gkvol6_b, .05, p3, .05 ; de-click
   a1    rand       kenv			 ; noise
   a2    butterbp   a1, gkfrq2_b, gkbnd_b	 ; bandpass filter
   a3    balance    a2, a1
           out      a3*gkon5_b
endin


instr 7

   kenv   linen      1, .05, p3, .05
   a1     poscil     gkvolx1, gkfrqx1, 1
   a2     poscil     gkvolx2, gkfrqx2, 1
   a3     poscil     gkvolx3, gkfrqx3, 1
   a4     poscil     gkvolx4, gkfrqx4, 1
   a5     poscil     gkvolx5, gkfrqx5, 1
   a6     poscil     gkvolx6, gkfrqx6, 1
   a7     poscil     gkvolx7, gkfrqx7, 1
   a8     poscil     gkvolx8, gkfrqx8, 1
   a9     poscil     gkvolx9, gkfrqx9, 1
   a10    poscil     gkvolx10, gkfrqx10, 1
   a11    poscil     gkvolx11, gkfrqx11, 1
   asig   sum a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11
   asig = asig/11
            out asig*kenv*gkonx
endin

instr 8

   FLsetVal_i 110, gih1x1
   FLsetVal_i 110.03, gih1x2
   FLsetVal_i 110.06, gih1x3
   FLsetVal_i 110.09, gih1x4
   FLsetVal_i 110.12, gih1x5
   FLsetVal_i 109.97, gih1x6
   FLsetVal_i 109.94, gih1x7
   FLsetVal_i 109.91, gih1x8
   FLsetVal_i 109.88, gih1x9
   FLsetVal_i 0, gih1x10
   FLsetVal_i 0, gih1x11

   FLsetVal_i 30000, gih3x1
   FLsetVal_i 30000, gih3x2
   FLsetVal_i 30000, gih3x3
   FLsetVal_i 30000, gih3x4
   FLsetVal_i 30000, gih3x5
   FLsetVal_i 30000, gih3x6
   FLsetVal_i 30000, gih3x7
   FLsetVal_i 30000, gih3x8
   FLsetVal_i 30000, gih3x9
   FLsetVal_i 0, gih3x10
   FLsetVal_i 0, gih3x11
endin

instr 9

a1      fof  gkvol1y, gkfrqy, gkfor1, gkoct, gkbn1, .003, .02, .007, 1120, 1, 3, p3
a2      fof  gkvol2y, gkfrqy, gkfor2, gkoct, gkbn2, .003, .02, .007, 1120, 1, 3, p3
a3      fof  gkvol3y, gkfrqy, gkfor3, gkoct, gkbn3, .003, .02, .007, 1120, 1, 3, p3
a4      fof  gkvol4y, gkfrqy, gkfor4, gkoct, gkbn4, .003, .02, .007, 1120, 1, 3, p3
a5      fof  gkvol5y, gkfrqy, gkfor5, gkoct, gkbn5, .003, .02, .007, 1120, 1, 3, p3
asig sum a1, a2, a3, a4, a5
        out  asig*gkony
endin

instr  10
   FLsetVal_i 6553, gih1y ; SOPRANO "A"
   FLsetVal_i 3276, gih2y
   FLsetVal_i 200, gih3y
   FLsetVal_i 800, gih4y
   FLsetVal_i 30, gih5y
   FLsetVal_i 698.456, gih6y
   FLsetVal_i 800, gih7y
   FLsetVal_i 1150, gih8y
   FLsetVal_i 2900, gih9y
   FLsetVal_i 3900, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 80, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 120, gih15y
   FLsetVal_i 130, gih16y
   FLsetVal_i 140, gih17y
endin

instr  11
   FLsetVal_i 6553, gih1y ; ALTO "A"
   FLsetVal_i 3400, gih2y
   FLsetVal_i 790, gih3y
   FLsetVal_i 102, gih4y
   FLsetVal_i 30, gih5y
   FLsetVal_i 261.626, gih6y
   FLsetVal_i 800, gih7y
   FLsetVal_i 1150, gih8y
   FLsetVal_i 2800, gih9y
   FLsetVal_i 3500, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 50, gih13y
   FLsetVal_i 60, gih14y
   FLsetVal_i 170, gih15y
   FLsetVal_i 180, gih16y
   FLsetVal_i 200, gih17y
endin

instr 12
   FLsetVal_i 6553, gih1y ; TENOR "A"
   FLsetVal_i 3276, gih2y
   FLsetVal_i 3200, gih3y
   FLsetVal_i 3120, gih4y
   FLsetVal_i 780, gih5y
   FLsetVal_i 220, gih6y
   FLsetVal_i 650, gih7y
   FLsetVal_i 1080, gih8y
   FLsetVal_i 2650, gih9y
   FLsetVal_i 2900, gih10y
   FLsetVal_i 3250, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 80, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 120, gih15y
   FLsetVal_i 130, gih16y
   FLsetVal_i 140, gih17y
endin

instr 13
   FLsetVal_i 6553, gih1y ; BASS "A"
   FLsetVal_i 3200, gih2y
   FLsetVal_i 3100, gih3y
   FLsetVal_i 3100, gih4y
   FLsetVal_i 780, gih5y
   FLsetVal_i 174.614, gih6y
   FLsetVal_i 600, gih7y
   FLsetVal_i 1040, gih8y
   FLsetVal_i 2250, gih9y
   FLsetVal_i 2450, gih10y
   FLsetVal_i 2750, gih11y
   FLsetVal_i 1, gih12y
   FLsetVal_i 60, gih13y
   FLsetVal_i 70, gih14y
   FLsetVal_i 110, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 130, gih17y
endin

instr 14
   FLsetVal_i 6553, gih1y ; COUNTERTENOR "A"
   FLsetVal_i 3200, gih2y
   FLsetVal_i 450, gih3y
   FLsetVal_i 409, gih4y
   FLsetVal_i 130, gih5y
   FLsetVal_i 440, gih6y
   FLsetVal_i 660, gih7y
   FLsetVal_i 1120, gih8y
   FLsetVal_i 2750, gih9y
   FLsetVal_i 3000, gih10y
   FLsetVal_i 3350, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 80, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 120, gih15y
   FLsetVal_i 130, gih16y
   FLsetVal_i 140, gih17y
endin


instr  15
   FLsetVal_i 6553, gih1y ; SOPRANO "E"
   FLsetVal_i 800, gih2y
   FLsetVal_i 1570, gih3y
   FLsetVal_i 110, gih4y
   FLsetVal_i 20, gih5y
   FLsetVal_i 698.456, gih6y
   FLsetVal_i 350, gih7y
   FLsetVal_i 2000, gih8y
   FLsetVal_i 2800, gih9y
   FLsetVal_i 3600, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 60, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 150, gih16y
   FLsetVal_i 200, gih17y
endin

instr  16
   FLsetVal_i 6553, gih1y ; ALTO "E"
   FLsetVal_i 409, gih2y
   FLsetVal_i 204, gih3y
   FLsetVal_i 102, gih4y
   FLsetVal_i 20, gih5y
   FLsetVal_i 261.626, gih6y
   FLsetVal_i 400, gih7y
   FLsetVal_i 1600, gih8y
   FLsetVal_i 2700, gih9y
   FLsetVal_i 3300, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 60, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 120, gih15y
   FLsetVal_i 150, gih16y
   FLsetVal_i 200, gih17y
endin

instr 17
   FLsetVal_i 6553, gih1y ; TENOR "E"
   FLsetVal_i 1580, gih2y
   FLsetVal_i 1638.25, gih3y
   FLsetVal_i 1580, gih4y
   FLsetVal_i 790, gih5y
   FLsetVal_i 220, gih6y
   FLsetVal_i 400, gih7y
   FLsetVal_i 1700, gih8y
   FLsetVal_i 2600, gih9y
   FLsetVal_i 3200, gih10y
   FLsetVal_i 3580, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 70, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 18
   FLsetVal_i 6553, gih1y ; BASS "E"
   FLsetVal_i 1638.25, gih2y
   FLsetVal_i 3000, gih3y
   FLsetVal_i 1638.25, gih4y
   FLsetVal_i 819.25, gih5y
   FLsetVal_i 174.614, gih6y
   FLsetVal_i 400, gih7y
   FLsetVal_i 1620, gih8y
   FLsetVal_i 2400, gih9y
   FLsetVal_i 2800, gih10y
   FLsetVal_i 3100, gih11y
   FLsetVal_i 1, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 19
   FLsetVal_i 6553, gih1y ; COUNTERTENOR "E"
   FLsetVal_i 1600, gih2y
   FLsetVal_i 819.25, gih3y
   FLsetVal_i 750, gih4y
   FLsetVal_i 750, gih5y
   FLsetVal_i 440, gih6y
   FLsetVal_i 440, gih7y
   FLsetVal_i 1800, gih8y
   FLsetVal_i 2700, gih9y
   FLsetVal_i 3000, gih10y
   FLsetVal_i 3300, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 70, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr  20
   FLsetVal_i 6553, gih1y ; SOPRANO "I"
   FLsetVal_i 1638, gih2y
   FLsetVal_i 380, gih3y
   FLsetVal_i 380, gih4y
   FLsetVal_i 40, gih5y
   FLsetVal_i 698.456, gih6y
   FLsetVal_i 270, gih7y
   FLsetVal_i 2140, gih8y
   FLsetVal_i 2950, gih9y
   FLsetVal_i 3900, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 60, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr  21
   FLsetVal_i 6553, gih1y ; ALTO "I"
   FLsetVal_i 790, gih2y
   FLsetVal_i 205, gih3y
   FLsetVal_i 112, gih4y
   FLsetVal_i 20, gih5y
   FLsetVal_i 261.626, gih6y
   FLsetVal_i 350, gih7y
   FLsetVal_i 1700, gih8y
   FLsetVal_i 2700, gih9y
   FLsetVal_i 3700, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 50, gih13y
   FLsetVal_i 100, gih14y
   FLsetVal_i 120, gih15y
   FLsetVal_i 150, gih16y
   FLsetVal_i 200, gih17y
endin

instr 22
   FLsetVal_i 6553, gih1y ; TENOR "I"
   FLsetVal_i 1570, gih2y
   FLsetVal_i 820, gih3y
   FLsetVal_i 790, gih4y
   FLsetVal_i 205, gih5y
   FLsetVal_i 220, gih6y
   FLsetVal_i 290, gih7y
   FLsetVal_i 1870, gih8y
   FLsetVal_i 2800, gih9y
   FLsetVal_i 3250, gih10y
   FLsetVal_i 3540, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 23
   FLsetVal_i 6553, gih1y ; BASS "I"
   FLsetVal_i 205, gih2y
   FLsetVal_i 830, gih3y
   FLsetVal_i 440, gih4y
   FLsetVal_i 385, gih5y
   FLsetVal_i 174.614, gih6y
   FLsetVal_i 250, gih7y
   FLsetVal_i 1750, gih8y
   FLsetVal_i 2600, gih9y
   FLsetVal_i 3050, gih10y
   FLsetVal_i 3340, gih11y
   FLsetVal_i 1, gih12y
   FLsetVal_i 60, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 24
   FLsetVal_i 6553, gih1y ; COUNTERTENOR "I"
   FLsetVal_i 410, gih2y
   FLsetVal_i 410, gih3y
   FLsetVal_i 103, gih4y
   FLsetVal_i 103, gih5y
   FLsetVal_i 440, gih6y
   FLsetVal_i 270, gih7y
   FLsetVal_i 1850, gih8y
   FLsetVal_i 2900, gih9y
   FLsetVal_i 3350, gih10y
   FLsetVal_i 3590, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 90, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr  25
   FLsetVal_i 6553, gih1y ; SOPRANO "O"
   FLsetVal_i 1680, gih2y
   FLsetVal_i 450, gih3y
   FLsetVal_i 450, gih4y
   FLsetVal_i 40, gih5y
   FLsetVal_i 698.456, gih6y
   FLsetVal_i 450, gih7y
   FLsetVal_i 800, gih8y
   FLsetVal_i 2830, gih9y
   FLsetVal_i 3800, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 70, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 130, gih16y
   FLsetVal_i 135, gih17y
endin

instr  26
   FLsetVal_i 6553, gih1y ; ALTO "O"
   FLsetVal_i 3050, gih2y
   FLsetVal_i 850, gih3y
   FLsetVal_i 380, gih4y
   FLsetVal_i 45, gih5y
   FLsetVal_i 261.626, gih6y
   FLsetVal_i 450, gih7y
   FLsetVal_i 800, gih8y
   FLsetVal_i 2830, gih9y
   FLsetVal_i 3500, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 70, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 130, gih16y
   FLsetVal_i 135, gih17y
endin

instr 27
   FLsetVal_i 6553, gih1y ; TENOR "O"
   FLsetVal_i 1750, gih2y
   FLsetVal_i 1638, gih3y
   FLsetVal_i 1638, gih4y
   FLsetVal_i 380, gih5y
   FLsetVal_i 220, gih6y
   FLsetVal_i 400, gih7y
   FLsetVal_i 800, gih8y
   FLsetVal_i 2600, gih9y
   FLsetVal_i 2800, gih10y
   FLsetVal_i 3000, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 28
   FLsetVal_i 6553, gih1y ; BASS "O"
   FLsetVal_i 790, gih2y
   FLsetVal_i 190, gih3y
   FLsetVal_i 390, gih4y
   FLsetVal_i 90, gih5y
   FLsetVal_i 174.614, gih6y
   FLsetVal_i 400, gih7y
   FLsetVal_i 750, gih8y
   FLsetVal_i 2400, gih9y
   FLsetVal_i 2600, gih10y
   FLsetVal_i 2900, gih11y
   FLsetVal_i 1, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 29
   FLsetVal_i 6553, gih1y ; COUNTERTENOR "O"
   FLsetVal_i 1750, gih2y
   FLsetVal_i 390, gih3y
   FLsetVal_i 430, gih4y
   FLsetVal_i 40, gih5y
   FLsetVal_i 440, gih6y
   FLsetVal_i 430, gih7y
   FLsetVal_i 820, gih8y
   FLsetVal_i 2700, gih9y
   FLsetVal_i 3000, gih10y
   FLsetVal_i 3300, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr  30
   FLsetVal_i 6553, gih1y ; SOPRANO "U"
   FLsetVal_i 880, gih2y
   FLsetVal_i 102, gih3y
   FLsetVal_i 80, gih4y
   FLsetVal_i 30, gih5y
   FLsetVal_i 698.456, gih6y
   FLsetVal_i 325, gih7y
   FLsetVal_i 700, gih8y
   FLsetVal_i 2700, gih9y
   FLsetVal_i 3800, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 50, gih13y
   FLsetVal_i 60, gih14y
   FLsetVal_i 170, gih15y
   FLsetVal_i 180, gih16y
   FLsetVal_i 200, gih17y
endin

instr  31
   FLsetVal_i 6553, gih1y ; ALTO "U"
   FLsetVal_i 1638, gih2y
   FLsetVal_i 210, gih3y
   FLsetVal_i 150, gih4y
   FLsetVal_i 30, gih5y
   FLsetVal_i 261.626, gih6y
   FLsetVal_i 325, gih7y
   FLsetVal_i 700, gih8y
   FLsetVal_i 2530, gih9y
   FLsetVal_i 3500, gih10y
   FLsetVal_i 4950, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 50, gih13y
   FLsetVal_i 60, gih14y
   FLsetVal_i 170, gih15y
   FLsetVal_i 180, gih16y
   FLsetVal_i 200, gih17y
endin

instr 32
   FLsetVal_i 6553, gih1y ; TENOR "U"
   FLsetVal_i 780, gih2y
   FLsetVal_i 810, gih3y
   FLsetVal_i 1600, gih4y
   FLsetVal_i 380, gih5y
   FLsetVal_i 220, gih6y
   FLsetVal_i 350, gih7y
   FLsetVal_i 600, gih8y
   FLsetVal_i 2700, gih9y
   FLsetVal_i 2900, gih10y
   FLsetVal_i 3300, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 60, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 33
   FLsetVal_i 6553, gih1y ; BASS "U"
   FLsetVal_i 800, gih2y
   FLsetVal_i 190, gih3y
   FLsetVal_i 380, gih4y
   FLsetVal_i 102, gih5y
   FLsetVal_i 174.614, gih6y
   FLsetVal_i 350, gih7y
   FLsetVal_i 600, gih8y
   FLsetVal_i 2400, gih9y
   FLsetVal_i 2675, gih10y
   FLsetVal_i 2950, gih11y
   FLsetVal_i 1, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 80, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 34
   FLsetVal_i 6553, gih1y ; COUNTERTENOR "U"
   FLsetVal_i 790, gih2y
   FLsetVal_i 740, gih3y
   FLsetVal_i 204, gih4y
   FLsetVal_i 180, gih5y
   FLsetVal_i 440, gih6y
   FLsetVal_i 370, gih7y
   FLsetVal_i 630, gih8y
   FLsetVal_i 2750, gih9y
   FLsetVal_i 3000, gih10y
   FLsetVal_i 3400, gih11y
   FLsetVal_i 0, gih12y
   FLsetVal_i 40, gih13y
   FLsetVal_i 60, gih14y
   FLsetVal_i 100, gih15y
   FLsetVal_i 120, gih16y
   FLsetVal_i 120, gih17y
endin

instr 35

   kenv  linen      gkvol6, .05, p3, .05	; de-click
   a1    rand       kenv			; noise
   a2    butterhp   a1, gkfrq2		; highpass filter
   a3    balance    a2, a1
           out      a3*gkon5
endin

instr 36

   kenv  linen      gkvol6_a, .05, p3, .05 ; de-click
   a1    rand       kenv			 ; noise
   a2    butterlp   a1, gkfrq2_a		 ; lowpass filter
   a3    balance    a2, a1
           out      a3*gkon5_a
endin

instr 37

   kenv  linen      gkvol6_c, .05, p3, .05 ; de-click
   a1    rand       kenv			 ; noise
   a2    butterbr   a1, gkfrq2_c, gkbnd_c  ; bandreject filter
   a3    balance    a2, a1
           out      a3*gkon5_c
endin



</CsInstruments>
<CsScore>

f0 60000
f1 0 512 10 1
;f1 0 65536 1 "sound.wav" 0 0 0
f2 0 8192 20 2 456
f3  0 8192 7 0 8192 1

; score
i1   0   30000
i2   0   30000
i3   0   30000
i5   0   30000
i6   0   30000
i7   0   30000
i9   0   30000
i35  0   30000
i36  0   30000
i37  0   30000
i4   0   2
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
i4   +   .
e

</CsScore>
</CsoundSynthesizer>