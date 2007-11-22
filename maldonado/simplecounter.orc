  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


            FLpanel   "This Panel contains a Counter",300,200
  gk1,ih1   FLcount   "Activate instr 2 and modify its frequency with this Counter",100,8000,100,500,11,200,30,50,100,    0,2,0,1,2000,3000
FLpanel_end
            FLrun     

instr 2
  ampenv    linseg    3000,p3/2,100,p3/2,0
  a1        oscili    ampenv, gk1, 1
            out       a1
endin
