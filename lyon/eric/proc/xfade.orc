  sr        =  44100
  kr        =  44100
  ksmps     =  1

;i1 0 dur file skip fadeout gain
;i2 0 dur file skip fadein fadeout gain
;i3 0 dur file skip fadein  gain

instr 1         ;fade out
  ifile     =  p4
  iskip     =  p5
  ifade     =  p6
  isust     =  p3-ifade
  igain     =  p7
  aenv      linseg    igain,isust,igain,ifade,0
  asig      soundin   ifile,iskip
            out       asig*aenv
endin

instr 3         ;fade in
  ifile     =  p4
  iskip     =  p5
  ifade     =  p6
  isust     =  p3-ifade
  igain     =  p7
  aenv      linseg    0,ifade,igain,isust,igain
  asig      soundin   ifile,iskip
            out       asig*aenv
endin

instr 2         ;fade in
  ifile     =  p4
  iskip     =  p5
  ifadein   =  p6
  ifadeout  =  p7
  isust     =  p3-(ifadein+ifadeout)
  igain     =  p8
  aenv      linseg    0,ifadein,igain,isust,igain,ifadeout,0
  asig      soundin   ifile,iskip
            out       asig*aenv
endin
