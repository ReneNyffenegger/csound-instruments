
;JEAN-MICHEL DARREMONT
;   GBUZZST.ORC

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;p4 = AMP TAB
;p5 = FREQ TAB
;p6 = NB HARMONICS
;p7 = LOWEST HARMONIC
;p8 = HARMONICS AMP RATE FACTOR TAB (1 => EQUAL RATE FOR ALL HARMONICS)
;f9 = COSINE TAB
;f3 = PAN TAB
;f10= REV TAB

instr     1

  itabamp   =  4
  itabfreq  =  5
  itabharmamprate     =   8


  kamp      oscil1i   0,p4,p3,itabamp
  kfreq     oscil1i   0,p5,p3,itabfreq
  knbharm   =  p6
  klowharm  =  p7
          
  kharmamprate oscil1i  0,p8,p3,itabharmamprate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  kpan      oscil1i   0,1,p3,3                    ;p3=dur, pantab=3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  idel      =  .005
  kdclic    linseg    0, idel,1, p3-(100*idel),1,idel,0

  asig      gbuzz     kamp, kfreq, knbharm, klowharm, kharmamprate, 9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            outs      asig*kdclic*kpan, asig*kdclic*(1-kpan)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
endin
