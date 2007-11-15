; ORKIESTRA
;   instrumenty:
; - instr   1 - noise generator
; - instr   2 - reads sound files and makes sound 'constructions,
; - instr  21 - only reads sound files
; - instr  22 - as abowe with exp envelope
; - instr 100 - reverb
; - instr 101 - comb
; - instr 102 - delay
; - instr   3 - guitar
; - instr   4 - fof ( balls )  


  sr        =  44100                              ;
  kr        =  4410                               ;
  ksmps     =  10                                 ;
  nchnls    =  2                                  ;
  gaout100  init      0                           ;efekt 100   reverb
  gaout101  init      0                           ;efekt 101  comb 
  gaout102  init      0                           ;efekt 102 delay

;;;;;

; uzywa funkcji 1 do vibrata amplitudy szumu
instr 1
  iwhite    =  p4
  ivamp     =  p5
  ivadel    =  p6
  ivarel    =  p7
  ivf1      =  p8
  ivf2      =  p9
  ivf3      =  p10
  ivt1      =  p11
  ivt2      =  p3 - ivt1
  iffsr1    =  p12
  iffsr2    =  p13
  iffsr3    =  p14
  iffts1    =  p15
  iffts2    =  p3 - iffts1
  ifpasm1   =  p16
  ifpasm2   =  p17
  ifpasm3   =  p18
  ifpt1     =  p19
  ifpt2     =  p3 - ifpt1
  ibal1     =  p20
  ibal2     =  p21
  ibdur     =  p22
  ifnr      =  p26

  kvamp     linen     ivamp, ivadel, p3, ivarel
  kvfrq     linseg    ivf1, ivt1, ivf2, ivt2, ivf3
  aampv     oscil     kvamp, kvfrq, ifnr
  aszum     rand      iwhite
  kffsr     linseg    iffsr1, iffts1, iffsr2, iffts2, iffsr3
  kfpasm    linseg    ifpasm1, ifpt1, ifpasm2, ifpt2, ifpasm3 
  afszum    reson     aszum, kffsr, kfpasm, 2
  aout      =  (ivf1 == 0 ? afszum * kvamp : afszum * aampv)
  kbalance  line      ibal1, ibdur, ibal2
            outs      aout * kbalance, aout * (1 - kbalance)
if ( p23 != 1 ) goto bezefekt100
  gaout100  =  aout
bezefekt100:
if ( p24 != 1 ) goto bezefekt101
  gaout101  =  aout
bezefekt101:
if ( p25 != 1 ) goto bezefekt102
  gaout102  =  aout
bezefekt102:
endin

;;;;;;;;;;;;;;;

; uzywa funkcji p14 do zcytania barw
instr 2
  itime     =  p4
  igranica  =  p5
  ind       =  0
  itczyn1   =  p6
  itczyn2   =  p7
  ifreq     =  p8
  ifczyn1   =  p9
  ibalance  =  p10
  ibczyn    =  p11
  iamp      =  p12
  iaczyn1   =  p13

reset:
            timout    0, p3/itime, contin
            reinit    reset
contin:
  ind       =  ind + 1
  itime     =  ( ind <= igranica ? itime * itczyn1 : itime * itczyn2 )
  ifreq     =  ifreq * ifczyn1
  aout      loscil    iamp, ifreq, p14
  iamp      =  iamp * iaczyn1
  ibalance  =  ( ibalance * ibczyn == 1 ? ibalance * ibczyn : frac ( ibalance * ibczyn ))
            rireturn  
            outs      aout * ibalance, aout * ( 1 - ibalance )
if ( p15 != 1 ) goto  bezefekt100
  gaout100  =  aout 
bezefekt100:
if ( p16 != 1 ) goto bezefekt101
  gaout101  =  aout
bezefekt101:
if ( p17 != 1 ) goto bezefekt102
  gaout102  =  aout
bezefekt102:
endin

;;;;;;;;;;;;;;;

;uzywa funkcji p10 do czytania barw
instr 21
  ibalance  =  p9 
  iamp      =  p4
  ifcz1     =  p5
  ifcz2     =  p6
  ifcz3     =  p7
  ift1      =  p3 * p8                            ; p8 to wielkosc procentowa
  ift2      =  p3 - ift1

  kfreq     linseg    ifcz1, ift1, ifcz2, ift2, ifcz3
  aout      loscil    iamp, kfreq, p10
            outs      aout * ibalance, aout * ( 1 - ibalance ) ;
if ( p11 != 1 ) goto bezefekt100
  gaout100  =  aout
bezefekt100:
if ( p12 != 1 ) goto bezefekt101
  gaout101  =  aout
bezefekt101: 
if ( p13 != 1 ) goto bezefekt102
  gaout102  =  aout
bezefekt102:
endin

;;;;;;

instr 22
  ibalance  =  p9
  iamp      =  p4
  ifcz1     =  p5
  ifcz2     =  p6
  ifcz3     =  p7
  ift1      =  p3 * p8                            ; p8 to wielkosc procentowa
  ift2      =  p3 - ift1

  kamp      expon     .001, p3, iamp
  kfreq     linseg    ifcz1, ift1, ifcz2, ift2, ifcz3
  aout      loscil    kamp, kfreq, p10            ;
            outs      aout * ibalance, aout * ( 1 - ibalance ) ;
