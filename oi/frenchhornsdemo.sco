#include"ZAKINI~2.TXT"	;zak initializer definition
#include"TUNING~2.TXT"	;tuning-related ftables
#include"MODEPR~2.TXT"	;mode-related ftables
#include"OTHERF~1.TXT"	;other, synthesis-related ftables



;instrument definitions here.  
;Note:these must agree with those in the orchestra.
# define wsFhorn #70 #
# define subFhorn #71 #
# define subFhorn2 #72 #
# define fofFhorn #73 #
# define monoOut #198 #
# define chClear #199 #


t0      60   
i$Zakinit     0      0      19     6      0      3    
i$Tuning      0      0      5    
i$Mode 0      0      20.00  30     0      0      4    
i$monoOut     0      -1     -1  
i$chClear     0      -1   


;wsFrenchHorn--
;registers: reg0=6.05--8.06 (9.02);  registers are +/- perfect 5ths from this
;the weighting (w) parameters contol the strength of six ctrl functions affecting spectral content (roughly, brightness).
;dB w---loudness's effect on spectrum, -ve for inverse.  traditionally, this it the major/only ctrl.
;avib w---anti-vibrato ctrl (i.e., brighter when pitch is lower). -ve for pro-vibrato ctrl.
;lfo w, lfo i, lfo f---the lfo has a random phase and given initial/final frequencies.  these
;     are -ve if in Hz and +ve if in periods per duration.
;rnd w, rnd ctrl---brownish noise. ctrl is the maximum slope (if -ve) or avg slope (if +ve).
;lin w---a linear ramp, increasing if +ve, decreasing if -ve.
;          ST   DUR    db  PCH PITCH AMP PEAK PEAK    VD GLISS REG- REG dB  avib lfo rnd pk lin lfo lfo rnd  PREV OUT
;                               FROM TO  AMP  POINT       TO   ISTR TO   w    w   w   w  w   w  ini fin ctrl GLIS CH
i$wsFhorn     0      -0.25  80     9.0    9.0    np4    8      0.2    .5     0      0      0      1      0      0 0 0 0 1 2 8 pp11 0
i$wsFhorn     +      -0.25  80     8.7    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  81     8.6    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  81     8.5    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  82     8.4    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  82     8.3    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  83     8.2    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  83     8.1    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.75  84     8.0    pp5    np4    7      0.2    .      7.7    .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  84     7.7    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  85     7.6    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  85     7.5    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  86     7.4    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  86     7.3    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  87     7.2    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  87     7.1    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  87     7.0    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  87     6.7    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      -0.25  87     6.6    pp5    np4    7      0.2    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
;i$wsFhorn  +   -0.25   87  6.5  pp5  np4  7    0.2     .   0    .    .   1    0   0   0  0   0   1   2   1   pp11  0
i$wsFhorn     +      0.25   87     6.4    pp5    0      7      0.5    .      0      .      .      1      0      0 0 0 0 1 2 1 pp11 0
;register
i$wsFhorn     +      0.5    90     8.0    pp5    0      4      0.3    .      0      -2     -2     1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.5    90     8.0    pp5    0      4      0.3    .      0      -1     -1     1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.5    90     8.0    pp5    0      4      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.5    90     8.0    pp5    0      4      0.3    .      0      1      1      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.5    90     8.0    pp5    0      4      0.3    .      0      2      2      1      0      0 0 0 0 1 2 1 pp11 0
;pitch
i$wsFhorn     +      0.25   86     6.3    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     6.5    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     6.7    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     7.1    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     7.3    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     7.5    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     7.7    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     8.1    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     8.3    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     8.5    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   86     8.7    pp5    0      6      0.3    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
;db
i$wsFhorn     +      0.25   90     8.0    pp5    0      6      0.5    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   84     8.0    pp5    0      6      0.5    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   78     8.0    pp5    0      6      0.5    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   72     8.0    pp5    0      6      0.5    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   66     8.0    pp5    0      6      0.5    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   60     8.0    pp5    0      6      0.5    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      0.25   54     8.0    pp5    0      6      0.5    .      0      0      0      1      0      0 0 0 0 1 2 1 pp11 0
;expression
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      1      0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      -1     0 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      0      1 0 0 0 1 2 1 pp11 0
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      0      0 1 0 0 1 2 1 pp11 0
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      0      0 1 0 0 1 2 3 pp11 0
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      0      0 1 0 0 1 2 8 pp11 0
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      0      0 0 1 0 1 2 1 pp11 0
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      0      0 0 0 1 1 2 1 pp11 0
i$wsFhorn     +      1.25   90     8.0    pp5    0      3      0.5    .      0      0      0      0      0      0 0 0 -1 1 2 1 pp11 0
;long
i$wsFhorn     +      5.00   78     7.6    pp5    0      16     0.7    1.5    0      0      0      1      0      0 0 0 0 1 2 1 pp11 0

