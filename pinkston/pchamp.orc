  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  icps      =  cpspch(p4)
;assume lowest note is C 5.00 and highest is C 10.00
  ipmin     =  cpspch(5.00)
  ipmax     =  cpspch(10.00)
  iprng     =  ipmax-ipmin

;minimum amp is 2000 and maximum is 8000
  iamp      =  2000+6000*((icps-ipmin)/iprng)
            print     iamp
  kgate     linen     iamp, .05, p3, .1
  asig      oscil     kgate, icps, 1
            out       asig
endin


instr 2
  icps      =  cpspch(p4)
;assume lowest note is C 5.00 and highest is C 10.00
  ipmin     =  cpspch(5.00)
  ipmax     =  cpspch(10.00)
  iprng     =  ipmax-ipmin

;Use a normalized index to table (range = 0-1)
  indx      =  (icps-ipmin)/iprng
  iamp      tablei    indx, 2, 1
            print     iamp
  kgate     linen     iamp, .05, p3, .1
  asig      oscil     kgate, icps, 1
            out       asig
endin