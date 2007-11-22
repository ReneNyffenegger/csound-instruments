  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

/*
        To use this orchestra you have:
        1) adjust the sliders
        2) set the Counter to an index corresponding to the location you want to store a snapshot to.
           Usually snapshots are stored in progressive locations. It is recommended to do that, to 
           avoid empty snapshots (see manual).
                
        3) Click the button "Store snapshot..." each time a new snpshot has to be stored (obviousli into 
           different locations)
        4) You can retreive slider positions corresponding to a stored snapshot by clicking a button belonging
           to the button bank
        5) You can save all the snapshot bank to disk at any moment by clicking to the button 
           "Save snapshot bank to disk"
        6) In subsequent Csound sessions you can reload a previously saved snapshot bank by clicking the
           button "Load snapshot bank from disk"

*/


            FLpanel   "This is a snapshot example",400,460


  ihval1    FLvalue   " ", 100,20,290,10
  ihval2    FLvalue   " ", 100,20,290,50
  ihval3    FLvalue   " ", 100,20,290,90

  gk1,ih    FLslider  "frequency of the first oscillator", 80,5000,-1,5, ihval1, 260,16, 20,10
  gk2,ih    FLslider  "frequency of the second ocillator", 80,5000,-1,5, ihval2, 260,16, 20,50
  gk3,ih    FLslider  "frequency of the third ocillator",  80,5000,-1,5, ihval3, 260,16, 20,90

  gkStore,ih1  FLcount  "this index must point to the location number where snaphsot is stored",0,10,1,20,21,150,20,20,140,    -1,4,0,0
            FLsetTextSize   12,ih1
            FLsetTextType   5,ih1
            FLsetTextColor  140,140,140,ih1

  gk9,ih    FLbutton  "Store snapshot to current index",  3,0, 11,150,40,200,140,    0,2,0,0
  gk9,ih    FLbutton  "Save snapshot bank to disk", 1,0, 11,130,40,200,210,    0,5,0,0
  gk9,ih    FLbutton  "Load snapshot bank from disk", 1,0, 11,150,40,20,210,    0,6,0,0

  gkGet,ih  FLbutBank   12, 8,8,       360,180, 20,260,    0,7,0,0
  ihx       FLbox     "This button bank allows to retrieve snapshots",1,1,14,360,20,20,180+260
            FLsetFont   4,ihx
            FLsetTextType   5,ihx
            FLsetTextColor  180,180,180,ihx
FLpanel_end
            FLrun     

instr 1
  a1        oscili    3000, gk1, 1
  a2        oscili    3000, gk2, 1
  a3        oscili    3000, gk3, 1
            out       a1+a2+a3
endin   


instr   2
  inumsnap  inumval   FLsetsnap       i(gkStore)
endin

instr   5
            FLsavesnap  "butta_snap.txt"
endin

instr   6
            FLloadsnap  "butta_snap.txt"
endin

instr   7
  inumel    FLgetsnap   i(gkGet)
endin



