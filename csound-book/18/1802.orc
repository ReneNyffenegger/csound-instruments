  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


  gkfr      init      0                           ; INIT FREQUENCY

instr     1802                ; CONTROLS INSTR 1903
  gkfr      linseg    p5, p3*.1, p6, p3*.9, p6 
endin          

instr     1803 
  kenv      linen     p4, .01, p3, .01    
  asig      oscil     kenv, gkfr, 1  
            out       asig 
endin     
