  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

;=======================================================================;
;       Granular Synthesis Instruments for Time Scaling                 ;
;                                                                       ;
; The idea behind these instruments is that an input sound file is      ;
; copied to an output sound file one "grain" at a time. The grains      ;        
; are always placed one right after the other on the output file, but   ;
; they may be read from the input file at different time intervals      ;
; (increments). To stretch a sound, the increment should be less than   ;
; the grain length; to shrink a sound, the increment should be more     ;
; than the grain length. The input increment (and resulting amount of   ;
; time scaling) is determined by the "time factor." If the time factor  ;
; is 1, the input increment will equal the grain length, so there is no ;
; change in the duration of the output file; if it is between 0 and 1,  ;
; the sound will be made longer; if > 1, the sound will be shortened.   ;
;                                                                       ;
; The grain length is very important, with the ideal length depending   ;
; on the nature of the input sound and the amount of time scaling. For  ;
; musical sounds (i.e., pitched), the grain length needs to be at least ;
; as long as the period of the lowest frequency present, or the grain   ;
; length itself will determine the perceived fundamental. The longer    ;
; the grain, however, the more obvious the "echo" side-effects will be. ;
;                                                                       ;
; Note that the kr=sr in this orchestra, which is probably a little     ; 
; higher than absolutely necessary. However, the kr does need to be     ;
; high if you are using small grain sizes and/or multiple overlapping   ;
; grains, since you can't get finer resolution than (ksmps/sr)th sec.   ;
; Written by Russell Pinkston, 2/24/99                                  ;
;=======================================================================;

instr   1       ;simple fixed time scaling instrument
  iamp      =  p4
  itimfac   =  p5                                 ;time stretch factor
  inptr     =  0                                  ;the input pointer
  igrlen    =  p8                                 ;the grain length in seconds
  ifn       =  p9                                 ;source sound file
  iwinfn    =  p10                                ;grain window function
; Compute input grain increment in samples
  iptrinc   =  igrlen*itimfac*sr
; Grain generator
start:
  kptr      init      inptr                       ;start position for table read
  inptr     =  inptr+iptrinc                      ;increment for next grain
  kwin      oscil1i   0,1,igrlen,iwinfn
            timout    0,igrlen,continue
            reinit    start
            rireturn  
continue:
  aphase    interp    kptr
  asig      tablei    aphase,ifn
  kptr      =  kptr+ksmps
  asignal   linen     asig*kwin*iamp,p6,p3,p7
            out       asignal
endin
;------------------------------------------------------------------------;
instr   2       ;dual window fixed time scaling instrument
  iamp      =  p4
  itimfac   =  p5                                 ;time stretch factor
  igrlen    =  p8                                 ;the grain length in seconds
  ifn       =  p9                                 ;source sound file
  iwinfn    =  p10                                ;grain window function
; Compute input grain increment in samples
  iptrinc   =  igrlen*itimfac*sr
  inptr     =  0                                  ;the input pointer
  ioffset   =  igrlen/2*sr                        ;offset for second pointer
;first grain generator
start1:
  kptr1     init      inptr                       ;start position for table read
  kwin1     oscili    1,1/igrlen,iwinfn,0
            timout    0,igrlen,continue1
            reinit    start1
            rireturn  
continue1:
;second grain generator (1/2 grain delay)
            timout    0,igrlen/2,continue2        ;wait 1/2 grain length
start2:
  kptr2     init      inptr+ioffset               ;start position for table read
  inptr     =  inptr+iptrinc                      ;increment for next grain
  kwin2     oscili    1,1/igrlen,iwinfn,0
            timout    0,igrlen,continue2
            reinit    start2
            rireturn  
continue2:
  aphs1     interp    kptr1
  asig1     tablei    aphs1,ifn
  aphs2     interp    kptr2
  asig2     tablei    aphs2,ifn
  asig      =  asig1*kwin1+asig2*kwin2
  kptr1     =  kptr1+ksmps
  kptr2     =  kptr2+ksmps
  asignal   linen     asig*iamp,p6,p3,p7
            out       asignal
endin
;----------------------------------------------------------------;      
instr   3               ;Variable time scaling instrument
  iamp      =  p4
  itimfn    =  p5                                 ;time stretch function number
  igrlen    =  p8                                 ;the grain length in seconds
  ifn       =  p9                                 ;source sound file
  iwinfn    =  p10                                ;grain window function
  igrsize   =  igrlen*sr                          ;the grain length in samples
  inptr1    =  0                                  ;initialize the input pointer
  ioffset   =  igrlen/2*sr                        ;offset for the second pointer
  inptr2    =  inptr1+ioffset

