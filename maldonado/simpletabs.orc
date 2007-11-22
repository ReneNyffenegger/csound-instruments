  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "Tabs example",400,250

            FLtabs    400-10,250-10, 5,5

            FLgroup   "slider",400-20,250-60, 10,45,0
  gk1,ih1   FLslider  "This Slider controls oscili frequency", 80,5000,-1,5, -1, 200,30, 50,100
FLgroup_end

            FLgroup   "Knob",400-20,250-60, 10,45,0
  gk1,ih1   FLknob    "This Knob controls oscili frequency", 80,5000,-1,1, -1, 90, 100,80
FLgroup_end

            FLgroup   "Roller",400-20,250-60, 10,45,0
  gk1,ih1   FLroller  "This Roller controls oscili frequency", 80,5000,3, -1,1, -1, 200,30, 50,100
FLgroup_end

            FLgroup   "Counter",400-20,250-60, 10,45,0
  gk2,ih1   FLcount   "Activate instr 2 and modify its frequency with this Counter", 100,8000,100,500,11,200,30,50,100, 0,2,0,1,2000,3000
FLgroup_end

            FLgroup   "Text Field",400-20,250-60, 10,45,0
  gk1,iht1  FLtext    "This Text Field controls the frequency of an oscillator. Try to edit text or to drag it horizontally.", 80, 5000,.25,1  , 200,20, 100,100
FLgroup_end

FLtabs_end
FLpanel_end
            FLrun     





instr 1
  a1        oscili    3000, gk1, 1
            out       a1
endin



instr 2
  ampenv    linseg    3000,p3/2,100,p3/2,0
  a1        oscili    ampenv, gk2, 1
            out       a1
endin   
