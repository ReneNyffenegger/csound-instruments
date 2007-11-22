  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;-----------------------------------------------------------
instr 6
  idur1     =  7/sr                               ; READ THE TABLE ONCE
  idur2     =  1/sr
  ifreq     =  sr/8                               ; READ THE TABLE AT 1 POINT PER SAMPLE
  a1        linseg    ifreq,idur1,ifreq,idur2,0,1,0
  a2        oscil     1,a1,1
  a3        reson     a2,sr/10,sr/200             ; THE SYSTEM UNDER TEST
            out       a3
            display   a1,p3                       ; DISPLAY THE IMPULSE RESPONSE
            dispfft   a3,p3,4096,0,1              ; FREQUENCY RESPONSE
endin


