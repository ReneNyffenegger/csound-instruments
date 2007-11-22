;*******************************************************;
;        PITCH CHANGING INSTRUMENT WITH PITCH BEND      ;
;                                                 ;
;    P4 = AMPLITUDE FACTOR                   ;
;    P5 = DESIRED STARTING PITCH IN PCH           ;
;    P6 = OLD PITCH IN PCH                   ;
;    P7 = FUNCTION NUMBER OF SOUNDIN FILE         ;
;    P8 = MAXIMUM AMOUNT OF PITCH BEND IN OCT     ;
;    P9 = FUNCTION NO. OF PITCH BEND              ;
;    P10 = SECONDS OF DELAY BEFORE PITCH BENDS    ;
;    N.B.  P9 MUST ALWAYS BE A RISING FUNCTION.   ;
; IF A DOWNWARD PITCH BEND IS DESIRED MAKE P8 NEGATIVE.     ;
;*******************************************************;
  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1
;
instr     1
  ioctnew   =  octpch(p5)
  icpsold   =  cpspch(p6)
  ioldsr    =  20000
  kchng     oscil1i   p10, p8, p3, p9
  kcpsnew   =  cpsoct (ioctnew + kchng)
  kincr     =  ioldsr/sr * kcpsnew/icpsold
  kphase    init      0                           ;INITIALIZE PHASE
  aphase    interp    kphase                      ;CONVERT TO ARATE
  asig      tablei    aphase,p7                   ;RESAMPLE THE SOUND
  kphase    =  kphase+kincr*ksmps                 ;UPDATE FOR NEXT K
  asignal   envlpx    asig*p4,.001,p3,(p3-.001),23,1,.1
            out       asignal
endin

