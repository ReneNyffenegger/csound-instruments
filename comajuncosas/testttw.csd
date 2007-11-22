<CsoundSynthesizer>
<CsOptions>
;-+q0 -+p12 -F Aoff__8.mid -b1000 -odevaudio
-+q0 +p12 -m0 -+O -F 1.mid -b800 -odevaudio
;-+q0 -+e -+p16 -m0 -+O -F 1.mid -b800 -odevaudio;only for SoundBlaster owners
;-+O -m0 -+X -F Aoff_11.mid -b882 
</CsOptions>
<CsInstruments>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DirectHammond by Josep M Comajuncosas
;Barcelona, May 2001
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Use high sampling rates with caution
;Except by the distortion DirectHammond is well bandlimited
;and sounds good at sr=22050

;sr    = 44100
;kr    =   441;not too low or you´ll get nasty distortion
;ksmps =   100

;for SoundBlaster owners:
;sr    = 20000
;kr    = 200
;ksmps = 100

sr    = 22050
kr    = 441;not too low or you´ll get nasty distortion
ksmps = 50

nchnls =    2

;this is optional
maxalloc 1,0
prealloc 1,16
maxalloc 2,1

;FLcolor	35,0,0;negre fosc
;FLcolor	102,53,23;fusta fosca
;FLcolor	163,112,65;fusta clara
;FLcolor	241,226,185;blanc os


FLcolor	35,0,0
FLpanel "DirectHammond",655,310, 10,40,1



	FLtabs	645,300, 5,5
FLcolor	-1
FLcolor	163,112,65
FLgroup "Main",640,280, 10,25,1

FLcolor	-1

	FLcolor  241,226,185,102,53,23
	FLlabel  9, 1, 0, 35,0,0 
	
	
		gkL_16ft_lvl,   ih00 FLslider "16'"    ,0,1,0,2,-1,17,150,15,30
		gkL_5_13ft_lvl, ih02 FLslider "5 1/3'" ,0,1,0,2,-1,17,150,35,30
		gkL_8ft_lvl,    ih01 FLslider "8'"     ,0,1,0,2,-1,17,150,55,30
		gkL_4ft_lvl,    ih03 FLslider "4'"     ,0,1,0,2,-1,17,150,75,30
		gkL_2_23ft_lvl, ih04 FLslider "2 2/3'" ,0,1,0,2,-1,17,150,95,30
		gkL_2ft_lvl,    ih05 FLslider "2'"     ,0,1,0,2,-1,17,150,115,30
		gkL_1_35ft_lvl, ih06 FLslider "1 3/5'" ,0,1,0,2,-1,17,150,135,30
		gkL_1_23ft_lvl, ih07 FLslider "1 1/3'" ,0,1,0,2,-1,17,150,155,30
		gkL_1ft_lvl,    ih08 FLslider "1'"     ,0,1,0,2,-1,17,150,175,30

FLsetVal_i   0.5, ih00
FLsetVal_i   0.5, ih01
FLsetVal_i   0.5, ih02
FLsetVal_i   0.5, ih03
FLsetVal_i   0.5, ih04
FLsetVal_i   0.5, ih05
FLsetVal_i   0.5, ih06
FLsetVal_i   0.5, ih07
FLsetVal_i   0.5, ih08
		
	FLcolor      -1
FLcolor	163,112,65,35,0,0

	FLlabel      12, 10, 0, 35,0,0
      ih00lbl  FLbox  "Lower Drawbars", 1, 10, 12, 177, 20, 15, 190
	FLsetAlign  1, ih00lbl 
FLcolor	-1
gkOct_Lo, ih09 FLtext  "Oct", 0, 3, 1, 1, 20,20, 15,192
FLsetColor   241,226,185,  ih09
FLsetColor2   102,53,23, ih09
FLsetVal_i   1, ih09

	FLcolor	102,53,23,241,226,185

 
		gk_L_Att, ih10 FLknob  "Attack", 0.001, 10, -1, 1, -1, 40, 210, 30
		gkL_leak, ih11 FLknob  "Leak"  , 0,    0.1,  0, 1, -1, 40, 210, 85
		gkL_lvl,  ih12 FLknob  "Level" , 0,    1,    0, 1, -1, 40, 210, 140

FLsetVal_i   0.1, ih10
FLsetVal_i   0.05, ih11
FLsetVal_i   0.5, ih12

gk_L_perc_Dec, ih13 FLknob  "Dec" , 0.01, 10, -1, 1, -1, 40, 210+50, 30

gkL_perc_Harm, ih14 FLtext  "2nd/3rd", 2, 3, 1, 1, 24,24, 268,95
FLsetColor  241,226,185,  ih14
FLsetColor2   102,53,23, ih14
FLsetVal_i   2, ih14

