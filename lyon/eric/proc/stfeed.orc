  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  igain     =  .5 
  ifb1      =  .9
  ifb2      =  .2
  ifblen    =  p3*.8
  idel1     =  .03
  idel2     =  .07
  imax1     =  idel1*2.1
  imax2     =  idel2*2.1

  ain1, ain2   soundin  p4,p5
  ain1      =  ain1 * igain
  ain2      =  ain2 * igain
  kfb       linseg    ifb1, ifblen, ifb2, p3-ifblen, ifb2
  addl1     delayr    imax1
  atap1     deltap    idel1
  ain1      =  ain1 + (atap1*kfb)
            delayw    ain1
  addl2     delayr    imax2
  atap2     deltap    idel2
  ain2      =  ain2 + (atap2*kfb)
            delayw    ain2
            outs      ain1, ain2
endin


instr 2 ; function control
;file skip del1 del2 gain
;f1 0 8192 -1 50 0 
  igain     =  p8 
  idel1     =  p6
  idel2     =  p7
  imax1     =  idel1*2.1
  imax2     =  idel2*2.1

  ain1, ain2   soundin  p4,p5
  ain1      =  ain1 * igain
  ain2      =  ain2 * igain
  kfb       oscil     1.0, 1/p3, 1
  addl1     delayr    imax1
  atap1     deltap    idel1
  ain1      =  ain1 + (atap1*kfb)
            delayw    ain1
  addl2     delayr    imax2
  atap2     deltap    idel2
  ain2      =  ain2 + (atap2*kfb)
            delayw    ain2
            outs      ain1, ain2
endin
