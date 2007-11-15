  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;i1 0 dur file skip fadeout gain ; on-off
;i2 0 dur file skip atk dk gain  ; insert
;i3 0 dur file skip fadein  gain ; off-on

instr 1         ;fade out
  ifile     =  p4
  iskip     =  p5
  ifade     =  p6
  isust     =  p3-ifade
  igain     =  p7
  aenv      linseg    igain,isust,igain,ifade,0
  a1,a2     soundin   ifile,iskip
            outs      a1*aenv,a2*aenv
endin

instr 3         ;fade in
  ifile     =  p4
  iskip     =  p5
  ifade     =  p6
  isust     =  p3-ifade
  igain     =  p7
  aenv      linseg    0,ifade,igain,isust,igain
  a1,a2     soundin   ifile,iskip
            outs      a1*aenv,a2*aenv
endin


instr 2         ;insert
  ifile     =  p4
  iskip     =  p5
  iatk      =  p6
  idk       =  p7
  isust     =  p3-(iatk+idk)
  igain     =  p8
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
  a1,a2     soundin   ifile,iskip
            outs      a1*aenv,a2*aenv
endin

instr 4         ;arbitrary envelope
  ifile1    =  2
  ifile2    =  1
  iskip1    =  44
  iskip2    =  44
  iv1       =  1
  iv2       =  .0
  aenv1     linseg    iv1,.1,iv1,.4,iv2,5.0,iv2,.4,iv1,.1,iv1
  aenv2     =  1.0-aenv1
  a1,a2     soundin   ifile1,iskip1
  a3,a4     soundin   ifile2,iskip2
  aout1     =  (a1*aenv1)+(a3*aenv2)
  aout2     =  (a2*aenv1)+(a4*aenv2)
            outs      aout1,aout2
endin
