;==========================================================================;
;                Schottstaedt FM String Instrument from Dodge              ;
;                                                                          ;
;p4 = amp p5 = pch p6 = rise p7 = dec p8 = vibdel p9 = vibwth p10 = vibrte ;
;==========================================================================;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  iamp      =  p4
  ifc       =  cpspch(p5)                         ; S = fc +- ifm1 +- kfm2 +- lfm3
  ifm1      =  ifc
  ifm2      =  ifc*3
  ifm3      =  ifc*4
  indx1     =  7.5/log(ifc)                       ; RANGE FROM CA 2 TO 1
  indx2     =  15/sqrt(ifc)                       ; RANGE FROM CA 2.6 TO .5
  indx3     =  1.25/sqrt(ifc)                     ; RANGE FROM CA .2 TO .038
  kvib      init      0                

            timout    0,p8,transient              ; DELAYS VIBRATO FOR p8 SECONDS
  kvbctl    linen     1,.5,p3-p8,.1               ; VIBRATO CONTROL ENVELOPE
  krnd      randi     .0075,15                    ; RANDOM DEVIATION IN VIB WIDTH        
  kvib      oscili    kvbctl*p9+krnd,p10*kvbctl,1 ; VIBRATO GENERATOR
        
transient:
            timout    .2,p3,continue              ; EXECUTE FOR .2 SECS ONLY
  ktrans    linseg    1,.2,0,1,0                  ; TRANSIENT ENVELOPE 
  anoise    randi     ktrans,.2*ifc               ; NOISE... 
  attack    oscil     anoise,2000,1               ; ...CENTERED AROUND 2kHz

continue:      
  amod1     oscili    ifm1*(indx1+ktrans),ifm1,1
  amod2     oscili    ifm2*(indx2+ktrans),ifm2,1
  amod3     oscili    ifm3*(indx3+ktrans),ifm3,1
  asig      oscili    iamp,(ifc+amod1+amod2+amod3)*(1+kvib),1
  asig      linen     asig+attack,p6,p3,p7
            out       asig
        
endin
