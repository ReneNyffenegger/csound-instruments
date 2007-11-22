f01 0 16384 1     "conga1.sf" 0     4     0     0   
f02 0 16384 1     "conga1a.sf"      0     4     0     0   
f03 0 8192  1     "conga3.sf" 0     4     0     0   
f04 0 16384 1     "conga4.sf" 0     4     0     0   
f05 0 16384 1     "conga5.sf" 0     4     0     0   
f06 0 4096  1     "conga6.sf" 0     4     0     0   
f07 0 16384 1     "conga7.sf" 0     4     0     0   
f08 0 16384 1     "conga8.sf" 0     4     0     0   
;conga9 is a bad EPS sample
f10 0 32768 1     "conga10.sf"      0     4     0     0   
f11 0 16384 1     "conga11.sf"      0     4     0     0   
f12 0 8192  1     "conga12.sf"      0     4     0     0   
f13 0 32768 1     "conga13.sf"      0     4     0     0   
f14 0 8192  1     "conga14.sf"      0     4     0     0   
f15 0 4096  1     "conga15.sf"      0     4     0     0   
f16 0 32768 1     "conga16.sf"      0     4     0     0   
f17 0 16384 1     "conga17.sf"      0     4     0     0   
f18 0 16384 1     "conga18.sf"      0     4     0     0   
f19 0 32768 1     "conga19.sf"      0     4     0     0   
;table mapping midi note numbers to sample #s:
;				s#	mn#s
f20 0 128   -7    1     36              ;locs 0 to 35
      1     1                           ;loc 36
      2     2                           ;locs 37 to 38
      3     2                           ;locs 39 to 40
      4     1                           ;loc 41
      5     2                           ;locs 42 to 43
      6     2                           ;locs 44 to 45
      7     2                           ;locs 46 to 47
      8     1                           ;loc 48
      10    4                           ;locs 49 to 52
      11    1                           ;loc 53
      12    2                           ;locs 54 to 55
      13    2                           ;locs 56 to 57
      14    2                           ;locs 58 to 59
      15    1                           ;loc 60
      16    3                           ;locs 61 to 63
      17    1                           ;loc 64
      18    1                           ;loc 65
      19    62    19                    ;loc 66 on
;table of root keys, loop mode, loop start, loop end, indexed by (fn-1)*4
f21 0 128   -2
;                               root    mode    loops   loope
                        36      1       10310   10675 ;smp 1
                        38      1       10662   10823 ;smp 2
                        40      1       7791    7967 ;smp 3
                        41      0       0       1 ;smp 4
                        43      0       0       1 ;smp 5
                        45      0       0       1 ;smp 6
                        47      0       0       1 ;smp 7
                        48      1       5962    6123 ;smp 8
                        52      1       20043   20200 ;smp 9
                        52      1       20043   20200 ;smp 10
                        53      0       0       1 ;smp 11
                        55      1       5190    5537 ;smp 12
                        57      0       0       1 ;smp 13
                        59      0       0       1 ;smp 14
                        60      0       0       1 ;smp 15
                        62      0       0       1 ;smp 16
                        63      0       0       1 ;smp 17
                        65      0       0       1 ;smp 18
                        67      0       0       1 ;smp 19
;vel to amp scaling function
f22 0 129   -5    100   129   32767
; quick run through all the samples (Note: #10 doesn't sound on such short notes)
;                     nn    vel
i 1 0.00      0.10   36     80  
i . +  .      <      <    
i . 
i . 
i .
i . 
i .
i .
i .
i .
i .
i .
i .
i .
i .
i .
i .
i .
i . .  .      67     127         
s
i 1 0.0       0.21   48     78  
i 1 0.09      0.18   55     84  
i 1 0.22      0.11   60     96  
i 1 0.33      0.14   63     124 
i 1 0.43      1.22   52     126 
i 1 .  .1     68     127 
e
