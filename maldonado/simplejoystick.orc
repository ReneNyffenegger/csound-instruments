  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

            FLpanel   "This Panel contains a Joystick",400,400
  gk1,gk2,ihj1,ihj2   FLjoy   "This Joystick controls the frequencies of two oscillators", 50, 500, 50, 500,0,0,-1,-1,300,300,30,30
FLpanel_end
            FLrun     

instr 1
  a1        oscili    3000, gk1, 1
  a2        oscili    3000, gk2, 1
            outs      a1,a2
endin   