FLcolor	102,53,23,241,226,185
gkL_perc_lvl,  ih15 FLknob  "Perc L" , 0,    1,    0, 1, -1, 40, 210+50, 140

FLsetAlign  3, ih14 
FLsetVal_i   0.5, ih13
FLsetVal_i   0.5, ih15


	FLcolor  241,226,185,102,53,23
	FLlabel  9, 1, 0, 35,0,0 
	
	
		gkH_16ft_lvl,   ih20 FLslider "16'"    ,0,1,0,2,-1,17,150,15+320,30
		gkH_5_13ft_lvl, ih22 FLslider "5 1/3'" ,0,1,0,2,-1,17,150,35+320,30
		gkH_8ft_lvl,    ih21 FLslider "8'"     ,0,1,0,2,-1,17,150,55+320,30
		gkH_4ft_lvl,    ih23 FLslider "4'"     ,0,1,0,2,-1,17,150,75+320,30
		gkH_2_23ft_lvl, ih24 FLslider "2 2/3'" ,0,1,0,2,-1,17,150,95+320,30
		gkH_2ft_lvl,    ih25 FLslider "2'"     ,0,1,0,2,-1,17,150,115+320,30
		gkH_1_35ft_lvl, ih26 FLslider "1 3/5'" ,0,1,0,2,-1,17,150,135+320,30
		gkH_1_23ft_lvl, ih27 FLslider "1 1/3'" ,0,1,0,2,-1,17,150,155+320,30
		gkH_1ft_lvl,    ih28 FLslider "1'"     ,0,1,0,2,-1,17,150,175+320,30

FLsetVal_i   0.5, ih20
FLsetVal_i   0.5, ih21
FLsetVal_i   0.5, ih22
FLsetVal_i   0.5, ih23
FLsetVal_i   0.5, ih24
FLsetVal_i   0.5, ih25
FLsetVal_i   0.5, ih26
FLsetVal_i   0.5, ih27
FLsetVal_i   0.5, ih28
		
	FLcolor      -1
FLcolor	163,112,65,35,0,0
	FLlabel      -1
	FLlabel      12, 10, 0, 35,0,0
      ih20lbl  FLbox  "Upper Drawbars", 1, 10, 12, 177, 20, 335, 190
	FLsetAlign  1, ih20lbl 
FLcolor	-1
gkOct_Hi, ih29 FLtext  "Oct", 0, 3, 1, 1, 20,20, 172+320,192
FLsetColor   241,226,185,  ih29
FLsetColor2   102,53,23, ih29
FLsetVal_i   1, ih29

	FLcolor	102,53,23,241,226,185
	


		gk_H_Att, ih30 FLknob  "Attack", 0.001, 10, -1, 1, -1, 40, 210+320, 30
		gkH_leak, ih31 FLknob  "Leak"  , 0,    0.1,  0, 1, -1, 40, 210+320, 85
		gkH_lvl,  ih32 FLknob  "Level" , 0,    1,    0, 1, -1, 40, 210+320, 140

FLsetVal_i   0.1, ih30
FLsetVal_i   0.05, ih31
FLsetVal_i   0.5, ih32

gk_H_perc_Dec, ih33 FLknob  "Dec" , 0.01, 10, -1, 1, -1, 40, 210+320+50, 30

gkH_perc_Harm, ih34 FLtext  "2nd/3rd", 2, 3, 1, 1, 24,24, 268+320,95
FLsetColor   241,226,185,  ih34
FLsetColor2   102,53,23, ih34
FLsetVal_i   2, ih34

FLcolor	102,53,23,241,226,185
gkH_perc_lvl,  ih35 FLknob  "Perc L" , 0,    1,    0, 1, -1, 40, 210+320+50, 140

FLsetAlign  3, ih34 
FLsetVal_i   0.5, ih33
FLsetVal_i   0.5, ih35

;Generators
	gkDetl, ihgen1   FLknob  "Det L",   0.99, 1.01, 0, 1, -1, 40, 70, 230
	gkDet_L1, ihgen2 FLknob  "Mix", 0,    1,    0, 1, -1, 40, 120, 230
	gkTune, ihgen3   FLknob  "Master Tune",   0.944, 1.059, 0, 1, -1, 40, 20, 230;+/- 1 ET semitone

FLsetVal_i   0.995, ihgen1
FLsetVal_i   0.5, ihgen2
FLsetVal_i   1, ihgen3

;Preset number
giPreset_n1  FLvalue "Preset", 30, 20, 220+320, 245
FLsetColor   241,226,185,  giPreset_n1

;Autoadjust volume

