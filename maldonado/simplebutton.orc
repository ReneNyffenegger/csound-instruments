  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "This Panel contains some Buttons",400,300
  gk1,ihb2  FLbutton  "This Button activates instr1 for 3 seconds giving it a frequency of 150 cps",  150,150, 1,300,50,50,20,    0,1,0,3
  gk1,ihb2  FLbutton  "This Light-Button switches the oscillator frequency between 100 and 200 cps",  200,100, 2,300,50,50,80,    0,1,0,3
  gk1,ihb2  FLbutton  "This Check-Button switches the oscillator frequency between 300 and 500 cps",  500,300, 3,300,50,50,150,   0,1,0,3
  gk1,ihb2  FLbutton  "This Round-Button switches the oscillator frequency between 800 and 1500 cps", 800,1500,4,300,50,50,210,   0,1,0,3
FLpanel_end

            FLrun     


instr 1
  ampenv    linseg    3000,p3/2,100,p3/2,0
  a1        oscili    ampenv, i(gk1), 1
            out       a1
endin
