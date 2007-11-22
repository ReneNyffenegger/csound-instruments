  sr        =  22050
  kr        =  2205
  ksmps     =  10.0
  nchnls    =  1

;=====================================================
; Simple Variable Amplitude Modulation of Sample Files
; 
; Developed in class on 10/5/2000
;=====================================================

instr     1
  imodamp   =  p4                                 ;max modulation depth
  imodhz    =  p5                                 ;max modulation freq
  iamodrise =  p6                                 ;AM amp env rise
  iamodec   =  p7                                 ;AM amp env decay
  ifmodrise =  p8                                 ;AM freq env rise
  ifmodec   =  p9                                 ;AM freq env decay
  imodfn    =  p10                                ;AM window function
  asound    soundin   "beet.wav"                  ;screwy Beethoven file
  kmodamp   linen     imodamp,iamodrise,p3,iamodec
  kmodhz    linen     imodhz,ifmodrise,p3,ifmodec
  amod      oscili    kmodamp,kmodhz,imodfn
  aoutput   =  asound * amod                      ;do the AM
            out       aoutput
endin
