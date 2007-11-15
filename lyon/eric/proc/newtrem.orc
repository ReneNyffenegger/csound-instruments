  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
;f3 0 8192 9  1 -.5 180  0 .5  0
  itremfunc =  1
  ircosfunc =  1
  ifile     =  1
  iskip     =  0
  itr1a     =  p4
  itr1b     =  p5
  itr2a     =  p6 
  itr2b     =  p7 
  iswitch1  =  p8
  iswitch2  =  p9
  iatk      =  .01
  idk       =  .01
  isust     =  p3- (iatk+idk)
  iamp      =  .15

  a1,a2     soundin   ifile, iskip
  ampenv    linseg    0,iatk,iamp,isust,iamp,idk,0
  a1        =  a1 * ampenv
  a2        =  a2 * ampenv
  atremenv  oscili    1.0, 1./p3, itremfunc
  atr1a     oscili    1.0, itr1a, ircosfunc
  atr1b     oscili    1.0, itr1b, ircosfunc
  atr2a     oscili    1.0, itr2a, ircosfunc
  atr2b     oscili    1.0, itr2b, ircosfunc
  aswitch1  oscili    1.0, iswitch1, ircosfunc
  aswitch2  oscili    1.0, iswitch2, ircosfunc
  atr1      =  ((atr1a*aswitch1) + atr1b*(1.0-aswitch1))
  atr2      =  ((atr2a*aswitch2) + atr2b*(1.0-aswitch2))
  aleft     =  (atr1*atremenv)+(1.0-atremenv)
  aright    =  (atr2*atremenv)+(1.0-atremenv)
            outs      a1*aleft, a2*aright
        
endin
