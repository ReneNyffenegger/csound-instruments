  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr     1605                
  ax        init      1                           ; DUFFINGS SYSTEM OR...            
  ay        init      0                           ; ... CUBIC OSCILLATOR             
  ke        init      p6                          ; ax = y            
  ka        init      p7                          ; ay = ex^3-Ax           
  kh        init      p5                  
  kampenv   linseg    0, .01, p4, p3-.02, p4, .01, 0                    
  axnew     =  ay                  
  ay        =  ay+kh*(ke*ax*ax*ax-ka*ax)                    
  ax        =  axnew                    
            outs      kampenv*ax, kampenv*ay                  
endin

