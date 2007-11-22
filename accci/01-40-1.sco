; **********************************************************************
; ACCCI:     01-40-1.SCO
; coded:     jpg 10/93

; **********************************************************************
; GEN functions
; waveforms
f1  0 2048  10    1     .4    .2    .1    .1    .05 ; six harmonics
f2  0 1024  10    1                     ; sinus
f41 0 512   7     0     128   10    256   -10   128   0 ; sawtooth

; envelope
f31 0 512   7     0     1     0     79    .5    60    .5    20    .99   120   .4    140   .6    92    0  

; pitch control functions (LFO)
f32 0 512   7     .895  512   .99       ; gen07 line segments    10% rise
f33 0 512   7     1     512   1         ;                         0% rise
f34 0 512   7     .99   512   .99       ;                         0% rise
f35 0 512   7     1     512   .5        ;                        oct down
f36 0 512   7     1     102   1     102   .8    102   .85   102   .7    104   .2 ; more complex

f37 0 512   7     .999  50    .999  412   .85   50    .85 ; third down
f38 0 512   7     .999  20    .999  472   .235  20    .235 ; ~two octs down
f39 0 512   7     .999  25    .999  462   .06   25    .06 ; sixth down
f40 0 512   7     .25   30    .25   110   .5    60    .25   10    .25   60    .5    20    .75   222   .5

; **********************************************************************
; score
;                         freq LFO           amp
; instr 1            if1 iamp2 irate if2  iamp3 if3
i1  1  .5     1      988    1      32     8000   31
i1  2  .      .      .      .      33     .      . ; pitch control is if2
i1  3  .      .      .      .      34     .      .    
i1  4  3      .      .      .      35     .      .    
i1  +  .      .      .      .      36     .      .    

s
; section 2: carrier is sinus, LFO is f37 at 4 times a note
; instr 1            if1 iamp2 irate if2  iamp3 if3
i1  0  18     2      208    4      37     8000   31

s
; section 3: carrier sawtooth, LFO is f40 at 2.2 times a note
; instr 1            if1 iamp2 irate if2  iamp3 if3
i1  0  18     41     1864   2.2    40     8000   31

e