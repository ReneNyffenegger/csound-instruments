;==========================================
;An FM MIDI instrument that uses continuous 
;controller 7 and velocity to affect both
;the index & the final signal amplitude.
;It also uses the ModWheet (CC1) to control
;the depth and rate of vibrato.
;The velocity is used to look up the carrier
;and modulator factors in a table (f03).
;==========================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

            massign   1,10                        ;assign midi chan 1 to instr 10
            ctrlinit  1,7,80,1,80                 ;initialize ctrl 1 & 7 on chan 1 to 32 & 80
        
instr 10
  ivel      veloc     0,7                         ;8 possibilities for velocity
  imodfac   table     ivel,4                      ;func 4 has mod factors
  icarfac   table     ivel,3                      ;func 3 has carrier factors
            print     ivel,imodfac,icarfac    
  imaxndx   =  30
  ivibwth   =  .025
  ivibhz    =  6
  kmodwh    midictrl  1,0,1                       ;get controller 1 (ModWheel) 
  kvol      midictrl  7,0,1                       ;get controller 7 (Volume)
  kscale    tablei    kvol,2,1                    ;function 2 has an exponential rise
  iamp      ampmidi   5000
  kamp      =  iamp*kscale
  kindex    =  imaxndx*kscale*iamp/5000
  amp       interp    kamp
  icps      cpsmidi   
;vibrato module!
  kvibwth   =  kmodwh*ivibwth
  klfohz    =  kmodwh*ivibhz
  klfo      oscil     kvibwth,klfohz,1
  kvib      =  1 + klfo
  kcps      =  icps * kvib
  agate     linenr    amp,.01,.1,.01
  asig      foscil    agate,kcps,icarfac,imodfac,kindex,1
            out       asig
endin
