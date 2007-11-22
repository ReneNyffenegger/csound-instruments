;** ORC FOR STEREO REALTIME TEST

  sr        =  44100                              ;** ALSO EXPERIMENT WITH OTHER SR AND KR RATES. 
  kr        =  441                                ;** TRY ALSO WITH "-E" FLAG AND "ROUNDED" SR AND KR VALUES
  ksmps     =  100                                ;** REDUCING BUFFER NUMBER AND BUFFER LENGTH
  nchnls    =  2    
     
instr     1
  inum      notnum    
  icps      cpsmidi   
  iamp      ampmidi   4000
  iphase    linrand   1
  ipanfrq   linrand   7
  kpan      oscili    1, ipanfrq, 2, iphase 
  kmp       linenr    iamp, 0, .1, .03            ;** USE RELASE < 7 SECS
  a1        oscili    kmp, icps, 1
            outs      a1 * kpan , a1*(1-kpan)
endin



