  sr        =  44100
  kr        =  4410
  ksmps     =  10.0
  nchnls    =  1

;===============================================================;
;            Example Additive Synthesis Instrument              ;
;                                                               ;  
; This instrument is loosely based on one of the MSP tutorial   ;
; examples by Christopher Dobrian. Six sine wave oscillators    ;
; are summed together. The frequency of each sine wave is some  ;
; multiple of the basic pitch, specified in PCH in p5. Each one ;
; has its own envelope function and may have a different gain   ;
; factor, as well. RP                                           ;
;===============================================================; 

instr     1
  iamp      =  p4
;set values for ptl#, amp, and env func
  icps1     =  cpspch(p5)
  igain1    =  p6
  ifn1      =  p7
  icps2     =  icps1 * p8
  igain2    =  p9
  ifn2      =  p10
  icps3     =  icps1 * p11
  igain3    =  p12
  ifn3      =  p13
  icps4     =  icps1 * p14
  igain4    =  p15
  ifn4      =  p16
  icps5     =  icps1 * p17
  igain5    =  p18
  ifn5      =  p19
  icps6     =  icps1 * p20
  igain6    =  p21
  ifn6      =  p22
; End initialization section
  kamp1     oscil1i   0,igain1,p3,ifn1
  kamp2     oscil1i   0,igain2,p3,ifn2
  kamp3     oscil1i   0,igain3,p3,ifn3
  kamp4     oscil1i   0,igain4,p3,ifn4
  kamp5     oscil1i   0,igain5,p3,ifn5
  kamp6     oscil1i   0,igain6,p3,ifn6
  asig1     oscili    kamp1,icps1,1
  asig2     oscili    kamp2,icps2,1
  asig3     oscili    kamp3,icps3,1
  asig4     oscili    kamp4,icps4,1
  asig5     oscili    kamp5,icps5,1
  asig6     oscili    kamp6,icps6,1
  asum      =  asig1+asig2+asig3+asig4+asig5+asig6
  kenv      linen     iamp,.001,p3,.2             ;overall envelope
  afinal    =  kenv * asum
            out       afinal
endin
