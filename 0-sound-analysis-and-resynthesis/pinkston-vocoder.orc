;*********************************************************************
;
;                       Vocoder instrument
;
;       p4 = modulator file     p5 = carrier file  p6= skptime
;       p7= pan depth   p8= pan delay  p9= pan rise  p10= pan dur
;       p11= pan decay   p12= pan time p13= noise factor    
;
; Written by Joe Anderson
; Minor edits by RP
;*********************************************************************


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr   1

  iq        =  75
  icf1      =  140
  icf2      =  180
  icf3      =  270
  icf4      =  360
  icf5      =  440
  icf6      =  540
  icf7      =  650
  icf8      =  790
  icf9      =  960
  icf10     =  1160
  icf11     =  1400
  icf12     =  1700
  icf13     =  2050
  icf14     =  2700
  icf15     =  4000
  icf16     =  5400

  imodrise  =  .07
  imodec    =  .07
  icarise   =  .07
  icardec   =  .07    

  iskptim   =  p6
  ipandpth  =  p7 
  ipandel   =  p8 
  ipanrise  =  p9 
  ipandur   =  p10
  ipandec   =  p11
  ipantm    =  p12
  inoise    =  p13

;----------------       soundin 

  asigm     soundin   p4                          ;modulator (usually speech)
  asigm     linen     asigm,imodrise,p3,imodec

  asigc     soundin   p5,iskptim                  ;carrier (needs fairly rich spectrum)
  asigc     linen     asigc,icarise,p3,icardec
            print     p4,p5
if (inoise==0) goto pan1                          ;inject noise into system

  anoise    rand      3000*inoise
  asigc     =  asigc+anoise 

;----------------       panning
pan1:
            timout    0,ipandel,filters
  kctl      linen     .5,ipanrise,ipandur,ipandec
  kpan      randi     kctl*ipandpth,(1/ipantm)*kctl,.5
  kpan      =  abs(kpan)
;----------------       bank 'o filters

filters:
  asigm1    reson     asigm,icf1,icf1/iq,1
  asigc1    reson     asigc,icf1,icf1/iq,1
  asig1     balance   asigc1,asigm1

  asigm2    reson     asigm,icf2,icf2/iq,1
  asigc2    reson     asigc,icf2,icf2/iq,1
  asig2     balance   asigc2,asigm2

  asigm3    reson     asigm,icf3,icf3/iq,1
  asigc3    reson     asigc,icf3,icf3/iq,1
  asig3     balance   asigc3,asigm3

  asigm4    reson     asigm,icf4,icf4/iq,1
  asigc4    reson     asigc,icf4,icf4/iq,1
  asig4     balance   asigc4,asigm4

  asigm5    reson     asigm,icf5,icf5/iq,1
  asigc5    reson     asigc,icf5,icf5/iq,1
  asig5     balance   asigc5,asigm5

  asigm6    reson     asigm,icf6,icf6/iq,1
  asigc6    reson     asigc,icf6,icf6/iq,1
  asig6     balance   asigc6,asigm6

  asigm7    reson     asigm,icf7,icf7/iq,1
  asigc7    reson     asigc,icf7,icf7/iq,1
  asig7     balance   asigc7,asigm7

  asigm8    reson     asigm,icf8,icf8/iq,1
  asigc8    reson     asigc,icf8,icf8/iq,1
  asig8     balance   asigc8,asigm8

  asigm9    reson     asigm,icf9,icf9/iq,1
  asigc9    reson     asigc,icf9,icf9/iq,1
  asig9     balance   asigc9,asigm9

  asigm10   reson     asigm,icf10,icf10/iq,1
  asigc10   reson     asigc,icf10,icf10/iq,1
  asig10    balance   asigc10,asigm10

  asigm11   reson     asigm,icf11,icf11/iq,1
  asigc11   reson     asigc,icf11,icf11/iq,1
  asig11    balance   asigc11,asigm11                               

  asigm12   reson     asigm,icf12,icf12/iq,1
  asigc12   reson     asigc,icf12,icf12/iq,1
  asig12    balance   asigc12,asigm12

  asigm13   reson     asigm,icf13,icf13/iq,1
  asigc13   reson     asigc,icf13,icf13/iq,1
  asig13    balance   asigc13,asigm13

  asigm14   reson     asigm,icf14,icf14/iq,1
  asigc14   reson     asigc,icf14,icf14/iq,1
  asig14    balance   asigc14,asigm14

  asigm15   reson     asigm,icf15,icf15/iq,1
  asigc15   reson     asigc,icf15,icf15/iq,1
  asig15    balance   asigc15,asigm15

  asigm16   reson     asigm,icf16,icf16/iq,1
  asigc16   reson     asigc,icf16,icf16/iq,1
  asig16    balance   asigc16,asigm16

  asigt1    =  (asig1+asig2+asig3+asig4+asig5+asig6+asig7+asig8) ;sum up signal
  asigt2    =  (asig9+asig10+asig11+asig12+asig13+asig14+asig15+asig16)        
  asigt     =  asigt1+asigt2

;----------------       voice/unvoiced logic

  asigma    tone      asigm,500                   ;LP filter
  asigmb    tone      asigma,500
         

  asigmc    atone     asigm,1000                  ;HP filter
  asigmd    atone     asigmc,1000
         
  ksiglp    rms       asigmb
  ksighp    rms       asigmd

if (ksiglp > ksighp) kgoto pan2

  asigt     =  asigt+asigm                        ;if it is unvoiced, add the original 
                                        ;modulator signal to the filtered
                                        ;sound
        
;---------------        more panning
pan2:
  klfac     =  sqrt(.5+kpan)                      ;left

  krfac     =  sqrt(.5-kpan)                      ;right

  asigt     balance   asigt,asigm

  asigl     =  klfac*asigt
  asigr     =  krfac*asigt   

;------------------     finally send it out

            outs      asigl,asigr
endin
