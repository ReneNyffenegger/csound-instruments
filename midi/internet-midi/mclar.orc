  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

            massign   1,1

instr          1
    
  ipch      cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.5,.01

  i1        =  ipch
  i2        =  .64
if             .75 > .75 igoto start
  i2        =  .75-.085

start:
  a1        linenr    255,.085,.75,i2
  a1        oscili    a1,i1,3
  a1        tablei    a1+256,1
            outs      (20000*a1)*kgate,(20000*a1)*kgate

  ga1       =  (20000*a1)*kgate
endin
