;** ORC FOR REALTIME TEST

  sr        =  44100                              ;** ALSO EXPERIMENT WITH OTHER SR AND KR RATES. 
  kr        =  441                                ;** TRY ALSO WITH "-E" FLAG AND "ROUNDED" SR AND KR VALUES
  ksmps     =  100                                ;** REDUCING BUFFER NUMBER AND BUFFER LENGTH
  nchnls    =  1    
     
instr     1
  inum      notnum    
  icps      cpsmidi   
  iamp      ampmidi   4000
  kmp       linenr    iamp, 0, .1, .03            ;** USE RELASE < 7 SECS
  a1        oscili    kmp, icps, 1
            out       a1
endin



