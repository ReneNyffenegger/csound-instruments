  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "This Panel shows the varying value of a k-rate signal",400,300
  gih1      FLvalue   "Output of FLprintk", 150,20,50,20
  gk1,ih    FLknob    "Rate of the LFO", .1,10,-1,1, -1, 90, 150,100

FLpanel_end
            FLrun     

instr 1
  k1        oscili    1,gk1,1
            FLprintk  .2,k1,gih1
;       FLprintk2       k1,gih1
  a1        oscili    3000, 200*octave(k1), 1
            out       a1
endin   
