;***************************************************************;
;    KREIGERESQUE ORCHESTRA NO. 1                 ;
;    P3  =  OVERALL DURATION                      ;
;    P4  =  AMPLITUDE                        ;
;    P5  =  BASE FREQUENCY IN PCH                 ;
;    P6  =  BASE TRILL RATE                       ;
;    P7  =  FASTEST TRILL RATE                    ;
;    P8  =  FUNCTION NUMBER FOR  RATE OF TRILL CHANGE  ;
;    P9  =   MODULATOR RATIO                      ;
;    P10 =  MAX INDEX                        ;
;    P11 = FUNCTION NUMBER FOR INDEX SHAPE             ;
;    P12 = STRETCH FACTOR FOR PLUCK                    ;
;    P13 = DECAY TIME FACTOR FO OVERALL ENVELOPE       ;
;***************************************************************;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
               
instr     1

  ibase     =  p6
  ichange   =  p7 - p6
  kchg      oscil1i   0.00, ichange, p3, p8
  krate     =  ibase + kchg
  ioct      =  octpch(p5)
  kdist     oscil     1/12, krate, 6              ;  FUNCTION 6 = ANGLED SQUARE WAVE
  kcps      =  cpsoct(ioct + kdist)
  asnd      pluck     p4, kcps, (cpspch(p5)), 0, 2, (p12+1.00)
  aenv      envlpx    asnd, 0.3, p3, (p3 * p13), 2, .7, .01
  kndx      oscil1i   0.00, p10, p3, p11
  asnd2     foscili   (p4*.23), kcps, 1, p9, kndx, 1
  aenv2     envlpx    asnd2, (p3 * (1-p13)), p3, (p3 * p13), 2, .7, .01
            out       aenv + aenv2
endin

