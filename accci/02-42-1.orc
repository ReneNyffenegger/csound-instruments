; ************************************************************************
; ACCCI:      02-42-1.ORC
; timbre:     stretched chord
; synthesis:  additive same units(02)
;             basic instrument with continuous pitch control(42)
; source:     #440  Variable Pitched Drums, Risset(1969)
; coded:      jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 

instr 1; *****************************************************************
  idur      =  p3
  iamp1     =  p4                                 ;
  ifq1      =  p5                                 ;
  iamp2     =  p6                                 ;amplitudes and frequencies
  ifq2      =  p7                                 ;of three parallel waveforms
  iamp3     =  p8                                 ;
  ifq3      =  p9                                 ;
  ipcf      =  p10                                ;;;;;;;;;;;;;;pitch control function parameter
  iatt1     =  p11                                ;
  idec1     =  p12                                ;
  iatt2     =  p13                                ;envelope
  idec2     =  p14                                ;parameters
  iatt3     =  p15                                ;
  idec3     =  p16                                ;

; init time calculation of an extra input parameter for expseg
  iseg1     =  idur-(iatt1+idec1)
  iseg2     =  idur-(iatt2+idec2)
  iseg3     =  idur-(iatt3+idec3)
; getting the correct start value for the pitch control function
if ipcf > 1 igoto nopitchoscil
  istartval =  .9
            goto      start
nopitchoscil:
  istartval =  0
            goto      start
start:
  apc       oscili    1, 1/idur, ipcf
  apc       =  istartval + apc                    ; pitch control signal

  ae1       expseg    .00097,iatt1, .99,iseg1, .9,idec1, .00097 ; unit 1
  ae1       =  ae1 * iamp1
  a1        oscili    ae1, ifq1*apc, 11

  ae2       expseg    .0039,iatt2, .99,iseg2, .99,idec2, .0000000059 ; unit 2
  ae2       =  ae2 * iamp2
  a2        oscili    ae2, ifq2*apc, 12

  ae3       expseg    .0039,iatt3, .99,iseg3, .99,idec3,.00000000000009 ; unit 3
  ae3       =  ae3 * iamp3
  a3        oscili    ae3, ifq3*apc, 13
            outs      a1+a2+a3, a1+a2+a3
endin
