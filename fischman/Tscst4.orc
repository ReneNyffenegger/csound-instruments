; TSCST4.ORC  DYNAMIC SPECTRUM INSTRUMENT
;                       (c) Rajmil Fischman, 1997
;-----------------------------------------
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
         
instr 4
;---------------------------------------        ; PARAMETER LIST
;p4                                                                     : OVERALL AMPLITUDE
;p5                                                                     : REFERENCE FREQUENCY (FUNDAMENTAL IF SPECTRUM IS HARMONIC)
;p6                                                                     : ATTACK
;p7                                                                     : DECAY
;p8                                                                     : MAXIMUM AMPLITUDE DEVIATION (% OF EACH COMPONENT AMPLITUDE) 
;p9                                                                     : MAXIMUM FREQUENCY DEVIATION (% OF EACH COMPONENT FREQUENCY)
;p10,p14,p18,p22,p26,p30                                : RELATIVE AMPLITUDES OF COMPONENTS
;p11,p15,p19,p23,p27,p31                                : RELATIVE FREQUENCIES OF COMPONENTS
;p12,p16,p20,p24,p28,p32                                : FUNCTION FOR AMPLITUDE FLUCTUATION OF EACH COMPONENT
;p13,p17,p21,p25,p29,p33                                : FUNCTION FOR FREQUENCY FLUCTUATION OF EACH COMPONENT
;p34                                                                    : PAN FUNCTION
;---------------------------------------        ; INITIALIZATION BLOCK
  idur      =  p3                                 ; DURATION
  iamp      =  p4                                 ; OVERALL AMPLITUDE
  ifreq     =  p5                                 ; REFERENCE FREQUENCY
  iatt      =  p6                                 ; ATTACK
  idec      =  p7                                 ; DECAY
  imaxaf    =  p8/100.00                          ; MAXIMUM AMPLITUDE FLUCTUATION
  imaxff    =  p9/100.00                          ; MAXIMUM FREQUENCY FLUCTUATION
  isr2      =  sqrt(2.0)                          ; SQUARE ROOT OF 2
  isr2b2    =  isr2/2.0                           ; HALF OF SQUARE ROOT OF 2
  imaxpan   =  2                                  ; MAXIMUM PAN
  ipanfunc  =  p34                                ; PAN FUNCTION TABLE
;---------------------------------------------------------------------
  kenv      linen     iamp, iatt, idur, idec      ; OVERALL ENVELOPE
;---------------------------------------        ; PANNING
  kpan      oscil1    0,imaxpan,idur,ipanfunc     ; PANNING TRAJECTORY
if              kpan<-1 kgoto beyondl             ; CHECK FOR PAN BEYOND LEFT SPEAKER
if              kpan>1  kgoto beyondr             ; CHECK FOR PAN BEYOND RIGHT SPEAKER
;---------------------------------------        ; PAN BETWEEN SPEAKERS
  ktemp     =  sqrt(1+kpan*kpan)
  kpleft    =  isr2b2*(1-kpan)/ktemp
  kpright   =  isr2b2*(1+kpan)/ktemp
            kgoto     donepan
beyondl:
                                                                ; PAN BEYOND LEFT SPEAKER
  kpleft    =  2.0/(1+kpan*kpan)
  kpright   =  0
            kgoto     donepan
beyondr:
                                                                ; PAN BEYOND RIGHT SPEAKER
  kpleft    =  0
  kpright   =  2.0/(1+kpan*kpan)
donepan:
;--------------------------------------------; FIRST COMPONENT
  iramp1    =  p10                                ; RELATIVE AMPLITUDE
  imaxaf1   =  iramp1*imaxaf                      ; MAXIMUM AMPLITUDE FLUCTUATION
  iafunc1   =  p12                                ; AMPLITUDE FLUCTUATION FUNCTION
  ifreq1    =  p11*ifreq                          ; FREQUENCY
  imaxff1   =  ifreq1*imaxff                      ; MAXIMUM FREQUENCY FLUCTUATION
  iffunc1   =  p13                                ; FREQUENCY FLUCTUATION FUNCTION
  kampf1    oscil1    0,imaxaf1,idur,iafunc1      ; AMPLITUDE CONTROL
  kfreqf1   oscil1    0,imaxff1,idur,iffunc1      ; FREQUENCY CONTROL
  a1        oscili    iramp1+kampf1,ifreq1+kfreqf1,1 ; OSCILLATOR