gkrms,ihrms	FLbutton	"Auto max",   1,0, 11,50, 20, 230+320+40, 280, 0,8,0,3
FLsetColor   102,53,23, ihrms
FLsetColor2   102,53,23, ihrms
FLsetFont 1,ihrms
FLsetTextSize 9,ihrms
FLsetTextColor    255,0,0,  ihrms

;Main instrument controls
	gkSplit, ihsplit FLtext  "Split", 0, 128, 1, 1, 40, 20, 170+320, 245
	FLsetColor   241,226,185,  ihsplit
	gkMain_Vol,    ihmain2 FLknob  "Main Vol",     0, 1,  0, 1, -1, 50, 230+320+40, 210

FLsetVal_i   0.75, ihmain2


	FLcolor      -1
	FLlabel      -1

;Effect returns

	FLcolor  102,53,23,241,226,185
	FLlabel  9, 1, 0, 35,0,0 

	gkMain_PreEff, ihmain1   FLknob  "PreEff", 0.001, 1, -1, 1, -1, 40, 190, 220
FLcolor      -1
FLcolor  241,226,185,102,53,23

	gkfx_Scan, ihfx0   FLknob  "Scan",   0, 1, 0, 1, -1, 40, 240, 220
	gkfx_Rot,  ihfx1   FLknob  "Rot",    0, 1, 0, 1, -1, 40, 330 , 220
	gkfx_Rev,  ihfx2   FLknob  "Rev",    0, 1, 0, 1, -1, 40, 420 , 220
	gkfx_Dist, ihfx3   FLknob  "Dist",   0, 1, 0, 1, -1, 40, 285 , 220
	gkfx_Del,  ihfx4   FLknob  "Del",    0, 1, 0, 1, -1, 40, 375, 220

FLsetVal_i   0.995, ihmain1
FLsetVal_i   .3, ihfx0
FLsetVal_i   .5, ihfx1
FLsetVal_i   .2, ihfx2
FLsetVal_i   .65, ihfx3
FLsetVal_i   .15, ihfx4


	gkSlowFast, ih130 FLslider  "Slow/Fast Rot", 0, 1, 0, 1, -1, 110,15, 200, 275
	
FLsetColor 163,112,65,ih130
FLsetColor2 102,53,23,ih130
FLsetVal_i   0.52, ih130

gkFlanger_dlt, ihldlt FLslider  "Boot rev (move fast!)", 0.1, 1, -1, 1, -1, 110,15, 340, 275

FLsetColor 163,112,65,ihldlt
FLsetColor2 102,53,23,ihldlt
FLsetVal_i   0.52, ihldlt

	FLcolor      -1
	FLlabel      -1

FLgroup_end


FLcolor	163,112,65
FLgroup "Fine",640,280, 10,25,1
FLlabel      13, 12, 6, 241,226,185

FLgroup	"·Distortion·",146,120, 165,42,2
FLcolor	-1
FLlabel	-1

FLcolor  241,226,185,102,53,23
FLlabel      12, 10, 0, 35,0,0


	gkDist_Drive,   ihdist1   FLknob  "Drive",   .01, 20,    -1, 1, -1, 40, 216, 47
	gkDist_Cutoff,  ihdist2   FLknob  "Cutoff",   250, 4000, -1, 1, -1, 40, 261, 47
	gkSoft_Drive,   ihdist3   FLknob  "Soft", 0.0625, 0.25,  -1, 1, -1, 40, 172, 47
	gkAsymm,        ihdist4   FLknob  "Asymm",    0.01, 0.99, 0, 1, -1, 40, 192, 102
	;	gkdH,           ihdist5   FLknob  "Hard", 0, .99,  0, 1, -1, 40, 216, 102
	gkDist_postGain,ihdist6   FLknob  "postGain", .125, 8,   -1, 1, -1, 40, 241, 102

FLsetVal_i   .1,  ihdist1
FLsetVal_i   1000,  ihdist2
FLsetVal_i .125, ihdist3
FLsetVal_i  .1,  ihdist4
;FLsetVal_i  .1,  ihdist5
gkdH init 0;hardness seems not to work, I set it to 0 by now...
FLsetVal_i   1,  ihdist6



	FLgroup_end


FLcolor	163,112,65
FLlabel      13, 12, 6, 241,226,185

FLgroup	"·Delay·",48,120, 315,42,2
FLcolor	-1
FLlabel	-1

FLcolor  241,226,185,102,53,23
FLlabel      12, 10, 0, 35,0,0


	gkFlanger_dlt, ihflang1   FLknob  "Delay",      0.1, 1, -1, 1, -1, 40, 321, 47
	gkFlanger_fdbk,  ihflang2   FLknob  "Fdbk",   -.999, .999,0, 1, -1, 40, 321, 102

