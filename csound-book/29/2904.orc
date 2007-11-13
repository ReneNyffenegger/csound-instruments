  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     2904
  idlev     =  1.0                                ; LEVEL OF DIRECT GUITAR SIGNAL
  isublev   =  0.4                                ; LEVEL OF SUB OCTAVE SIGNAL
  istl      =  0.4                                ; SCHMIDTT TRIGGER LEVEL FOR SQUARE WAVE
  iincr     =  sr/8                               ; USED FOR INCREMENTING DIVIDE BY 2 COUNTER
  ain       soundin   "guitar.wav"               ; THE SOUND FILE TO BE PROCESSED
  alpf      butterlp  ain,700                     ; 700 Hz LPF
  kpwr      rms       alpf
  ahigh     table     (alpf-istl*kpwr)/5000+16,2
  alow      table     (-alpf-istl*kpwr)/5000+16,2
  asqr1     samphold  ahigh-alow, ahigh+alow
  adela     delay1    asqr1
  agate     =  -asqr1+adela
  aphs      phasor    abs(agate*iincr)
  asub1     table     aphs,1,1
  asub2     tone      asub1,3000
  asub      =  asub2*ain
  aout      butterlp  asub,600
            out       0.5*(isublev*aout+idlev*ain)
endin
