; ************************************************************************
; ACCCI:     20-70-1.ORC
; synthesis: FM(20),
;            single-carrier, complex wave FM (70)
;            string-like(1)
; source:    Schottstaedt(1977), adapted from string.orc: MIT(1993)
; coded:     jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)                         ;S = fc +- ifm1 +- kfm2 +- lfm3
  ifm1      =  ifqc
  ifm2      =  ifqc*3
  ifm3      =  ifqc*4
  indx1     =  7.5/log(ifqc)                      ;range from ca 2 to 1
  indx2     =  15/sqrt(ifqc)                      ;range from ca 2.6 to .5
  indx3     =  1.25/sqrt(ifqc)                    ;range from ca .2 to .038

  irise     =  p6
  idec      =  p7
  inoisdur  =  .1
  ivibdel   =  1
  ivibwth   =  p9
  ivibrte   =  p10

  kvib      init      0
            timout    0,ivibdel,transient         ; delay vibrato ivibdel sec
  kvbctl    linen     1,.5,idur-ivibdel,.1        ; vibrato control envelope
  krnd      randi     .0075,2                     ; random deviation vib width
  kvib      oscili    kvbctl*ivibwth+krnd,ivibrte*kvbctl,1 ; generator

transient:
            timout    inoisdur,p3,continue        ; execute for .2 secs only
  ktrans    linseg    1,inoisdur,0,1,0            ; transient envelope
  anoise    randi     ktrans*iamp/4,.2*ifqc       ; attack noise...
  attack    oscili    anoise,2000,1               ; ...centered around 2kHz


continue:
  amod1     oscili    ifm1*(indx1+ktrans),ifm1,1
  amod2     oscili    ifm2*(indx2+ktrans),ifm2,1
  amod3     oscili    ifm3*(indx3+ktrans),ifm3,1
  asig      oscili    iamp,(ifqc+amod1+amod2+amod3)*(1+kvib),1
  asig      linen     asig+attack,irise,idur,idec
            out       asig



endin

