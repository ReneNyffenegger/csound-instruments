  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   01
  iamp      =  p4                                 ; AMPLITUDE SCALING OF SAMP
  iatim     =  p5                                 ; STARTING TIME FACTOR
  ibtim     =  p6                                 ; ENDING TIME FACTOR
  iapch     =  p7                                 ; STARTING PITCH FACTOR
  ibpch     =  p8                                 ; ENDING PITCH FACTOR
  iwsize    =  p9                                 ; WINDOW SIZE IN SAMPS
  irandw    =  p10                                ; RAND WINDOW SIZE BW (IN SAMPS)
  ioverlap  =  p11                                ; DENS OF OVERLAPPING WINDOWS
  ifn1      =  71                                 ; FTABLE SOUND
  ifn2      =  81                                 ; FTABLE WINDOW
  ibeg      =  0                                  ; WHERE TO START READING FTABLE
  itimemode =  0                                  ; MAKE atimewarp SCALING FACTOR
  atimewarp line      iatim, p3, ibtim            ; TIME SCALING
  aresample line      iapch, p3, ibpch            ; PITCH SCALING
  a1        sndwarp   iamp, atimewarp, aresample, ifn1, ibeg, iwsize, irandw, ioverlap, ifn2, itimemode 
            out       a1
endin
