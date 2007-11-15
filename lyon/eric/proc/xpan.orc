  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


;f1 0 8192 10 1
;i1 0 dur file skip speed 

instr 1
  ipotoo    =  1.570796
  ip        =  ipotoo/2
  ifile     =  p4
  iskip     =  p5
  ispeed    =  p6/2.0
  a1,a2     soundin   ifile, iskip
  kloc      oscili    ip, ispeed, 1               ;f1 is a sine
  kloc      =  kloc+ip
  kleft     =  sin(kloc)
  kright    =  cos(kloc)
  aleft     =  kleft*a1+kright*a2
  aright    =  kleft*a2+kright*a1
            outs      aleft,aright
endin

;i2 0 dur file skip speed1 speed2

instr 2
  ipotoo    =  1.570796
  ip        =  ipotoo/2
  ifile     =  p4
  iskip     =  p5
  ispeed1   =  p6/2.0
  ispeed2   =  p7/2.0

  a1,a2     soundin   ifile, iskip
  kspeed    line      ispeed1, p3, ispeed2
  kloc      oscili    ip, kspeed, 1               ;f1 is a sine
  kloc      =  kloc+ip
  kleft     =  sin(kloc)
  kright    =  cos(kloc)
  aleft     =  kleft*a1+kright*a2
  aright    =  kleft*a2+kright*a1
            outs      aleft,aright
endin