;--------------------------------------------; SECOND COMPONENT
  iramp2    =  p14                                ; RELATIVE AMPLITUDE
  imaxaf2   =  iramp2*imaxaf                      ; MAXIMUM AMPLITUDE FLUCTUATION
  iafunc2   =  p16                                ; AMPLITUDE FLUCTUATION FUNCTION
  ifreq2    =  p15*ifreq                          ; FREQUENCY
  imaxff2   =  ifreq2*imaxff                      ; MAXIMUM FREQUENCY FLUCTUATION
  iffunc2   =  p17                                ; FREQUENCY FLUCTUATION FUNCTION
  kampf2    oscil1    0,imaxaf2,idur,iafunc2      ; AMPLITUDE CONTROL
  kfreqf2   oscil1    0,imaxff2, idur, iffunc2    ; FREQUENCY CONTROL       
  a2        oscili    iramp2+kampf2,ifreq2+kfreqf2,1 ; OSCILLATOR
;--------------------------------------------; THIRD COMPONENT
  iramp3    =  p18                                ; RELATIVE AMPLITUDE
  imaxaf3   =  iramp3*imaxaf                      ; MAXIMUM AMPLITUDE FLUCTUATION
  iafunc3   =  p20                                ; AMPLITUDE FLUCTUATION FUNCTION
  ifreq3    =  p19*ifreq                          ; FREQUENCY
  imaxff3   =  ifreq3*imaxff                      ; MAXIMUM FREQUENCY FLUCTUATION
  iffunc3   =  p21                                ; FREQUENCY FLUCTUATION FUNCTION
  kampf3    oscil1    0,imaxaf3,idur,iafunc3      ; AMPLITUDE CONTROL
  kfreqf3   oscil1    0,imaxff3,idur,iffunc3      ; FREQUENCY CONTROL
  a3        oscili    iramp3+kampf3,ifreq3+kfreqf3,1 ; OSCILLATOR
;--------------------------------------------; FOURTH COMPONENT
  iramp4    =  p22                                ; RELATIVE AMPLITUDE
  imaxaf4   =  iramp4*imaxaf                      ; MAXIMUM AMPLITUDE FLUCTUATION
  iafunc4   =  p24                                ; AMPLITUDE FLUCTUATION FUNCTION
  ifreq4    =  p23*ifreq                          ; FREQUENCY
  imaxff4   =  ifreq4*imaxff                      ; MAXIMUM FREQUENCY FLUCTUATION
  iffunc4   =  p25                                ; FREQUENCY FLUCTUATION FUNCTION
  kampf4    oscil1    0,imaxaf4,idur,iafunc4      ; AMPLITUDE CONTROL
  kfreqf4   oscil1    0,imaxff4,idur,iffunc4      ; FREQUENCY CONTROL
  a4        oscili    iramp4+kampf4,ifreq4+kfreqf4,1 ; OSCILLATOR
;--------------------------------------------; FIFTH COMPONENT
  iramp5    =  p26                                ; RELATIVE AMPLITUDE
  imaxaf5   =  iramp5*imaxaf                      ; MAXIMUM AMPLITUDE FLUCTUATION
  iafunc5   =  p28                                ; AMPLITUDE FLUCTUATION FUNCTION
  ifreq5    =  p27*ifreq                          ; FREQUENCY
  imaxff5   =  ifreq5*imaxff                      ; MAXIMUM FREQUENCY FLUCTUATION
  iffunc5   =  p29                                ; FREQUENCY FLUCTUATION FUNCTION
  kampf5    oscil1    0,imaxaf5,idur,iafunc5      ; AMPLITUDE CONTROL
  kfreqf5   oscil1    0,imaxff5,idur,iffunc5      ; FREQUENCY CONTROL
  a5        oscili    iramp5+kampf5,ifreq5+kfreqf5,1 ; OSCILLATOR
;--------------------------------------------; SIXTH COMPONENT
  iramp6    =  p30                                ; RELATIVE AMPLITUDE
  imaxaf6   =  iramp6*imaxaf                      ; MAXIMUM AMPLITUDE FLUCTUATION
  iafunc6   =  p32                                ; AMPLITUDE FLUCTUATION FUNCTION
  ifreq6    =  p31*ifreq                          ; FREQUENCY
  imaxff6   =  ifreq6*imaxff                      ; MAXIMUM FREQUENCY FLUCTUATION
  iffunc6   =  p33                                ; FREQUENCY FLUCTUATION FUNCTION
  kampf6    oscil1    0,imaxaf6,idur,iafunc6      ; AMPLITUDE CONTROL
  kfreqf6   oscil1    0,imaxff6,idur,iffunc6      ; FREQUENCY CONTROL
  a6        oscili    iramp6+kampf6,ifreq6+kfreqf6,1 ; OSCILLATOR
;--------------------------------------------; MIX
  iampsum   =  iramp1+iramp2+iramp3+iramp4+iramp5+iramp6 ; MAXIMUM AMPLITUDE
  aout      =  kenv*(a1+a2+a3+a4+a5+a6)/(iampsum) ; BALANCED MIX
;---------------------------------------------------------
            outs      kpleft*aout,kpright*aout    ; OUTPUT
endin