FLsetVal_i   0.3,  ihflang1
FLsetVal_i -.5, ihflang2

FLgroup_end

FLcolor	163,112,65
FLlabel      13, 12, 6, 241,226,185

FLgroup	"·Reverb·",48,120, 367,42,2
FLcolor	-1
FLlabel	-1

FLcolor  241,226,185,102,53,23
FLlabel      12, 10, 0, 35,0,0


	gkRvb_time, ihrv0   FLknob  "Size",   0.05, 10, 0, 1, -1, 40, 371, 47
	gkRvb_Attn,  ihrv1   FLknob  "frq Att", 0, 1, 0, 1, -1, 40, 371, 102

FLsetVal_i   1.5,  ihrv0
FLsetVal_i  .2, ihrv1
FLgroup_end
 

FLcolor	163,112,65
FLlabel      13, 12, 6, 241,226,185

FLgroup	"·Scanner·",146,120, 15,42,2
FLcolor	-1
FLlabel	-1

FLcolor  241,226,185,102,53,23
FLlabel      12, 10, 0, 35,0,0



	gkSc_C,     ihsc1   FLknob  "C",   -1, 1, -1, 1, -1, 40, 22, 47
	gkSc_Acc,   ihsc2   FLknob  "Acc", 0.01,    10,    -1, 1, -1,40 , 67, 47
	gkSc_Fst,   ihsc3   FLknob  "Fst",   0.1, 5, -1, 1, -1, 40, 112, 47
	gkSc_Slw,   ihsc4   FLknob  "Slw",   0.1, 5, -1, 1, -1, 40, 22, 102
	gkSc_Depth, ihsc5   FLknob  "Depth", 0,    0.1,    0, 1, -1,40 , 67, 102
	gkSc_Delay, ihsc6   FLknob  "Delay",   20, 30, -1, 1, -1, 40, 112, 102


FLsetVal_i   0.9, ihsc1
FLsetVal_i   1.2, ihsc2
FLsetVal_i   2.3, ihsc3
FLsetVal_i   0.995, ihsc4
FLsetVal_i   0.05, ihsc5
FLsetVal_i   25, ihsc6

FLgroup_end

;Preset number
giPreset_n2  FLvalue "Preset", 30, 20, 450, 85

FLsetColor   241,226,185,  giPreset_n2

;Autoadjust volume

gkrms,ihrms	FLbutton	"Auto max",   1,0, 11,50, 20, 440, 130, 0,8,0,3
FLsetColor   102,53,23, ihrms
FLsetColor2   102,53,23, ihrms
FLsetFont 1,ihrms
FLsetTextSize 9,ihrms
FLsetTextColor    255,0,0,  ihrms


FLcolor	163,112,65
FLlabel      13, 12, 6, 241,226,185

FLgroup	"·Leslie·",486,120, 15,177,2

FLcolor	-1
FLlabel	-1

FLcolor  241,226,185,102,53,23
FLlabel      12, 10, 0, 35,0,0


;Leslie
		gkL_Fst, ih131 FLknob  "L Fast"  , 0.1,    15,   0, 1, -1, 40, 67, 236
		gkL_Slw,  ih132 FLknob  "L Slow" , 0.1,    15,   0, 1, -1, 40, 22, 236
		gkH_Fst, ih133 FLknob  "H Fast"  , 0.2,    16,   0, 1, -1, 40, 67, 181
		gkH_Slw,  ih134 FLknob  "H Slow" , 0.2,    16,   0, 1, -1, 40, 22, 181
		gkL_Acc,  ih135 FLknob  "L Acc" , 0.01,    10,   0, 1, -1, 40, 112, 236
		gkH_Acc,  ih136 FLknob  "H Acc" , 0.01,    10,   0, 1, -1, 40, 112, 181

		gkFq_Sep,  ih137 FLknob  "Fq Sep" , 100, 2000,  -1, 1, -1, 40, 177, 181
		gkaM,  ih138 FLknob  "aM" ,    0,    2,          0, 1, -1, 40, 177, 236
		gkL_Att2,  ih139 FLknob  "L Att" , 0,    1,      0, 1, -1, 40, 232, 236
		gkH_Att2,  ih140 FLknob  "H Att" , 0,    1,      0, 1, -1, 40, 232, 181

		gkHCut,  ih141 FLknob  "HCut" , 20,    6000,  -1, 1, -1, 40, 297, 181
		gkHQ,    ih142 FLknob  "HQ" , 0.001,    1,    -1, 1, -1, 40, 342, 181
		gkLCut,  ih143 FLknob  "LCut" , 20,    6000,  -1, 1, -1, 40, 297, 236
		gkLQ,    ih144 FLknob  "LQ" , 0.001,    1,    -1, 1, -1, 40, 342, 236
		gkLow,   ih145 FLknob  "Low" , 0,    1,        0, 1, -1, 40, 387, 236
		gkHigh,  ih146 FLknob  "High" , 0,    1,       0, 1, -1, 40, 387, 181

		gkL_Doppler,  ih147 FLknob  "LDoppler" , 0,    1,0, 1, -1, 40, 452, 236
		gkH_Doppler,  ih148 FLknob  "HDoppler" , 0,    1,0, 1, -1, 40, 452, 181


