  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1              ;1st-order IIR Low Pass Filter
  ain       soundin   "thewind.wav"
  aout      tone      ain,p4,0
            out       aout
endin
instr    2              ;1st-order IIR High Pass Filter
  ain       soundin   "thewind.wav"
  aout      atone     ain,p4,0
            out       aout
endin
instr    3              ;2nd-order IIR Low Pass Filter
  ain       soundin   "thewind.wav"
  aout      butterlp  ain,p4
            out       aout
endin
instr    4              ;2nd-order IIR High Pass Filter
  ain       soundin   "thewind.wav"
  aout      butterhp  ain,p4
            out       aout
endin
instr    5              ;2nd-order IIR Band Pass Filter
  ain       soundin   "thewind.wav"
  aout      butterbp  ain,p4,p5
            out       aout
endin
instr    6              ;2nd-order IIR Band Reject Filter
  ain       soundin   "thewind.wav"
  aout      butterbr  ain,p4,p5
            out       aout
endin
instr    7              ;2nd-order IIR Band Pass Filter with optional scaling
  ain       soundin   "thewind.wav"
  aout      reson     ain,p4,p5,1                 ;scale for pitch
            out       aout
endin
instr    8              ;Cascade 2 resons to sharpen slope, use balance
  icf       =  p4
  ibw       =  icf/p5                             ;calculate bw from Q
  iscl      =  p6                                 ;1 for pitch, 2 for noise
  igain     =  (p7 = 0 ? 1 : p7)                  ;optional final gain factor
  ain       soundin   "thewind.wav"
  aout1     reson     ain,icf,ibw,iscl
  aout2     reson     aout1,icf,ibw,iscl
  asig      balance   aout2,ain
            out       asig*igain
endin
instr    9              ;Compare 2 butterbps to 2 resons
  icf       =  p4
  ibw       =  icf/p5                             ;calculate bw from Q
  iscl      =  p6                                 ;1 for pitch, 2 for noise
  igain     =  (p7 = 0 ? 1 : p7)                  ;optional final gain factor
  ain       soundin   "thewind.wav"
  aout1     butterbp  ain,icf,ibw
  aout2     butterbp  aout1,icf,ibw
  asig      balance   aout2,ain
            out       asig*igain
endin
