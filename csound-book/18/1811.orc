sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


garing    init 0         
gasine    init 0         
                    
          instr     1823                
aosc      oscil     1, p5, 1       
gasine    =         aosc                     ; SEND    
aring     =         garing                   ; RETURN  
asig      linen     aring, 0.1, p3, 0.2      
          out       asig*p4        
          endin               
                    
          instr     1824      
aosc      oscil     1, p5, 1       
aring     =         aosc*gasine         
garing    =         aring          
          endin
