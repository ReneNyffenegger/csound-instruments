  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  amono     soundin   1,0
  ainv      =  -1.0 * amono
            outs      amono, ainv
endin
