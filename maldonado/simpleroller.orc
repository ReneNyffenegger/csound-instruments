  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "This Panel contains a Roller",300,200
  gk1,ih1   FLroller  "This Roller controls oscili frequency", 80,5000,3, -1,1, -1, 200,30, 50,50
FLpanel_end
            FLrun     

instr 1
  a1        oscili    3000, gk1, 1
            out       a1
endin   
