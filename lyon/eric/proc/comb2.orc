  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
; stereo comb filtered soundfile

instr 100
  gaout1    =  0
  gaout2    =  0
endin
instr 1
  gasrc1, gasrc2      soundin                     p4,p5
endin
;i1 0 dur file skip
;i2 0 dur freq freq2 revtime iamp
instr 2
  ilpt1     =  1.0/p4
  ilpt2     =  1.0/p5
  irvt      =  p6
  iamp      =  p7*.3 
  aenv      linseg    0,p3/2,iamp,p3/2,0
  acomb1    comb      gasrc1, irvt, ilpt1
  acomb2    comb      gasrc2, irvt, ilpt2
  gaout1    =  gaout1 + (acomb1*aenv)
  gaout2    =  gaout2 + (acomb2*aenv)
            outs      acomb1*aenv, acomb2*aenv
endin

instr 3
  irolloff  =  80
  aout1     atone     gaout1,irolloff
  aout2     atone     gaout2,irolloff
            outs      aout1, aout2
  gaout1    =  0
  gaout2    =  0
endin