if ( p11 != 1 ) goto bezefekt100
  gaout100  =  aout
bezefekt100:
if ( p12 != 1 ) goto bezefekt101
  gaout101  =  aout
bezefekt101:
if ( p13 != 1 ) goto bezefekt102
  gaout102  =  aout
bezefekt102:
endin

;;;;;;;;;;;;;;;

instr 100
  irvczas   =  p4
  iamp      =  p5
  idur      =  p3
  idel      =  p6
  irel      =  p7

  kramp     linen     iamp, idel, idur, irel
  arout     =  gaout100 * kramp
  aout      reverb    arout, irvczas
            outs      aout * .5, aout * .5
  gaout100  =  0
endin

;;;;;;;;;;;;;;;

instr 101
  icmbczas  =  p4
  iamp      =  p5
  idur      =  p3
  idel      =  p6
  irel      =  p7  
  igest     =  p8

  kcamp     linen     iamp, idel, idur, irel
  acout     =  gaout101 * kcamp
  aout      comb      acout, icmbczas, igest
            outs      aout*.5, aout*.5
  gaout101  =  0
endin

;;;;;;;;;;;;;;;;;

instr 102
  idczas    =  p4
  iamp      =  p5
  idur      =  p3 
  idel      =  p6
  irel      =  p7
 

  kdamp     linen     iamp, idel, idur, irel
  adout     =  gaout102 * kdamp
  aout      delay     adout, idczas
            outs      aout*.5, aout*.5
  gaout102  =  0
endin  

;;;;;;;;;;;;;;;;;

instr 3
  iamp      =  ampdb(p4)
  ifreq     =  p5
  ifnr      =  p6 
  imeth     =  p7
  iv1       =  p8
  iv2       =  p9
  it1       =  p10
  it2       =  p3 - p10
  idur      =  p3
  idel      =  p11
  irel      =  p12                                ;  WYJSCIE NA EFEKTY !!!
  iparm1    =  p25
  iparm2    =  p26
  ivfnr     =  p13
  ivfreq    =  p14
  ivv1      =  p15
  ivv2      =  p16
  ivt1      =  p17
  ivt2      =  p3 - p17 
  ivamp     =  p18
  ivdel     =  p19
  ivrel     =  p20
  ibalance  =  p21
  ivsus     =  p3 - ( ivdel + ivrel )

  kfreq     linseg    ifreq, it1, iv1, it2, iv2
  kamp      linen     iamp, idel, idur, irel
  kvfreq    linseg    ivfreq, ivt1, ivv1, ivt2, ivv2
  kvampl    linseg    0, ivdel, ivamp, ivsus, ivamp, ivrel, 0
  kvibr     oscil     kvampl, kvfreq, ivfnr
if ( imeth > 1 ) goto parametr1
  aout1     pluck     kamp, kfreq+kvibr, ifreq*.9, ifnr, imeth
  aout2     pluck     kamp, kfreq+kvibr, ifreq*1.1, ifnr, imeth
            goto      dalej
parametr1:
if ( imeth > 3 ) goto parametr2
  aout1     pluck     kamp, kfreq+kvibr, ifreq*.9, ifnr, imeth, iparm1
  aout2     pluck     kamp, kfreq+kvibr, ifreq*1.1, ifnr, imeth, iparm1
            goto      dalej
parametr2:
  aout1     pluck     kamp, kfreq+kvibr, ifreq*.9, ifnr, imeth, iparm1, iparm2
  aout2     pluck     kamp, kfreq+kvibr, ifreq*1.1, ifnr, imeth, iparm1, iparm2
dalej:
  aout      =  aout1 + aout2
            outs      aout * ibalance, aout * ( 1 - ibalance )
if ( p22 != 1 ) goto bezefekt100
  gaout100  =  aout
bezefekt100:
if ( p23 != 1 ) goto bezefekt101
  gaout101  =  aout
bezefekt101:
if ( p24 != 1 ) goto bezefekt102
  gaout102  =  aout
bezefekt102:
endin

;;;;;;;;;;;

instr 4
  ibalance1 =  p4
  iarel     =  p5
  iadel     =  p6
  iaw1      =  ampdb(p7)
  iaw2      =  ampdb(p8)
  iaw3      =  ampdb(p9)
  ifrel     =  p10
  ifdel     =  p11
  ifw1      =  p12
  ifw2      =  p13
  ifw3      =  p14
  inr1      =  p15
  inr2      =  p16
  iff       =  p17
  ibalance2 =  p21

  a3        expseg    ifw1, ifrel, ifw2, ifdel, ifw3
  a2        linseg    iaw1, iarel, iaw2, iadel, iaw3
  aout      fof       a2, a3, iff, 0, 40, .003, .02, .007,  5, inr1, inr2, p3
  abalance  line      ibalance1, p3, ibalance2
            outs      aout*abalance, aout*(1-abalance)
if ( p18 != 1 ) goto bezefekt100
  gaout100  =  aout
bezefekt100:
if ( p19 != 1 ) goto bezefekt101
  gaout101  =  aout
bezefekt101:
if ( p20 != 1 ) goto bezefekt102
  gaout102  =  aout
bezefekt102:
endin
