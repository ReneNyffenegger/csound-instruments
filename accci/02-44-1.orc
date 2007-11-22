; ************************************************************************
; ACCCI:      02-44-1.ORC
; synthesis:  additive, same building blocks(02)
;             basic instrument with continuous pitch and amp control(44)
; source:     #514   Part 2 of Endless Glissando, Risset(1969)
; notes:      Prior to running this, the table controlling the amplitudes
;             (bell-shaped function) needs to be created: 88-01-1.TAB
; coded:      jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  ifq       =  p4
  iamp      =  p5

  a11       oscili    iamp,1/idur,71, 0           ; f71 reads soundfile with gen01
  a22       oscili    ifq,1/idur,51, 0
  a1        oscili    a11, a22,11

  a11       oscili    iamp,1/idur,71, .1
  a22       oscili    ifq,1/idur,51, .1
  a2        oscili    a11, a22,11

  a11       oscili    iamp,1/idur,71, .2
  a22       oscili    ifq,1/idur,51, .2
  a3        oscili    a11, a22,11

  a11       oscili    iamp,1/idur,71, .3
  a22       oscili    ifq,1/idur,51, .3
  a4        oscili    a11, a22,11

  a11       oscili    iamp,1/idur,71, .4
  a22       oscili    ifq,1/idur,51, .4
  a5        oscili    a11, a22,11

  a11       oscili    iamp,1/idur,71, .5
  a22       oscili    ifq,1/idur,51, .5
  a6        oscili    a11, a22,11

  a11       oscili    iamp,1/idur,71, .6
  a22       oscili    ifq,1/idur,51, .6
  a7        oscili    a11, a22,11

  a11       oscili    iamp,1/idur,71, .7
  a22       oscili    ifq,1/idur,51, .7
  a8        oscili    a11, a22, 11

  a11       oscili    iamp,1/idur,71, .8
  a22       oscili    ifq,1/idur,51, .8
  a9        oscili    a11, a22,11

  a11       oscili    iamp,1/idur,71, .9
  a22       oscili    ifq,1/idur,51, .9
  a10       oscili    a11, a22,11

  a1        =  a1+a2+a3+a4+a5+a6+a7+a8+a9+a10
  a33       linseg    0, p3*.01,1, p3*.95,1, p3*.04, 0 ; envelope
            out       a1*a33
endin
