  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "This Panel contains a Text Field",400,200
  gk1,iht1  FLtext    "This Text Field controls the frequency of an oscillator.", 80, 5000,.25,1  , 200,20, 100,50
FLpanel_end
            FLrun     

instr 1
  a1        oscili    3000, gk1, 1
            out       a1
endin   
