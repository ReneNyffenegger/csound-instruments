  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
; comb filtered soundfile


instr 1
  gasrc     soundin   p4,p5
endin
;i1 0 dur file skip
;i2 0 dur freq revtime iamp
;i1 0 dur file skip
;i2 0 dur freq freq2 revtime iamp
instr 2
  ilpt1     =  1.0/p4
  ilpt2     =  1.0/p5
  irvt      =  p6
  iamp      =  p7*.3 
  aenv      linseg    0,p3/2,iamp,p3/2,0
  acomb1    comb      gasrc, irvt, ilpt1
  acomb2    comb      gasrc, irvt, ilpt2
        ;gaout1 = gaout1 + (acomb1*aenv)
        ;gaout2 = gaout2 + (acomb2*aenv)
            outs      acomb1*aenv, acomb2*aenv
endin


;instr 3
;ilpt = 1.0/p4
;irvt = p5
;iamp = p6 * .1
;       kenv linseg 0,p3/2,iamp,p3/2,0
;       acomb comb gasrc, irvt, ilpt
;       out acomb*kenv
;endin
