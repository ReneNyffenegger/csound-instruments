  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1
            FLcolor   120,50,0

            FLpanel   "This Panel contains some Buttons",400,300
            FLcolor   -1
  gk1,ihb1  FLbutton  "Shadow Label",  150,150, 1,300,50,50,20,    0,1,0,3
            FLsetTextType   3,ihb1
            FLsetFont   4,ihb1
  gk1,ihb2  FLbutton  "Engraved Label",  200,100, 2,300,50,50,80,    0,1,0,3
            FLsetTextType   4,ihb2
            FLsetTextSize   30,ihb2
  gk1,ihb3  FLbutton  "Embossed Label",  500,300, 1,300,50,50,150,   0,1,0,3
            FLsetTextType   5,ihb3
            FLsetTextSize   20,ihb3
  gk1,ihb4  FLbutton  "Shadow Label", 800,1500,1,300,50,50,210,   0,1,0,3
            FLsetTextType   3,ihb4
            FLsetTextSize   38,ihb4
            FLsetFont   2,ihb4
            FLsetTextColor  0,0,120,ihb4
FLpanel_end

            FLrun     


instr 1
  ampenv    linseg    3000,p3/2,100,p3/2,0
  a1        oscili    ampenv, i(gk1), 1
            out       a1
endin
