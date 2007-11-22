; Vibrato.o

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

                                   ;P4=FREQUENCY IN HZ
                                   ;P5=AMP
                                   ;P6=VIBRATO WIDTH AS A PERCENTAGE OF CENTER FREQUENCY
                                   ;P7=VIBRATO FREQUENCY

instr     1
  kdev      randi     p6,125                      ;RANDOM VIBRATO WIDTH DEVIATION OF +/- P6
  avib      oscil     p6,p7,1                     ;VIBRATO HAS THE SHAPE OF A SINE WAVE
  avib      =  (avib+kdev)+1                      ;ADD 1 FOR MULTIPLICATION

  afreq     =  avib*p4                            ;APPLY VIBRATO TO P4 (FREQ IN SCORE)
  aenv      linen     p5,.01,p3,.05               ;AMPLITUDE ENVELOPE
  asig      oscili    aenv,afreq,1                ;SINE WAVE WITH VIBRATO AND AMPLITUDE ENVELOPE
            out       asig
endin

