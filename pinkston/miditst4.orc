;==========================================
;An FM MIDI instrument that uses continuous 
;controller 7 and velocity to affect both
;the index & the final signal amplitude.
;It also uses the ModWheet (CC1) to control
;the depth and rate of vibrato and implements
;pitch bend.
;==========================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

            massign   1,10                        ;assign midi chan 1 to instr 10
            ctrlinit  1,7,80,1,80                 ;initialize ctrl 1 & 7 on chan 1 to 32 & 80
        
instr 10
  icarfac   =  1
  imodfac   =  1
  imaxndx   =  30
  ivibwth   =  .025
  ivibhz    =  6
  kmodwh    midictrl  1,0,1                       ;get controller 1 (ModWheel) 
  kvol      midictrl  7,0,1                       ;get controller 7 (Volume)
  kscale    tablei    kvol,2,1                    ;function 2 has an exponential rise
  iamp      ampmidi   5000
  kcps0     cpsmidib  12                          ;apply pitch bend, if any in midi file
  kcps0     port      kcps0,.2                    ;smooth out the pitch changes
  kamp      =  iamp*kscale
  kindex    =  imaxndx*kscale*iamp/5000
  amp       interp    kamp
;vibrato module!
  kvibwth   =  kmodwh*ivibwth
  klfohz    =  kmodwh*ivibhz
  klfo      oscil     kvibwth,klfohz,1
  kvib      =  1 + klfo
  kcps      =  kcps0 * kvib
  agate     linenr    amp,.01,.1,.01
  asig      foscil    agate,kcps,icarfac,imodfac,kindex,1
            out       asig
endin
