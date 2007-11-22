  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;========================================================;
; Variable grain instrument. Uses control functions for  ;
; grain density, amplitude, pitch, and duration offsets. ;
; NB: the random density is not working in the current   ;
; versions of Csound. It does work with version 3.54.    ;
;                                                        ;
; 2/16/99, 1/16/02 Russell Pinkston                      ;
;========================================================;

instr   1
  ipkamp    =  p4                                 ;approximate peak amplitude
  ixcps     =  (p5 < 0 ? abs(p5) : cpspch(p5))    ;initial center pitch
  ixden     =  p6                                 ;maximum density
  iampdev   =  p7                                 ;max amplitude deviation
  icpsdev   =  p8                                 ;max pitch deviation
  idurdev   =  p9                                 ;max grain dur deviation
  iwavefn   =  p10                                ;source sound function
  igrnfn    =  p11                                ;grain envelope function
  ixampfn   =  p12                                ;grain amplitude function
  icpitfn   =  p13                                ;center pitch control func
  idensfn   =  p14                                ;density control function
  ivampfn   =  p15                                ;amp offset control function
  ivpitfn   =  p16                                ;pitch offset control function
  idurfn    =  p17                                ;grain dur control function
  imaxdur   =  (p18 != 0 ? p18 : .25)             ;default max dur is .25
  irise     =  (p19 != 0 ? p19 : p3/4)            ;default rise is p3/4
  idecay    =  (p20 != 0 ? p20 : p3/4)            ;default decay is p3/4
  irndfac   =  p21                                ;random density factor
  kxden     init      ixden                       ;initialize the density

;optional density randomization
if      (irndfac == 0) kgoto continue             ;optional random density
  krnd      rand      irndfac/2
  krnd      =  irndfac/2+krnd                     ;offset to positive only
  kxden     =  ixden*(1-irndfac) + ixden*krnd
continue:

;grain parameter control functions

  kxamp     oscil1i   0,ipkamp,p3,ixampfn         ;xamp control function
  kcpit     oscil1i   0,ixcps,p3,icpitfn          ;xpitch control function
  kden      oscil1i   0,kxden,p3,idensfn          ;xdens control function
  kvamp     oscil1i   0,iampdev,p3,ivampfn        ;kampoff control function
  kvpit     oscil1i   0,icpsdev,p3,ivpitfn        ;kpitchoff control function
  kdur      oscil1i   0,idurdev,p3,idurfn         ;kgdur control function
        
;Note: ensure minimum values for grain density and grain duration
  asig      grain     kxamp,kcpit,.001+kden,kvamp,kvpit,.0001+kdur,iwavefn,igrnfn,imaxdur
  asig      linen     asig,irise,p3,idecay
            out       asig
endin 