FLsetVal_i   7.43, ih131
FLsetVal_i   0.16, ih132
FLsetVal_i   9.73, ih133
FLsetVal_i   0.33, ih134
FLsetVal_i   0.11, ih135
FLsetVal_i   0.10, ih136
FLsetVal_i   1638, ih137
FLsetVal_i   1.72, ih138
FLsetVal_i   0.27, ih139
FLsetVal_i   0.21, ih140
FLsetVal_i   5153, ih141
FLsetVal_i   0.86, ih142
FLsetVal_i   2599, ih143
FLsetVal_i   0.87, ih144
FLsetVal_i   0.92, ih145
FLsetVal_i      1, ih146
FLsetVal_i   0.17, ih147
FLsetVal_i   0.23, ih148

;temporal message!
ihmsgtemp  FLbox  "space for MIDI controls?", 1, 10, 12, 100, 30, 520, 40

	FLcolor      -1
	FLlabel      -1
FLgroup_end
FLgroup_end

FLcolor	163,112,65,163,112,65
FLgroup "Presets",640,280, 10,25,1
FLlabel      14, 10, 0, 35,0,0


gkStore,ihp1 FLcount	"New preset",0,99,1,10,21,150,20,20,100,    -1,4,0,0

gk9,ihp	FLbutton	"Store",          3,0, 11,50,25,70,140,    0,4,0,0
gk9,ihp	FLbutton	"Save to disk",   1,0, 11,104,25,43,235,    0,5,0,0
gk9,ihp	FLbutton	"Load from disk", 1,0, 11,104,25, 43,40,    0,6,0,0
FLcolor	-1
FLcolor	163,112,65,255, 255, 0
gkGet,ihp2	FLbutBank	12, 10,10, 440,220, 200,40,    0,7,0,0

FLcolor	-1
FLlabel      -1
FLgroup_end


FLcolor	163,112,65
FLgroup "About",640,280, 10,25,1
FLlabel      12, 10, 0, 35,0,0
iab1  FLbox  "TTW: original Sync Modular design by Istvan Kaldor ", 1, 10, 12, 580, 20, 20, 100
iab2  FLbox  "DirectHammond by Josep M Comajuncosas", 1, 10, 12, 580, 20, 20, 120
iab3  FLbox  "gelida@intercom.es", 1, 10, 12, 580, 20, 20, 140
iab4  FLbox  "please check http://www.csounds.com/jmc for updates", 1, 10, 12, 580, 20, 20, 160

FLcolor	-1

FLgroup_end


FLtabs_end
FLpanel_end

FLrun

instr 1

gasig init 0
ikey notnum;=64; ;notnum
ifreq cpsmidi;= p4;p4;cpsmidi
ifreq=.5*ifreq;trick to run the tonewheels with waveshaping

kOct_Hi = 2^(gkOct_Hi-1);(0.5,1,2,4)
kOct_Lo = 2^(gkOct_Lo-1);1;(0.5,1,2,4)

kTune=gkTune;1;(0.95~1.05)
kDet1=gkDetl;0.995;(0.99~1.01)
kDet_L1=gkDet_L1;0.8;(0~1)

kfreq1 = ifreq*kTune*kOct_Hi
kfreq2 = ifreq*kTune*kDet1*kOct_Lo

kSplit = gkSplit

;GENERATORS

;tonewheels by chebyshev polynomials<-in phase
a01 oscili 1,kfreq1,1;16''
a1m2=2*a01
a02=2*(a01^2)-1 ;8''
a03=a1m2*a02-a01;5''1/3
a04=a1m2*a03-a02;4''
a05=a1m2*a04-a03
a06=a1m2*a05-a04;2''2/3
a07=a1m2*a06-a05
a08=a1m2*a07-a06;2''
a09=a1m2*a08-a07
a10=a1m2*a09-a08;1''3/5
a11=a1m2*a10-a09
a12=a1m2*a11-a10;1''2/3
a13=a1m2*a12-a11
a14=a1m2*a13-a12
a15=a1m2*a14-a13
a16=a1m2*a15-a14;1''

