

;** ORC FOR REALTIME TEST
  sr        =  44100                              ;** ALSO EXPERIMENT WITH OTHER SR AND KR RATES
  kr        =  441
  ksmps     =  100
  nchnls    =  2    


instr     1

  inum      notnum    
  icps      cpsmidi   
  ivol      midic7    2,500,10000
  iamp      ampmidi   ivol
  kctrl     midic7    1,.5,3

  iatk      init      .01

  kmp       linsegr   0,iatk,iamp, 1, iamp*.2,10,iamp*.2,.1, 0 ;**USE RELASE < 7 SECS
  amp       interp    kmp
     
  a1        oscili    amp, icps, 1
  a2        oscili    amp,icps * .994, 1
  a4        oscili    amp,icps * .501, 1
  a5        =  a1 + a2 + a4
  a5        =  a5 * 3

  a6        butterlp  a5, 300*kctrl
  a6        butterbp  a5, 300*kctrl, 300*kctrl*.1
  a7        butterlp  a5, 600*kctrl
  a7        butterbp  a5, 600*kctrl, 600*kctrl*.1
  a8        butterlp  a5, 900*kctrl
  a8        butterbp  a5, 900*kctrl, 900*kctrl*.1

  a12       =  (a6+a7+a8) * 4

            outs      a12, a12

endin
























