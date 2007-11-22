  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "This Panel contains a Knob and shows its current value",400,300
  ih1       FLvalue   "This is current value of output of the Knob", 100,20,50,20
  gk1,ih    FLknob    "Current value of this Knob is shown in a text field", 80,5000,-1,1, ih1, 90, 150,100

FLpanel_end
            FLrun     

instr 1
  a1        oscili    3000, gk1, 1
            out       a1
endin   
