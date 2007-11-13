  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     2706
  iamod     =  p4
  ifmod     =  p5
  ismod     =  p6
  asig      adsyn     iamod, ifmod, ismod, "glass_2.het"
            out       asig
        
endin
