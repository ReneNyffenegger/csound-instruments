;4-13-89 TEST OF CPS PITCH CONVERSION
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  a1        pluck     p4,cpspch(p5),cpspch(p5),0,1,0,0 ;P4=AMP, P5=FREQ
            out       a1
endin

instr          2
  k1        linseg    p5,p3*.4,p5,p3*.6,p5*.9
  a1        pluck     p4,cpspch(p5),cpspch(p5),0,1,0,0
            out       a1
endin

instr          3
  k1        randi     3,5                         ;trem freq from rand
  k2        oscili    20,k1,2                     ;trem oscili w/rand freq - #2 f unit
  k3        linseg    p4*.1,p3*.7,p4,p3*.3,p4*.90 ;AMP SEG
  k4        linseg    p5*1.02,p3*.05,p5*.96,p3*.95,p5 ;FREQ SEG
  a1        oscili    k3,k4+k2,1
            out       a1
endin
