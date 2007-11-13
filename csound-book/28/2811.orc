  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gktime    init      0
  gkfmdevscale init   0
                                    
instr     2811
  iend      =  p4                                 ; CONTAINS A GLOBAL TIME
  gktime    line      0, p3, iend                 ; ...POINTER AND FM INDEX
  gkfmdevscale expseg   5, p3*.4, 5, p3*.6, .001  ; ... THAT WILL BE APPLIED
endin                                   ; ...TO ALL OF THE NOTES
                                                  ; ...PRODUCED BY instr 3212
instr     2812
  kfreq, kamp  pvread   gktime, "hellorcb.pvx", p4
  amod      oscili    kfreq*gkfmdevscale, kfreq, 1
  acar      oscili    kamp, kfreq+amod, 1 
            out       acar*p5
endin
    