;detuned tonewheel array for chorus effect
ad01 oscili kDet_L1,kfreq2,1;16''
ad1m2=2*ad01
ad02=2*(ad01^2)-1 ;8''
ad03=ad1m2*ad02-ad01;5''1/3
ad04=ad1m2*ad03-ad02;4''
ad05=ad1m2*ad04-ad03
ad06=ad1m2*ad05-ad04;2''2/3
ad07=ad1m2*ad06-ad05
ad08=ad1m2*ad07-ad06;2''
ad09=ad1m2*ad08-ad07
ad10=ad1m2*ad09-ad08;1''3/5
ad11=ad1m2*ad10-ad09
ad12=ad1m2*ad11-ad10;1''2/3
ad13=ad1m2*ad12-ad11
ad14=ad1m2*ad13-ad12
ad15=ad1m2*ad14-ad13
ad16=ad1m2*ad15-ad14;1''

;add both tonewheel arrays
a16ft   =(a01+ad01)
a8ft    =(a02+ad02)
a5_13ft =(a03+ad03)
a4ft    =(a04+ad04)
a2_23ft =(a06+ad06)
a2ft    =(a08+ad08)
a1_35ft =(a10+ad10)
a1_23ft =(a12+ad12)
a1ft    =(a16+ad16)

aftSum sum a16ft,a8ft,a5_13ft,a4ft,a2_23ft,a2ft,a1_35ft,a1_23ft,a1ft

aNull init 0;I know ...but it seems a necessary trick in conditionals

;DRAWBARS HIGH

aH_16ft   = gkH_16ft_lvl   *(a16ft)
aH_8ft    = gkH_8ft_lvl    *(a8ft)
aH_5_13ft = gkH_5_13ft_lvl *(a5_13ft)
aH_4ft    = gkH_4ft_lvl    *(a4ft)
aH_2_23ft = gkH_2_23ft_lvl *(a2_23ft)
aH_2ft    = gkH_2ft_lvl    *(a2ft)
aH_1_35ft = gkH_1_35ft_lvl *(a1_35ft)
aH_1_23ft = gkH_1_23ft_lvl *(a1_23ft)
aH_1ft    = gkH_1ft_lvl    *(a1ft)

aH_ftSum sum aH_16ft,aH_8ft,aH_5_13ft,aH_4ft,aH_2_23ft,aH_2ft,aH_1_35ft,aH_1_23ft,aH_1ft
aH_env madsr i(gk_H_Att),0,1,0.01
aH_env = (kSplit>ikey?aNull:aH_env)
kH_perc_Harm=gkH_perc_Harm

aH_perc = (kH_perc_Harm>2?a2_23ft:a4ft)
aH_perc_env madsr 0.01,i(gk_H_perc_Dec),0,0.01
aH_perc_env = (kSplit>ikey?aNull:aH_perc_env)
aH_ftSumOut = (aH_ftSum + gkH_leak*aftSum)*aH_env*gkH_lvl + (gkH_perc_lvl*aH_perc)*aH_perc_env


;DRAWBARS LOW

aL_16ft   = gkL_16ft_lvl   *(a16ft)
aL_8ft    = gkL_8ft_lvl    *(a8ft)
aL_5_13ft = gkL_5_13ft_lvl *(a5_13ft)
aL_4ft    = gkL_4ft_lvl    *(a4ft)
aL_2_23ft = gkL_2_23ft_lvl *(a2_23ft)
aL_2ft    = gkL_2ft_lvl    *(a2ft)
aL_1_35ft = gkL_1_35ft_lvl *(a1_35ft)
aL_1_23ft = gkL_1_23ft_lvl *(a1_23ft)
aL_1ft    = gkL_1ft_lvl    *(a1ft)


aL_ftSum sum aL_16ft,aL_8ft,aL_5_13ft,aL_4ft,aL_2_23ft,aL_2ft,aL_1_35ft,aL_1_23ft,aL_1ft
aL_env madsr i(gk_L_Att),0,1,0.01
aL_env = (kSplit>ikey?aL_env:aNull)
kL_perc_Harm=gkL_perc_Harm

aL_perc = (kL_perc_Harm>2?a2_23ft:a4ft)
aL_perc_env madsr 0.01,i(gk_L_perc_Dec),0,0.01
aL_percEnv = (kSplit>ikey?aL_perc_env:aNull)
aL_ftSumOut = (aL_ftSum + gkL_leak*aftSum)*aL_env*gkL_lvl + (gkL_perc_lvl*aL_perc)*aL_perc_env


;mix&output
aout= aL_ftSumOut+aH_ftSumOut
gasig = gkMain_PreEff*aout + gasig
endin