s

;subFrenchHorn--
;tremolo depth is with vibrato if +ve, against it if -ve
;registers: reg0=6.05--8.06 (9.02)  registers are +/- perfect 5ths from this
;          ST   DUR   db  PCH   PCH   AMP PEAK PEAK  VD%  TREMD GLISS PREV  REGI-  OUT
;                               FROM  TO   AMP POINT       dB    TO   GLISS -STR   CH
i$subFhorn    0      -0.25  85     -9.03  -9.00  np4    9      0.2    .5     1.0    0      pp12   0      0    
i$subFhorn    +      -0.25  89     -9.02  pp5    np4    5      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.75  91     -9.01  pp5    np4    0      0.2    .      .      -9.00  .      .      .    
i$subFhorn    +      -0.50  96     -9.00  pp5    np4    -9     0.9    .      .      0      .      .      .	   
i$subFhorn    +      -0.25  89     -8.16  pp5    np4    5      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.15  pp5    np4    6      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.14  pp5    np4    6      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.13  pp5    np4    6      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.12  pp5    np4    6      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.11  pp5    np4    6      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.10  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.09  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.08  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.07  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.06  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.05  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.04  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.03  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.02  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.01  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -8.00  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.15  pp5    np4    5      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.16  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.14  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.13  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.11  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.12  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.09  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.10  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.07  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.08  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.06  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.05  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.03  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.04  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.02  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.00  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -7.01  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.13  pp5    np4    5      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.16  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.14  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.10  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.06  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.12  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.09  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.11  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.07  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.08  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.02  pp5    np4    3      0.2    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.05  pp5    np4    3      0.5    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.03  pp5    np4    3      0.5    .      .      .      .      .      .    
i$subFhorn    +      -0.25  89     -6.04  pp5    np4    3      0.5    .      .      .      .      .      .    
i$subFhorn    +      0.50   86     -6.01  pp5    0      3      0.5    .      .      .      .      .      .    
;register
i$subFhorn    +      0.5    92     -8.00  -8.00  0      0      0.5    .5     .      0      .      -2     0   
i$subFhorn    +      0.5    92     -8.00  -8.00  0      0      0.5    .5     .      0      .      -1     0   
i$subFhorn    +      0.5    92     -8.00  -8.00  0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -8.00  -8.00  0      0      0.5    .5     .      0      .      1      0    
i$subFhorn    +      0.5    92     -8.00  -8.00  0      0      0.5    .5     .      0      .      2      0    
;pitch
i$subFhorn    +      0.5    92     -6.05  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -6.07  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -6.10  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -6.12  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -6.15  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -7.00  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -7.03  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -7.05  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -7.08  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -7.10  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -7.13  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -7.15  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -8.00  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -8.03  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -8.05  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -8.08  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -8.10  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -8.13  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -8.15  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -9.00  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -9.03  pp5    0      0      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    92     -9.05  pp5    0      0      0.5    .5     .      0      .      0      0    
;dB
i$subFhorn    +      0.5    92     -8.00  pp5    0      4      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    86     -8.00  pp5    0      4      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    80     -8.00  pp5    0      4      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    74     -8.00  pp5    0      4      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    68     -8.00  pp5    0      4      0.5    .5     .      0      .      0      0    
i$subFhorn    +      0.5    62     -8.00  pp5    0      4      0.5    .5     .      0      .      0      0    
;expression
i$subFhorn    +      1.5    90     -8.00  pp5    0      4      0.5    1.0    3.0    0      .      0      0    
i$subFhorn    +      1.5    90     -8.00  pp5    0      4      0.5    1.0    -3.0   0      .      0      0    
;long
i$subFhorn    +      5.5    82     -8.00  pp5    0      13     0.5    1.5    1.0    0      .      0      0    

s
i$Tuning      0      0      6    

