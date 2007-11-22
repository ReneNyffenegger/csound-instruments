  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "This Panel contains a Button Bank",400,330

  ih        FLbox     "This Button-Bank activates instr 1 and modifies its frequency", 7,1, 18, 380,80,10,10
  gk1,ihb1  FLbutBank   12, 8,8,       380,180, 10,100,    0,1,0,3
  FLbox     "N.B      . don't use button 0, since it outputs a frequency of zero Hz", 7,1, 14, 200,40,100,290

FLpanel_end

            FLrun     


instr 1
  ampenv    linseg    3000,p3/2,100,p3/2,0
  a1        oscili    ampenv, i(gk1)*100, 1

            out       a1
endin
