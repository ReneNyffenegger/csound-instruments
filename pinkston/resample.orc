;====================================================================;
;       Example Orchestra for playing SOUNDIN files                  ;
;====================================================================;

  sr        =  22050
  kr        =  2205 
  ksmps     =  10
  nchnls    =  1

;===========================================;
;        Pitch Changing Instrument          ;
;                                           ;
;       p4 = peak amp   p5 = desired pitch  ;
;       p6 = old pitch  p7 = original sr    ;
;===========================================;

instr   1
  icpsnew   =  cpspch(p5)
  icpsold   =  cpspch(p6)
  ioldsr    =  p7
  incr      =  ioldsr/sr * icpsnew/icpsold
  kphase    init      0                           ;initialize phase
  aphase    interp    kphase                      ;convert to arate
  asig      tablei    aphase,1                    ;resample the sound
  kphase    =  kphase+incr*ksmps                  ;update for next k
            out       asig*p4                     ;rescale to peak amp
endin
