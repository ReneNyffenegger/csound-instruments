; waveshape mod from music 11 primer
; 9/13/89

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
          
instr 1
  k1        expseg    .01,.2,1,p3-.4,.9,.2,02
  k2        oscil     1,2/p3,3
  a1        foscili   k1*p4,p5,5,1.0005,k1*1.5,1
  a2        oscili    k1*p4,p5,6
            out       a1*k2 + a2*(1-k2)
endin
