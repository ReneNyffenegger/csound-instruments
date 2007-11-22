; FIG 3.27.ORC

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     1
  i1        =  1/p3
  i2        =  p5/3
  i3        =  p4

  a1        oscili    i2,i1,1,0
  a2        oscili    i3,2*2*i1,2,0
  a1        oscili    a1,a2,3
  a2        oscili    i2,i1,1,.1
  a3        oscili    i3,2*i1,2,.1
  a2        oscili    a2,a3,3
  a3        oscili    i2,i1,1,.2
  a4        oscili    i3,2*i1,2,.2
  a3        oscili    a3,a4,3
  a4        oscili    i2,i1,1,.3
  a5        oscili    i3,2*i1,2,.3
  a4        oscili    a4,a5,3
  a5        oscili    i2,i1,1,.4
  a6        oscili    i3,2*i1,1,.4
  a5        oscili    a5,a6,3
  a6        oscili    i2,i1,1,.5
  a7        oscili    i3,2*i1,2,.5
  a6        oscili    a6,a7,3
  a7        oscili    i2,i1,1,.6
  a8        oscili    i3,2*i1,2,.6
  a7        oscili    a7,a8,3
  a8        oscili    i2,i1,1,.7
  a9        oscili    i3,2*i1,2,.7
  a8        oscili    a8,a9,3
  a9        oscili    i2,i1,1,.8
  a10       oscili    i3,2*i1,2,.8
  a9        oscili    a9,a10,3
  a10       oscili    i2,i1,1,.9
  a11       oscili    i3,2*i1,1,.9
  a10       oscili    a10,a11,3
            out       a1+a2+a3+a4+a5+a6+a7+a8+a9+a10
endin
