  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

; VARIABLE OSCILLATOR AMPLITUDE MODULATOR

instr 1
;THESE ARE MODULATION FREQUENCY BOUNDARIES:
  imin1     =  20 

  imax1     =  50
  idev1     =  (imax1-imin1)*.95
  imin2     =  30
  imax2     =  60
  idev2     =  (imax2-imin2)*.95
  imin3     =  40
  imax3     =  70
  idev3     =  (imax3-imin3)*.95
  infile    =  p4
  inskip    =  p5
  ispeed1   =  p6                                 ; MODULATION SPEED 1
  ispeed2   =  p7                                 ; MODULATION SPEED 2
  ispeed3   =  p8                                 ; MODULATION SPEED 3
  iseed1    =  p9
  iseed2    =  p10
  iseed3    =  p11
  iatk      =  .05
  idk       =  .05
  iamp      =  .25
  isust     =  p3-(iatk+idk)
  aenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  kfr1      randi     idev1, ispeed1, iseed1
  kfr2      randi     idev2, ispeed2, iseed2
  kfr3      randi     idev3, ispeed3, iseed3
  kfr1      =  kfr1 + imin1
  kfr2      =  kfr2 + imin2
  kfr3      =  kfr3 + imin3
  araw      soundin   infile, inskip
  amod1     oscil     araw,kfr1,1
  amod2     oscil     araw,kfr2,1
  amod3     oscil     araw,kfr3,1
            out       (amod1+amod2+amod3)*aenv
endin
