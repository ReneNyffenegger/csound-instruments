; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1
  iptch     =  cpspch(p5)
  asig      pluck     p4, iptch, iptch, 1, 1      ; plucked string using simple averaging
            out       asig
endin


