;Within Csound you can measure the impulse response of a Csound ugen with
;something like:

;Orc
  sr        =  44100
  kr        =  44100                              ;avoid problems with impulse generation
  ksmps     =  1
  nchnls    =  1
;-----------------------------------------------------------
instr 6
  idur1     =  7/sr                               ;read the table once
  idur2     =  1/sr
  ifreq     =  sr/8                               ;read the table at 1 point per sample
  a1        linseg    ifreq,idur1,ifreq,idur2,0,1,0
  a2        oscil     1,a1,1
  a3        reson     a2,sr/10,sr/200             ;the system under test
            out       a3
            display   a1,p3                       ;display the impulse response
            dispfft   a3,p3,4096,0,1              ;frequency response
endin

