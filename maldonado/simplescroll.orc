  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "This Panel contains big Knob and scroll bars",300,300
            FLscroll  300,300,0,0
;** because of some bug in actual version of FLTK, this group is required, otherwise text will not be shown
            FLgroup   "group",500,500,0,0 
  gk1,ih1   FLknob    "This is a big knob with scroll bars", 80,5000,-1,1, -1, 300, 100,50
FLgroup_end
FLscroll_end
FLpanel_end
            FLrun     

instr 1
  a1        oscili    3000, gk1, 1
            out       a1
endin   
