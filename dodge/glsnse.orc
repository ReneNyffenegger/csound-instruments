; GLSNSE.O
; CSOUND CODE FOR RANDOM RING MODULATING INSTRUMENT DESCRIBED IN SECTION
; 3.11B AND FIGURE. 3.25 OF "COMPUTER MUSIC" - DODGE

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1

; p3           =         dur
; p4           =         pitch
; p5           =         amp
; p6           =         bw%
; p7           =         gliss interval (in octave.point.decimal notation)

  ifreq     =  cpspch(p4)                         ; CONVERT PITCH TO HZ
  iband     =  p6*ifreq                           ; BANDWIDTH AS A PERCENTAGE OF STARTING FREQUENCY
  ioct      =  octpch(p4)                         ; CONVERT PITCH TO OCTAVE.POINT.DECIMAL NOTATION
  igliss    =  p7                                 ; GLISS INTERVAL IN OCTAVE NOTATION

  amp       randi     p5,iband
  aenv      linen     amp,.01,p3,.05
  agliss    linseg    0,p3,igliss
  afreq     =  cpsoct     (ioct+agliss)

  aout      oscili    aenv,afreq,1
            out       aout
endin
