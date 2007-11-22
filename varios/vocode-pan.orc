
;SCOTT LINDROTH                    DUKE UNIVERSITY MUSIC DEPARTMENT
;(919) 660-3307 (OFFICE)              BOX 90665
;(919) 660-3301 (FAX)                 DURHAM, NC 27708-0665


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr     1    ;SEPARATE EVEN AND ODD HARMONICS

     ;TAKE AN INPUT SIGNAL AND PASS IT THROUGH A BANK OF BANDPASS FILTERS.
     ;USE THE AMPLITUDE ENVELOPES OF THESE FILTERS TO SCALE THE AMPLITUDES
     ;OF A BANK OF SINUSOIDS.  
          
     ;PLACE THE ODD HARMONICS IN THE LEFT CHANNEL AND THE EVEN HARMONICS
     ;IN THE RIGHT CHANNEL.  APPLY INDEPENDENT PAN MOTIONS.
     
  icpsin    =  cpspch(p4)                         ;INPUT ANLAYSIS FUNDAMENTAL FREQ.
  ibndbeg   =  p5                                 ;STARTING BANDWIDTH OF BANDPASS FILTER
  ibndend   =  p6                                 ;DESTINATION BANDWIDTH OF BANDPASS FILTER
  icpsout   =  cpspch(p7)                         ;OUTPUT FUNDAMENTAL FREQUENCY
  ivibfreq  =  p8
  ivibdpth  =  p9
  idel      =  p10                                ;DELAY MULTIPLIER FOR HARMONICS
  ipanleft  =  p11                                ;PAN FREQUENCY FOR ODD HARMONICS
  ipanright =  p12                                ;PAN FREQUENCY FOR EVEN HARMONICS
  iamp      =  p13
  iskip     =  p14
  iglissoffset =      cpspch( p4 + p15)
  iglisstime   =      p16
          
     ;--------OVERALL ENVELOPE
     
  kenv      linen     iamp, .5, p3, .5
     
     ;--------INPUT SIGNALS
     
  ainput    diskin    "speech1.aif", 1, iskip

     ;---------BANDWIDTH CHANGES
     
  kbnd      linseg    ibndbeg, p3 * .7, ibndend
     
     ;---------VIBRATO ON CF

  kvibcf    oscili    200, 1.4, 1
  kcpsin    linseg    icpsin, p3*.2, icpsin, p3*iglisstime, iglissoffset
     
     ;---------BAND PASS FILTER BANK
     
  a1        butterbp  ainput, kcpsin + kvibcf, kbnd
  a2        butterbp  ainput, kcpsin*2+kvibcf, kbnd
  a3        butterbp  ainput, kcpsin*3+kvibcf, kbnd
  a4        butterbp  ainput, kcpsin*4+kvibcf, kbnd
  a5        butterbp  ainput, kcpsin*5+kvibcf, kbnd
  a6        butterbp  ainput, kcpsin*6+kvibcf, kbnd
  a7        butterbp  ainput, kcpsin*7+kvibcf, kbnd
  a8        butterbp  ainput, kcpsin*8+kvibcf, kbnd
  a9        butterbp  ainput, kcpsin*9+kvibcf, kbnd
  a10       butterbp  ainput, kcpsin*10+kvibcf, kbnd
  a11       butterbp  ainput, kcpsin*11+kvibcf, kbnd
  a12       butterbp  ainput,   kcpsin*12+kvibcf, kbnd
  a13       butterbp  ainput, kcpsin*13+kvibcf, kbnd
  a14       butterbp  ainput, kcpsin*14+kvibcf, kbnd
  a15       butterbp  ainput, kcpsin*15+kvibcf, kbnd
  a16       butterbp  ainput, kcpsin*16+kvibcf, kbnd

     ;---------GET RMS POWER OF EACH BAND
     
  krms1     rms       a1, 5
  krms2     rms       a2, 5
  krms3     rms       a3, 5
  krms4     rms       a4, 5
  krms5     rms       a5, 5
  krms6     rms       a6, 5
  krms7     rms       a7, 5
  krms8     rms       a8, 5
  krms9     rms       a9, 5
  krms10    rms       a10, 5
  krms11    rms       a11, 5
  krms12    rms       a12, 5
  krms13    rms       a13, 5
  krms14    rms       a14, 5
  krms15    rms       a15, 5
  krms16    rms       a16, 5

     ;---------APPLY GLISS TO THE CARRIER

  kglis1    linseg    icpsout, p3*.2, icpsout, p3*iglisstime, iglissoffset
     
     ;---------APPLY VIBRATO TO CARRIER

  kvib1     oscil     ivibdpth, ivibfreq, 1       ;f1 = sine vibrato
  kcpsout   =  kglis1 + kvib1
;kcpsout  =         icpsout + kvib1
     
  acar1     oscili    krms1, kcpsout, 1
  acar2     oscili    krms2, kcpsout*2, 1
  acar3     oscili    krms3, kcpsout*3, 1
  acar4     oscili    krms4, kcpsout*4, 1
  acar5     oscili    krms5, kcpsout*5, 1
  acar6     oscili    krms6, kcpsout*6, 1
  acar7     oscili    krms7, kcpsout*7, 1
  acar8     oscili    krms8, kcpsout*8, 1
  acar9     oscili    krms9, kcpsout*9, 1
  acar10    oscili    krms10, kcpsout*10, 1
  acar11    oscili    krms11, kcpsout*11, 1
  acar12    oscili    krms12, kcpsout*12, 1
  acar13    oscili    krms13, kcpsout*13, 1
  acar14    oscili    krms14, kcpsout*14, 1
  acar15    oscili    krms15, kcpsout*15, 1
  acar16    oscili    krms16, kcpsout*16, 1

if        (idel == 0) goto output
     
  acar2     delay     acar2, idel
  acar3     delay     acar3, idel*2
  acar4     delay     acar4, idel*3
  acar5     delay     acar5, idel*4
  acar6     delay     acar6, idel*5
  acar7     delay     acar7, idel*6
  acar8     delay     acar8, idel*7
  acar9     delay     acar9, idel*8
  acar10    delay     acar10, idel*9
  acar11    delay     acar11, idel*10
  acar12    delay     acar12, idel*11
  acar13    delay     acar13, idel*12
  acar14    delay     acar14, idel*13
  acar15    delay     acar15, idel*14
  acar16    delay     acar16, idel*15
     
output:
     
     ;---------ASSEMBLE OUTPUT
     
  kpan1     oscil     1, ipanleft, 2
  kpan2     oscil     1, ipanright, 2

;BP AUDIO SIGNALS
     
;aleft1   =         a1+a3+a5+a7+a9+a11+a13+a15
;aright1  =         a2+a4+a6+a8+a10+a12+a14+a16

     
     ;SINE TONE CARRIERS WITH EITHER DELAYED OR SYNCHRONIZED HARMONICS

  aleft1    =  acar1+acar3+acar5+acar7+acar9+acar11+acar13+acar15
  aright1   =  acar2+acar4+acar6+acar8+acar10+acar12+acar14+acar16
               
  aleft     butterlp  aleft1, sr * 0.5
  aright    butterlp  aright1, sr * 0.5
                                        
          ;ODD HARMONICS START LEFT AND MOVE RIGHT
          ;EVEN HARMONICS START RIGHT AND MOVE LEFT

            outs1     (aleft * kenv * kpan1) + (aright * kenv * (1-kpan2))
            outs2     (aright * kenv * kpan2) + (aleft * kenv * (1-kpan1))
     
endin
