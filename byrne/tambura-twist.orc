  sr        =  44100                              ; AUDIO SAMPLING RATE IN Khz
  kr        =  44100                              ; CONTROL RATE IN Khz
  ksmps     =  1         
  nchnls    =  1                                  ; NUMBER OF CHANNELS

instr 1             ; INSTRUMENT  NUMBER

; CONTROL  ENVELOPE  WHICH GRADUALLY  MODIFIES  THE FORMANT FREQUENCY
  ktwist    linseg    1 ,p3*.7 ,1.2 ,p3*.2,1.1 ,p3*.1 ,1

; SEE CSOUND MANUAL FOR ARGUMENT  LIST MEANING AND ORDER
  a1        fof       5000, p4, ktwist, 0, 0, .003, .02, .005, 20, 1, 19, p3, 0, 1

            out       a1                          ; OUTPUT SIGNAL  a1

endin                              ; END OF INSTRUMENT

