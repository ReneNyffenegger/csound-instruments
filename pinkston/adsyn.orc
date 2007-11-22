  sr        =  44100   
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;==============================================================;
; Simple adsyn demonstration instrument with fixed amp, pitch,
; and time factors. Uses adsyn.nnn analysis files created with 
; the hetro utility.
; RP
;==============================================================;

instr   1
  iampfac   =  p4                                 ;amp control factor: 1 = no change
  ipitfac   =  p5                                 ;pitch control factor: 1 = no change
  itimfac   =  p6                                 ;time control factor: 1 = no change
  ifileno   =  p7                                 ;adsyn.ifileno 
  asig      adsyn     iampfac,ipitfac,itimfac,ifileno
            out       asig
endin

;==============================================================;
; A slightly more complex adsyn demonstration instrument. 
; Uses oscil1i for Amp, Pitch, and Time control variables.
; RP
;==============================================================;

instr   2
  iampfac   =  20000                              ; p4       ;amp control factor: 1 = no change
  ipitfac   =  p5                                 ;pitch control factor: 1 = no change
  itimfac   =  p6                                 ;time control factor: 1 = no change
  ifileno   =  p7                                 ;adsyn.ifileno
  iampfn    =  (p8 == 0 ? 1 : p8)                 ;default to unit functions
  ipitfn    =  (p9 == 0 ? 1 : p9)      
  itimfn    =  (p10 == 0 ? 1 : p10)    
  ivampd    =  (p11 == 0 ? p3 : p11)              ;amp variation dur
  ivpitd    =  (p12 == 0 ? p3 : p12)              ;pitch variation dur
  ivtimd    =  (p13 == 0 ? p3 : p13)              ;time variation dur
  iampdel   =  p14                                ;optional delays for amp, pit, and time 
  ipitdel   =  p15
  itimdel   =  p16
  iampvar   =  iampfac - 1
  kampvar   oscil1i   iampdel,iampvar,ivampd,iampfn
  kampfac   =  1 + kampvar
  ipitvar   =  ipitfac - 1
  kpitvar   oscil1i   ipitdel,ipitvar,ivpitd,ipitfn
  kpitfac   =  1 + kpitvar
  itimvar   =  itimfac - 1
  ktimvar   oscil1i   itimdel,itimvar,ivtimd,itimfn
  ktimfac   =  1 + ktimvar
  asig      adsyn     kampfac,kpitfac,ktimfac,ifileno
            out       asig * 32767                ;scale for 16-bit system
endin

