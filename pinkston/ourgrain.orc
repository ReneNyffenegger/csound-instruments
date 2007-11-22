  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;===============================================
;Crude schedule instrument for testing purposes
;We'll make a better one on Thursday.
;===============================================

instr   1
  kfreq     linseg    3,p3/2,200,p3/2,3
  kstart    line      1.47,p3,0
start:
  intvl     =  i(1/kfreq)
  iskip     =  i(kstart)
            timout    0,intvl,continue
            reinit    start
continue:
;                       ins,start,dur, amp,pshift,iskip,srcfn,ipan,istart,iend,idirect,iwrap,ienvfn
            schedule  2,   .001,.05,5000,     1,iskip,    2,  .5,     0, 1.4,      1,    1, 1
endin

;==========================================
; Sophisticated stereo grain generator
; Designed communally on Tuesday, 1/29/2002
; We didn't provide any defaults and the
; wrap flag still needs implementing...
;==========================================

instr   2
  idur      =  p3
  iamp      =  p4
  ipshift   =  p5
  iskipin   =  p6*sr                              ;convert seconds to samples
  isrcfn    =  p7
  ipan      =  p8
  istart    =  p9*sr   
  iend      =  p10*sr
  idirect   =  p11
  iwrap     =  p12
  ienvfn    =  p13

  ileft     =  sqrt(1-ipan)
  iright    =  sqrt(ipan)

  isize     =  iend-istart
  iendsmp   =  idur*sr*ipshift                    ;cvt dur to samples times shift factor
  ipt1      =  (idirect < 0 ? iendsmp : 0)
  ipt2      =  (idirect < 0 ? 0 : iendsmp)
  aindex    line      ipt1,idur,ipt2
  aindex    =  (aindex+iskipin) % isize
  aindex    =  istart+aindex
  asig      tablei    aindex,isrcfn
  aenv      oscili    iamp,1/idur,ienvfn,0
  aout      =  asig*aenv
            outs      aout*ileft,aout*iright
endin



