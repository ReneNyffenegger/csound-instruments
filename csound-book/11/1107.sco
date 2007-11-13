
;1107.SCO   SIMULATION OF VOCAL SOUND 
;             (C) RAJMIL FISCHMAN, 1997
;---------------------------------------
;SINEWAVE FOR PULSE GENERATION
f 1 0 4096 10 1
;PITCH/RANDOM NUMBER FREQUENCY FLUCTUATION FUNCTION
f 2 0 512  7  0 50 .6 50 .8 50 .3 50 .7 50 .9 50 .4 50 .1 50 .01 62 .2
;----------------------------------------------------
;            p3   p4     p5    p6     p7    p8   p9
;INSTR START DUR  AMP    FUND  ATTACK DECAY MINR MAX
;                        FREQ               RAND RAND
;                                           FREQ FREQ 
;----------------------------------------------------
;SINGLE SHORT SOUND
i 1107     0     .5   5000   70    .1     .1    10   15
;MIX
i 1107     1     5    2500   490   4      .5    40   45
i 1107     1     5    2500   615   4      .5    40   45
i 1107     3.5   7    2500   60    .5     1.5   3    50

