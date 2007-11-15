  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; Delays negative half of signal

  ilevl     =  p4*2                               ; Output level
  idelay    =  p5/1000                            ; Delay in ms
  imix      =  p6                                 ; Mix: 0=Neg 1=Pos

  ain       soundin   "sample1.wav"

  apos      limit     ain, 0, 32768
  aneg      limit     ain, -32768, 0
  adel      delay     aneg, idelay
  amix      =  apos*imix + adel*(1 - imix)
            out       amix*ilevl
  
endin
