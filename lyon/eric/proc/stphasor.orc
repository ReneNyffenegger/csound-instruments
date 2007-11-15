  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr 1
  isamps    =  p4
  icps      =  p5
    
  aphs      phasor    icps
    ; a1 tablei aphs*isamps, 1
  a2        tablei    aphs*isamps, 2
            outs      a2,a2
endin