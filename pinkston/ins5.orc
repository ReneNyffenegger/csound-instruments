;--------------------------------------------;
; Pinkston Example Complex Instrument 5      ;
;--------------------------------------------;

  sr        =  22050
  kr        =  4410
  ksmps     =  5
  nchnls    =  1

instr   5                       ;popcorn simulation
  kvary     expseg    p5,p3/2,p6,p3/2,p5          ;vary gap durs between p5 and p6
  krndv     rand      .5,p7                       ;p7 is random seed
  kvary     init      p5                          ;begin with maximum possible gap
;---------------------------------------------------------------------------                    
start:
                                        ;start of reinit block 
  irndv     =  .5+i(krndv)                        ;offset irnd to between 0 and 1
  igap      =  .035+irndv*i(kvary)                ;between .035 and .035+kvary secs
  kbw       =  50+100*irndv                       ;small random var in filter bw
            timout    0,igap,continue             ;skip reinit for igap seconds
            reinit    start   
continue:                       
  agate     expseg    .0001,.005,1,.07,.0001      ;popcorn envelope
            rireturn                              ;end reinitializing here
;---------------------------------------------------------------------------                    
  anoise    rand      p4                          ;white noise for pops
  asig      reson     anoise,200,kbw,2            ;bandpass filtering
            out       asig*agate                  ;apply envelope
endin   
