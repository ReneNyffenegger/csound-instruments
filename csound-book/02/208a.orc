  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 208
  idur      =  p3
  iamp      =  p4
  icarfrq   =  p5
  imodfrq   =  p6          
  aenv      expseg    .01, idur*.1, iamp, idur*.8, iamp*.75, idur*.1, .01
  i1        =  p7*imodfrq                         ; p7=MOD. INDEX START
  i2        =  p8*imodfrq                         ; p8=MOD. INDEX END
  adev      line      i1, idur, i2                ; MODULATION FREQUENCY
  aindex    line      p7, idur, p8                ; MODULATION INDEX
; r VALUE ENVELOPE: p9-p10 = EXP. PARTIAL STRENGTH PARAMETER START AND END
  ar        linseg    1, .1, p9, p3-.2, p10, .1, 1
  amp1      =  (aindex*(ar+(1/ar)))/2
  afmod     oscili    amp1, imodfrq, 1            ; FM MODULATOR (SINE)
  atab      =  (aindex*(ar-(1/ar)))/2             ; INDEX TO TABLE
  alook     tablei    atab, 37                    ; TABLE LOOKUP TO GEN12
  aamod     oscili    atab, adev, 2               ; AM MODULATOR (COSINE)
  aamod     =  (exp(alook+aamod))*aenv
  acar      oscili    aamod, afmod+icarfrq, 1     ; AFM (CARRIER)
  asig      balance   acar, aenv
            out       asig
endin       