instr 2
;Get and display preset number
FLprintk2  gkGet, giPreset_n1 
FLprintk2  gkGet, giPreset_n2
aSignal = gasig

;Scanner
kSc_C=gkSc_C;(-1-1)
kSc_Acc=gkSc_Acc;(0.011-10)
kSc_Fst=gkSc_Fst;(0.1-5)
kSc_Slw=gkSc_Slw;(0.1-5)
kSc_Depth=gkSc_Depth;(0-0.1)
kSc_Delay=gkSc_Delay;(0.2-0.3)*1000 (milisegons)

kSc_LpOut tonek kSc_C,kSc_Acc
kSc_Fst2 = kSc_LpOut*kSc_Fst
kSc_Freq = (kSc_Fst2>kSc_Slw?kSc_Fst2:kSc_Slw)
kSc_sine oscil kSc_Depth,kSc_Freq,1
aSc_dlt1 interp (1-kSc_sine)*kSc_Delay
aSc_dlt2 interp (1+kSc_sine)*kSc_Delay
aSc_Dl1 vdelay aSignal,aSc_dlt1,60
aSc_Dl2 vdelay aSignal,aSc_dlt2,60
aSc_Out dcblock gkfx_Scan*(aSc_Dl1+aSc_Dl2)+(1-gkfx_Scan)*aSignal
;aSc_Out = gkfx_Scan*(aSc_Dl1+aSc_Dl2)+(1-gkfx_Scan)*aSignal



;Distortion
kDist_Drive = gkDist_Drive;(0-2)
kDist_Cutoff= gkDist_Cutoff
kAsymm  = gkAsymm;(0-1)
kSoft_Drive  = gkSoft_Drive;
kdstH       = gkdH;(0,0.999)

aSat_In butterlp aSc_Out*kDist_Drive,kDist_Cutoff

kLp=2.5*(1-kAsymm)
kLn=-2.5*(1+kAsymm)

aLp interp kLp
aLn interp kLn

;now some a-rate conditionals with tables
;Positive

aSat_In = 4*tanh(kSoft_Drive*aSat_In);trick to avoid overflow of the original Sync Modular module (-4,4)
arel1 table aSat_In-kLp*kdstH,10,1,.5,0
aSat1=(arel1)*(((((-2*(2-kdstH)*kLp)+aSat_In)*aSat_In)+(kLp*kdstH)^2))/(4*kLp*(kdstH-1))+(1-arel1)*aSat_In

arel2 table aSat_In-(2-kdstH)*kLp,10,1,.5,0
aSat2=(arel2)*aLp+(1-arel2)*aSat1

;Negative
arel3 table aSat2-kLn*kdstH,10,1,.5,0
aSat3=(1-arel1)*(((((-2*(2-kdstH)*kLn)+aSat2)*aSat2)+(kLn*kdstH)^2))/(4*kLn*(kdstH-1))+(arel3)*aSat2

arel4 table aSat2-(2-kdstH)*kLn,10,1,.5,0
aSat4=(1-arel4)*aLp+(arel4)*aSat3

aDist_Out = gkDist_postGain*gkfx_Dist*aSat4+(1-gkfx_Dist)*aSc_Out

;Feedback delay

kFlanger_dlt=gkFlanger_dlt;(0.1,1)
kFlanger_fdbk=gkFlanger_fdbk;(-1 1)
aFlanger_dlt interp kFlanger_dlt

aFlanger flanger aDist_Out, aFlanger_dlt, kFlanger_fdbk ,1
aFlanger_Out dcblock gkfx_Del*aFlanger+(1-gkfx_Del)*aDist_Out
aFlanger_Out = gkfx_Del*aFlanger+(1-gkfx_Del)*aDist_Out


;Freverb reverb

aRvb_Free nreverb	aFlanger_Out, gkRvb_time, gkRvb_Attn, 0, 8, 71, 4, 72
aRvb_Out=gkfx_Rev*aRvb_Free +(1-gkfx_Rev)*aFlanger_Out

