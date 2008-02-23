  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2821    
  ifreq1    =  1
  ifreq2    =  cpspch(8.00)/cpspch(8.03)          ; TRANSPOSE DOWN A MINOR 3rd    
  ifmod     =  .5                                 ; ... DOWN AN OCTAVE                            
  kamp1     line      1, p3, 2                                                
  kamp2     expon     2, p3, 3                        
  kinterp   line      0, p3, 1    
  ktime     line      0, p3, 1    
            pvbufread   ktime, "violin.pvx" 
  asig      pvinterp  ktime, ifmod, "altosax.pvx", ifreq1, ifreq2, kamp1, kamp2, kinterp, kinterp
            out       asig    
endin