;Variable time stretch control
  ktfac     oscil1i   0,1,p3,itimfn

start1:
  kptr1     init      inptr1                      ;start position for table read
  iptrinc   =  i(ktfac)*igrsize
  inptr1    =  inptr1+iptrinc                     ;increment for next grain
  kwin1     oscili    1,1/igrlen,iwinfn,0
            timout    0,igrlen,continue1
            reinit    start1
            rireturn  
continue1:
            timout    0,igrlen/2,continue2        ;initial wait
start2:
  kptr2     init      inptr2                      ;maintain separate pointers
  iptrinc   =  i(ktfac)*igrsize
  inptr2    =  inptr2+iptrinc                     ;increment for next grain
  kwin2     oscili    1,1/igrlen,iwinfn,0
            timout    0,igrlen,continue2
            reinit    start2
            rireturn  
continue2:

  aphs1     interp    kptr1
  asig1     tablei    aphs1,ifn
  aphs2     interp    kptr2
  asig2     tablei    aphs2,ifn
  asig      =  asig1*kwin1+asig2*kwin2
  kptr1     =  kptr1+ksmps
  kptr2     =  kptr2+ksmps
  asignal   linen     asig*iamp,p6,p3,p7
            out       asignal
endin
;---------------------------------------------------------------------;
instr   4               ;quad window variable time scaling 
  iamp      =  p4
  itimfn    =  p5                                 ;time stretch function number
  igrlen    =  p8                                 ;the grain length in seconds
  ifn       =  p9                                 ;source sound file
  iwinfn    =  p10                                ;grain window function
  igrsize   =  igrlen*sr                          ;the grain length in samples
  inptr1    =  0                                  ;initialize the input pointers
  inptr2    =  .25*igrsize                        ;ptr2 at 25% of grain length
  inptr3    =  .5*igrsize                         ;ptr3 at 50%
  inptr4    =  .75*igrsize                        ;ptr4 at 75%

;Variable time stretch control
  ktfac     oscil1i   0,1,p3,itimfn

start1:
  kptr1     init      inptr1                      ;start position for table read
  iptrinc   =  i(ktfac)*igrsize
  inptr1    =  inptr1+iptrinc                     ;increment for next grain
  kwin1     oscili    1,1/igrlen,iwinfn,0
            timout    0,igrlen,continue1
            reinit    start1
            rireturn  
continue1:
            timout    0,.25*igrlen,continue2      ;initial wait
start2:
  kptr2     init      inptr2                      ;start position for table read
  iptrinc   =  i(ktfac)*igrsize
  inptr2    =  inptr2+iptrinc                     ;increment for next grain
  kwin2     oscili    1,1/igrlen,iwinfn,0
            timout    0,igrlen,continue2
            reinit    start2
            rireturn  
continue2:
            timout    0,.5*igrlen,continue3       ;initial wait
start3:
  kptr3     init      inptr3                      ;start position for table read
  iptrinc   =  i(ktfac)*igrsize
  inptr3    =  inptr3+iptrinc                     ;increment for next grain
  kwin3     oscili    1,1/igrlen,iwinfn,0
            timout    0,igrlen,continue3
            reinit    start3
            rireturn  
continue3:
            timout    0,.75*igrlen,continue4      ;initial wait
start4:
  kptr4     init      inptr4                      ;start position for table read
  iptrinc   =  i(ktfac)*igrsize
  inptr4    =  inptr4+iptrinc                     ;increment for next grain
  kwin4     oscili    1,1/igrlen,iwinfn,0
            timout    0,igrlen,continue4
            reinit    start4
            rireturn  
continue4:
  aphs1     interp    kptr1
  asig1     tablei    aphs1,ifn
  aphs2     interp    kptr2
  asig2     tablei    aphs2,ifn
  aphs3     interp    kptr3
  asig3     tablei    aphs3,ifn
  aphs4     interp    kptr4
  asig4     tablei    aphs4,ifn
  asig      =  asig1*kwin1+asig2*kwin2+asig3*kwin3+asig4*kwin4
  kptr1     =  kptr1+ksmps
  kptr2     =  kptr2+ksmps
  kptr3     =  kptr3+ksmps
  kptr4     =  kptr4+ksmps
  asignal   linen     asig*iamp,p6,p3,p7
            out       asignal
endin
