  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

;===============================================
;Crude schedule instrument for testing purposes
;We'll make a better one on Thursday.
;===============================================

instr   1
  iampfn    =  p4
  idurfn    =  p5
  itimefn   =  p6
  ighzfn    =  p7
  ipitfn    =  p8
  ipanfn    =  p9
  isrcfn    =  p10
  idatafn   =  p11
  ienvfn    =  p12
  ifn1      =  p13                                ;first sound file function table
  kpoint    line      0,p3,1                      ;master pointer for all table lookups
start:
  ipoint    =  i(kpoint)
  ifreq     tablei    ipoint,ighzfn,1
  intvl     =  (ifreq > 0 ? 1/ifreq : 100)        ;avoid divide by zero
  itptr     tablei    ipoint,itimefn,1
  idur      tablei    ipoint,idurfn,1
  iamp      tablei    ipoint,iampfn,1
  ipshift   tablei    ipoint,ipitfn,1
  ipan      tablei    ipoint,ipanfn,1
  isfn      table     ipoint,isrcfn,1
  ifndata   =  (int(isfn)-ifn1)*4                 ;compute pointer into data table for sound files 
  istart    table     ifndata,idatafn
  iend      table     ifndata+1,idatafn
  idirect   table     ifndata+2,idatafn
  iwrap     table     ifndata+3,idatafn
  isfdur    =  nsamp(isfn)/sr
  iskip     =  itptr*isfdur
;       print   itptr,iskip,idur,iamp,ipshift,ipan,isfn,istart,iend,idirect,iwrap
            timout    0,intvl,continue
            reinit    start
continue:
;                       ins,start,dur, amp,pshift,iskip,sfn,ipan,istart,iend,idirect,iwrap,ienvfn
;       schedule        2,   .001,.05,10000,    1,iskip,    2,  .5,     0, 1.47,      1,    1, 1
            schedule  2,.001,idur,iamp,ipshift,iskip,isfn,ipan,istart,iend,idirect,iwrap,ienvfn
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



