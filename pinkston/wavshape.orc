  sr        =  22050
  kr        =  4410
  ksmps     =  5
  nchnls    =  1

;=========================================================================;
;                                                                         ;
;               General Purpose Waveshaping Instrument                    ;
;                                                                         ;
;=========================================================================;
;                Coded by Russell Pinkston - Univ. of Texas               ;
;=========================================================================;

instr   9

  ihertz    =  cpspch(p4)
  ipkamp    =  p5
  iwsfn     =  p6                                 ;waveshaping function
  inmfn     =  p7                                 ;normalization function
  ixris     =  p8                                 ;index rise time
  ixdec     =  p9                                 ;index decay time
  kgate     linen     1,.01,p3,.1                 ;overall amp envelope
  kctrl     linen     .999,ixris,p3,ixdec         ;waveshaping index control
  aindex    oscili    kctrl/2,ihertz,1            ;sine wave to be distorted
  asignal   tablei    .5+aindex,iwsfn,1           ;waveshaping
  knormal   tablei    kctrl,inmfn,1               ;amplitude normalization
            out       asignal*knormal*ipkamp*kgate
endin