;subFrenchHorn2--   (noise source)
;registers: reg0=6.05--8.06 (9.02)  registers are +/- perfect 5ths from this
;line widths are in units of quartertones.  next pitch is for pre-marcato
;compression compromises unruly amplitude fluctuations with distortion
;           ST  DUR   db   PCH  PITCH AMP  PEAK PEAK   VD GLISS REG- LINE  PEAK CMPRS PEAK  NEXT  PREV OUT
;                               FROM  TO   AMP  POINT      TO   ISTR WIDTH  LW        CMPRS PITCH GLIS CH
i$subFhorn2   0      -0.25  88     9.0    9.0    np4    3      0.3    .5     0      0      0.5    .5     1.0    0.5 np5 pp11 0
i$subFhorn2   +      -0.25  88     8.7    pp5    np4    6      0.3    .5     0      .      .      .      <      < . . .
i$subFhorn2   +      -0.25  88     8.5    pp5    np4    3      0.3    .5     0      .      .      .      <      < . . .
i$subFhorn2   +      -0.75  88     8.0    pp5    np4    6      0.3    .      8.0    .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     8.3    pp5    np4    6      0.3    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     8.2    pp5    np4    6      0.3    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     8.1    pp5    np4    6      0.3    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     8.0    pp5    np4    6      0.3    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     7.7    pp5    np4    3      0.3    .      0      .      .      .      <      < . . .
i$subFhorn2   +      -0.25  88     7.5    pp5    np4    3      0.3    .      0      .      .      .      <      < . . .
i$subFhorn2   +      -0.25  88     7.4    pp5    np4    3      0.4    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     7.3    pp5    np4    3      0.4    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     7.2    pp5    np4    3      0.4    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     7.1    pp5    np4    3      0.4    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     7.0    pp5    np4    3      0.5    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     6.7    pp5    np4    3      0.3    .      0      .      .      .      <      < . . .
i$subFhorn2   +      -0.25  88     6.5    pp5    np4    3      0.3    .      0      .      .      .      <      < . . .
i$subFhorn2   +      -0.25  88     6.4    pp5    np4    3      0.5    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     6.3    pp5    np4    3      0.5    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     6.2    pp5    np4    3      0.5    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      -0.25  88     6.1    pp5    np4    3      0.5    .      0      .      .      .      <      < . . . 
i$subFhorn2   +      0.50   88     6.0    pp5    np4    3      0.5    .      0      .      .      .      0.5    1.0 . . . 
;register
i$subFhorn2   +      0.50   85     8.0    pp5    0      6      0.5    .      0      -2     .      .      .2     0.7 . . .
i$subFhorn2   +      0.50   85     8.0    pp5    0      6      0.5    .      0      -1     .      .      .2     0.7 . . .
i$subFhorn2   +      0.50   85     8.0    pp5    0      6      0.5    .      0      0      .      .      .2     0.7 . . .
i$subFhorn2   +      0.50   85     8.0    pp5    0      6      0.5    .      0      1      .      .      .2     0.7 . . .
i$subFhorn2   +      0.50   85     8.0    pp5    0      6      0.5    .      0      2      .      .      .2     0.7 . . .
;pitch
i$subFhorn2   +      0.50   88     9.1    pp5    0      4      0.5    .      0      0      .      .      1.0    1.5 . . .
i$subFhorn2   +      0.50   88     9.0    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     8.7    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     8.0    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     8.6    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     8.1    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     8.5    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     8.2    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     8.4    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     8.3    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     7.7    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     7.0    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     7.6    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     7.1    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     7.5    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     7.2    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     7.4    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     7.3    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     6.7    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     6.6    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     6.5    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     6.2    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     6.4    pp5    0      4      0.5    .      0      0      .      .      <      < . . .
i$subFhorn2   +      0.50   88     6.3    pp5    0      4      0.5    .      0      0      .      .      1.0    0.5 . . .
;dB
i$subFhorn2   +      0.25   92     7.3    pp5    0      2      0.5    .      0      0      .      .      0.7    1.0 . . .
i$subFhorn2   +      0.25   86     7.3    pp5    0      4      0.5    .      0      0      .      .      0.7    1.0 . . .
i$subFhorn2   +      0.25   80     7.3    pp5    0      4      0.5    .      0      0      .      .      0.7    1.0 . . .
i$subFhorn2   +      0.25   74     7.3    pp5    0      4      0.5    .      0      0      .      .      0.7    1.0 . . .
i$subFhorn2   +      0.25   68     7.3    pp5    0      4      0.5    .      0      0      .      .      0.7    1.0 . . .
i$subFhorn2   +      0.25   62     7.3    pp5    0      4      0.5    .      0      0      .      .      0.7    1.0 . . .
;long
i$subFhorn2   +      5.50   78     6.6    pp5    0      14     0.9    2.0    0      0      0      1      0.7    1.5 . . .

