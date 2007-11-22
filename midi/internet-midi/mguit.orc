  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


            massign   1,1

instr          1

  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,1,.01

  kamp      linsegr   0.0, 0.015, 15000*2, 2-0.065, 15000*2, 0.05, 0.0
  asig      pluck     kamp, inote, inote, 0, 1
  af1       reson     asig, 110, 80
  af2       reson     asig, 220, 100
  af3       reson     asig, 440, 80
  aout      balance   0.6*af1+af2+0.6*af3+0.4*asig, asig
            outs      aout*kgate,aout*kgate
  ga1       =  aout*kgate
endin


