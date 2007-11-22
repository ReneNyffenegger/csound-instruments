  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;======================================================
; Simple schedule instrument that plays three notes
;======================================================
instr   1
  idur      =  p3      
  iamp      =  p4
  ipitch1   =  cpspch(p5)
  ipitch2   =  ipitch1*2                          ;up an octave
  ipitch3   =  ipitch2*2                          ;up two octaves 
  istart1   =  p6                                 ;staggered starts
  istart2   =  p7
  istart3   =  p8
  ipan1     =  0                                  ;right
  ipan2     =  .5                                 ;center
  ipan3     =  1                                  ;left
  insno     =  10      
            schedule  insno,istart1,idur,iamp,ipitch1,ipan1
            schedule  insno,istart2,idur,iamp,ipitch2,ipan2
            schedule  insno,istart3,idur,iamp,ipitch3,ipan3
endin
;====================================================================
; Schedule instrument that uses reinit for each new schedule call
;====================================================================
instr   2
  ipkamp    =  p4
  ipitch    =  octpch(p5)
  insno     =  p6
  idurfn    =  p7
  iampfn    =  p8
  ipitfn    =  p9
  ipanfn    =  p10
;control functions (run continuously)
  kdur      oscil1i   0,1,p3,idurfn
  kamp      oscil1i   0,ipkamp,p3,iampfn
  koct      oscil1i   0,ipitch,p3,ipitfn
  kpan      oscil1i   0,1,p3,ipanfn
;the reinitialization block
start:
            timout    0, i(kdur), continue
            reinit    start
continue:               
  icps      =  cpsoct(i(koct))                    ;set the next pitch
;and schedule it:       no      p2      p3      p4      p5      p6
            schedule  insno, .0001, i(kdur), i(kamp), icps, i(kpan)
;Note: the start time (p2) can't be zero with reinit(bug in schedule)
endin

;=============================================================
; Variant of instr 2 using schedkwhen instead of timout/reinit
;=============================================================

instr   3
  ipkamp    =  p4
  ipitch    =  octpch(p5)
  insno     =  p6
  idurfn    =  p7
  iampfn    =  p8
  ipitfn    =  p9
  ipanfn    =  p10
  itrig     =  1                                  ;just turn it on
  imaxins   =  0                                  ;no maximum number of notes
;control functions:
  kdur      oscil1i   0,1,p3,idurfn
  kamp      oscil1i   0,ipkamp,p3,iampfn
  koct      oscil1i   0,ipitch,p3,ipitfn
  kpan      oscil1i   0,1,p3,ipanfn
            schedkwhen  itrig,kdur,imaxins,insno,0,kdur,kamp,cpsoct(koct),kpan
endin

instr   10      ;slave instrument (simple beep with panning)
  iamp      =  p4
  icps      =  p5
  iright    =  sqrt(p6)
  ileft     =  sqrt(1-p6)
  kamp      linen     iamp,p3*.01,p3,p3*.75
  asig      oscili    kamp,icps,1                 ;sine wave in fn1
            outs      asig*ileft,asig*iright
endin