;Rotary Speaker Effect
;SPEED/ACCEL
kSlow_Fast=gkSlowFast;0.52;(0~1?)
kIN = kSlow_Fast
kL_Fst=gkL_Fst;7.4377;(0.1~15)
kL_Slw=gkL_Slw;0.165;(")
kH_Slw=gkH_Slw;0.3384;(0.2~16)
kH_Fst=gkH_Fst;9.7373;(")
kL_Acc=gkL_Acc;0.1096;(0.01~10)
kH_Acc=gkH_Acc;0.1;(")

kL_Horn tonek kL_Fst*kIN+kL_Slw*(1-kIN),kL_Acc
kH_Horn tonek kH_Fst*kIN+kH_Slw*(1-kIN),kH_Acc

kH lfo 1, kH_Horn,0
kL lfo 1, kL_Horn,0


;ATTEN
kFq_Sep=gkFq_Sep;1637.9;(100~2000)
kaM=gkaM;1.72;(0~2)

aLP, aHP, aBP1 svfilter aDist_Out, kFq_Sep, .7,1
aBP1 = .3*aBP1
aO1 = (kH+kaM)*(aLP+aBP1)
aO2 = (kL+kaM)*(aHP+aBP1)
kL_Att=gkL_Att2;0.2733;(0~1)
kH_Att=gkH_Att2;0.2067;(0~1)
kCL = kL_Att
kCH = kH_Att

;HP FILTERS
kHCut=gkHCut;5153.4;(20~6000)
kHQ=1+500*gkHQ;0.8667*500;(0~1?500?)
kLCut=gkLCut;2599.2;(")
kLQ=1+500*gkLQ;0.8733*500;(")
kLow=gkLow;0.9267;(0~1)
kHigh=gkHigh;1;(0~1)
 
aLP_in = aO1
aHP_in = aO2

aLP2, aHP2, aBP2 svfilter aHP_in, kHCut, kHQ,1
aLP3, aHP3, aBP3 svfilter aLP_in, kLCut, kLQ,1

aDS = aLP_in + (kLow*(kL-1)*aHP3)
aDD = aLP_in + (kLow*(-1-kL)*aHP3)
aHS = aHP_in + (kHigh*(-1-kH)*aHP2)
aHD = aHP_in + (kHigh*(kH-1)*aHP2)

;DOPPLER
kL_Doppler=gkL_Doppler;0.1733;(0~1)
kH_Doppler=gkH_Doppler;0.2333;(")

kH_Horn = (1/kH_Horn+1)*kH_Doppler
kL_Horn = (1/kL_Horn+1)*kL_Doppler

;SEPARATOR1

kLCL1 = kL*kCL
kDL1 = (1-kLCL1)
kSL1 = (kLCL1+1)
kHCH1 = kH*kCH
kDH1 = (1-kHCH1)
kSH1 = (kHCH1+1)

;SEPARATOR2 

kLCL2 = kL*kL_Horn
kDL2 = (1-kLCL2)
kSL2 = (kLCL2+1)
kHCH2 = kH*kH_Horn
kDH2 = (1-kHCH2)
kSH2 = (kHCH2+1)

;DELAYS
;interpolating upsamplers
;(works faster but adds noise)

aDL2 interp kDL2
aDH2 interp kDH2
aSL2 interp kSL2
aSH2 interp kSH2

aD1 vdelay3 aDD*kDL1, 1.5*aSL2, 3
aD2 vdelay3 aHD*kDH1, 1.5*aSH2, 3
aD3 vdelay3 aDS*kSL1, 1.5*aDL2, 3
aD4 vdelay3 aHS*kSH1, 1.5*aDH2, 3

aLeslie_Dry = (1-gkfx_Rot)*aDist_Out
aLeslie_L dcblock gkfx_Rot*(aD1+aD2)+aLeslie_Dry
aLeslie_R dcblock gkfx_Rot*(aD3+aD4)+aLeslie_Dry

gkirms init 800
aout_L =gkirms*(aLeslie_L + aRvb_Out)*gkMain_Vol
aout_R =gkirms*(aLeslie_R + aRvb_Out)*gkMain_Vol
galevel = aLeslie_L + aRvb_Out;take left channel as reference

outs aout_L,aout_R
gasig = 0
endin

	instr	4
	inumsnap	inumval FLsetsnap	i(gkStore)
	endin

	instr	5
	FLsavesnap	"B5_snap.txt"
	endin

	instr	6
	FLloadsnap	"B5_snap.txt"
	endin

	instr	7
	inumel	FLgetsnap	i(gkGet)
	endin

	instr	8
	gkrms rms galevel
	gkirms = 5000/gkrms 
	endin

</CsInstruments>
<CsScore>
f1 0 8193 10 1
f2 0 8193 10 2 4 0 3 5 2

;distortion table
f6 0 8193 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
f7 0 4097 4 6 1
;relay table
f10 0 32 7 0 16 0 0 1 16 1
; freeverb time constants, as direct (negative) sample, with arbitrary gains
f71 0 16   -2  -1116 -1188 -1277 -1356 -1422 -1491 -1557 -1617  0.8  0.79  0.78  0.77  0.76  0.75  0.74  0.73  
f72 0 16   -2  -556 -441 -341 -225 0.7  0.72  0.74  0.76

f0 3600
i2 0 3600
e
</CsScore>
</CsoundSynthesizer>