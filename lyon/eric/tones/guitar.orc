
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  giamp     =  1000.
instr 1
  isinefunc =  1
  ircosfunc =  2
        
  ipartial  =  p12                                ;partial number
  idf       =  p13+1.0                            ;partial detunefac
        ;ip = cpspch(p4)                
  ip        =  p4
  ifreq     =  ip*ipartial*idf                    ;frequency of harmonic
  idevdepth =  p5 *ifreq                          ;random deviation depth
  idevspeed =  p6                                 ;speed for ''
  iseed1    =  p7                                 ;random seed
  ivibdepth =  p8 * ifreq                         ;vibrato depth
  ivibspeed =  p9                                 ;vibrato speed
  ircphase  =  p10                                ;phase of rcos cancellation
  ircspeed  =  p11                                ;speed of rcos cancellation
  iamp      =  p14 * giamp
  kenv      linseg    0,.01, giamp, p3-.02, giamp, .01, 0
        
  kpenv     oscili    kenv, ircspeed, ircosfunc, ircphase
  kspdev    randi     idevdepth, idevspeed, iseed1
  kvibrato  oscili    ivibdepth, ivibspeed, isinefunc
  kfreq     =  ifreq + kvibrato + kspdev
  apart     oscili    kpenv, kfreq, isinefunc
        
            out       apart
endin