s

;fofFrenchHorn--  
;legato tags: 0=single, 1=first, 2=tied, 3=last
;registers: reg0=6.05--8.06 (9.02)  registers are +/- perfect 5ths from this
;suggested maximum spectral tremolo depth is 1.0 (spectral tremolo is linked to vibrato)
;            ST   DUR  LEGATO  db    PCH     PITCH   AMP  PEAK  PEAK    VD GLISS  REG-  PEAK  SPECT PREV  OUT
;                       TAG                  FROM    TO    AMP  POINT       TO    ISTR  RGSTR TREMD GLISS CH
i$fofFhorn    0      0.309  1      85     -9.00  -9.0   np5    5      0.309  .5     0      0      0      0      pp12 0
i$fofFhorn    +      0.191  2      85     -8.18  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.15  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.17  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.16  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.14  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.11  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.13  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.12  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.10  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.07  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.09  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.08  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.06  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.03  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.05  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.04  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.02  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.17  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -8.01  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -8.00  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.18  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.15  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.17  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.16  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.14  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.11  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.13  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.12  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.10  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.07  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.09  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.08  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.06  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.03  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.05  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.04  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.02  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -6.17  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -7.01  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -7.00  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -6.18  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -6.15  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -6.17  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -6.16  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -6.14  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -6.11  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -6.13  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -6.12  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -6.10  pp6    np5    3      0.309  .      0      .      .      .      .    
i$fofFhorn    +      0.309  2      85     -6.07  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.191  2      85     -6.09  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.309  2      85     -6.08  pp6    np5    3      0.309  .      0      .      .      .    
i$fofFhorn    +      0.50   3      85     -6.05  pp6    np5    5      0.309  .      0      .      .      .    
;register
i$fofFhorn    +      0.50   0      80     -8.00  pp6    np5    5      0.309  .      0      -2     -2     .   
i$fofFhorn    +      0.50   0      80     -8.00  pp6    np5    5      0.309  .      0      -1     -1     .   
i$fofFhorn    +      0.50   0      80     -8.00  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      80     -8.00  pp6    np5    5      0.309  .      0      1      1      .    
i$fofFhorn    +      0.50   0      80     -8.00  pp6    np5    5      0.309  .      0      2      2      .    
;pitch
i$fofFhorn    +      0.50   0      85     -9.00  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -8.18  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -8.15  pp6    np5    4      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -8.12  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -8.09  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -8.06  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -8.03  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -7.17  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -7.14  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -7.11  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -7.08  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -7.05  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -7.02  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -6.16  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -6.13  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -6.10  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -6.07  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -6.04  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -6.01  pp6    np5    5      0.309  .      0      0      0      .    
;dB
i$fofFhorn    +      0.50   0      90     -8.00  pp6    np5    6      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      85     -8.00  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      80     -8.00  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      75     -8.00  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      70     -8.00  pp6    np5    5      0.309  .      0      0      0      .    
i$fofFhorn    +      0.50   0      65     -8.00  pp6    np5    5      0.309  .      0      0      0      .    
;expression
i$fofFhorn    +      1.50   0      85     -8.00  pp6    np5    5      0.309  1.0    0      0      0      .    
i$fofFhorn    +      1.50   0      85     -8.00  pp6    np5    5      0.309  1.0    0      0      .2     .   
i$fofFhorn    +      1.50   0      85     -8.00  pp6    np5    5      0.309  1.0    0      0      -.2    .  
i$fofFhorn    +      1.50   0      85     -8.00  pp6    np5    5      0.309  1.0    0      0      0      1.0  
i$fofFhorn    +      1.50   0      85     -8.00  pp6    np5    5      0.309  1.0    0      0      0      3.0  
;long
i$fofFhorn    +      5.50   0      80     -8.00  pp6    np5    15     0.809  1.5    0      0      0      0.3  



e