;*******************************************************
;;         basic orchestra file                          
;;                                                       
;;         p3 = duration        p4 = amplitude           
;;         p5 = pitch in pch                             
;;                                                       
;;*******************************************************;          
  sr        =  44100          
  kr        =  4410       
  ksmps     =  10    
  nchnls    =  1         
instr     1         
  asig      oscili    p4,cpspch(p5),1                 
            out       asig              
endin
