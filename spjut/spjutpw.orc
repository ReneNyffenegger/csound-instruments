  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  a1        linseg    0.1,0.05,1000,p3-.1,10000,0.05,0.1
  k3        linseg    0,0.05,0,p3-.1,1,0.05,1
  k1        phasor    p5                          ; p5 IS NOTE FREQUENCY IN CPS
  k2        =  (k1 < k3 ? (k1 /(2*k3)): ((1-2*k3+k1)/(2*(1-k3))))
                                                                           ; k3 IS THE SYMMETRY INDEX, VARIES FROM 0 TO 1. 0.5 GIVES TRIANGLE WAVE
  k4        tablei    k2,1,1                      ; TABLE 1 SHOULD CONTAIN A TRIANGLE WAVE, THE
                                                                           ; SECOND 1 INDICATE USE NORMALIZED (0-1) INDEX INTO TABLE
  a2        =  k4                                 ; a2 IS YOUR AUDIO OUT. MULTIPLY BY AMPLITUDE BEFORE SENDING
            out       a2*a1
endin
