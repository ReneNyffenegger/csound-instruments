
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  giamp     =  6000.
instr 1
  ifreqfunc =  1
  isinefunc =  2
  itranspfunc  =      3
  ircosfunc =  4
  ifreqfunc2   =      5
        
  ipartial  =  p12
  ifspeed   =  p4                                 ;speed of freqfunc read
  idevdepth =  p5                                 ;random deviation depth
  idevspeed =  p6                                 ;speed for ''
  iseed1    =  p7                                 ;random seed
  itranspfac   =      p8*ipartial                 ;transposefac for freqfunc
  itrspeed  =  p9                                 ;speed of transposefunc read
  ivibdepth =  p10                                ;vibrato depth
  ivibspeed =  p11                                ;vibrato speed
  ircphase  =  p13                                ;phase of rcos cancellation
  ircspeed  =  p14                                ;speed of rcos cancellation
        
  kenv      linseg    0,.1, giamp, p3-.2, giamp, .1, 0
  kpenv     oscili    kenv, ircspeed, ircosfunc, ircphase
  kspdev    randi     idevdepth, idevspeed, iseed1
  ktransp   oscili    1., itrspeed, itranspfunc
  kvibrato  oscili    ivibdepth, ivibspeed, isinefunc
  kfincr    =  ifspeed*kspdev
  kfreq     oscili    itranspfac, ifspeed, ifreqfunc
        ; experimental
        ;kfreq1 oscili itranspfac, ifspeed*.9, ifreqfunc2
        ;kfreq = (kfreq+kfreq1)/2.0
        ;resume old orch
  kfreq     =  kfreq*ktransp
  kvibrato  =  (kvibrato)*kfreq
  kspdev    =  (kspdev)*kfreq
  kfreq     =  kfreq + kspdev + kvibrato
  apart1    oscili    kpenv, kfreq, isinefunc
            out       apart1
endin