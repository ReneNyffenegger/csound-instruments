  sr        =  44100
  kr        =  44100
  ksmps     =  1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 1;SYNC emulation
;Josep M Comajuncosas / Aug'2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sync settings:

;sync time (time to decrease the original signal to 1/1000 of its last value)
;this feature emulates the exponential discharge of a RC circuit (sort of...)
  ksynct    linseg    .002,p3,.02
  ksynck    =  exp(log(0.001)/(kr*ksynct))


;sync mode  0  - (down-up) 1  - (up-down)  2  - (both) 
  ismode    =  0

;sync point
;kthereshold linseg 0,p3/3,0,p3/4,.5,p3/2,-.5
  kthereshold  init   0

  kfrq      expseg    50,p3/2,500,p3/4,200,p3/4,440

oscil:
;signal to be synced

  asig      oscil3    1,440,2
            rigoto    end

;sync master signal
  asig2     oscili    1,kfrq,1


  ksig2     downsamp  asig2
  ktrig     trigger   ksig2,kthereshold,ismode

if ktrig = 0 goto skip
  atemp     =  asig

            reinit    oscil

skip:


  atemp     =  atemp*ksynck
  atemp2    delay1    atemp
  aout      =  10000*(asig+atemp2)
;out 10000*atemp2
            out       aout


end:
endin