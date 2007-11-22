  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2         

            massign   1,1

instr          1      

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01

   ;anoise     randi     p4,360  
  anoise    randi     16000,knote
   ;kbw1       oscil1    p7,p5,p3,p6     
  kbw1      oscil1    .02,knote,.3,5
  kbw       =  kbw1+30 
  aflt      reson     anoise,0,kbw,2 
  abal      balance   aflt,anoise    
   ;asig       linen     abal,.01,p3,.01                
  asig      linen     abal,.01,.3,.01
            outs      asig*kgate,asig*kgate                  
        
endin
