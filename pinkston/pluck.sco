; Square Wave
f01     0       512     10      1   0   .3   0   .2    0  .14    0 .111
;p7=1... simple averaging, use noise source (ifn = 0)
;                       amp     pitch   ifn     imeth   iparm1  iparm2
i1      0       1       20000   7.05    0       1
i1      .5      .       .       8.03
i1      1       .       .       9.01
f0      2.5
s 
;p7=2... stretched averaging ... p8=2 (stretch factor)
;                       amp     pitch   ifn     imeth   iparm1  iparm2  ipch
i1      0       5       20000   7.05    0       2       3       0       5.00
i1      1       4       .       8.03
i1      2       3       .       9.01
f0      6
s
;p7=3... simple drum.  Use noise source, then square wave; vary roughness:
;                       amp     pitch   ifn     imeth   iparm1  iparm2 ipch
i1      0       .5      30000   7.05    0       3       .1       0       0
i1     .5       .       .       8.03    .       .       .3
i1      1       .       .       9.01    .       .       .5
i1      2       .       .       7.05    1       .       .1
i1      2.5     .       .       8.03    .       .       .3
i1      3       .       .       9.01    .       .       .5
f0      4
s
;p7=4... stretched drum ... p9=2 (stretch factor)
;                       amp     pitch   ifn     imeth   iparm1  iparm2  ipch
i1      0       .5      30000   7.05    0       4       .1      2       5.00
i1     .5       .       .       8.03    .       .       .3
i1      1       .       .       9.01    .       .       .5
i1      2       .       .       7.05    1       .       .1      .       0
i1      2.5     .       .       8.03    .       .       .3
i1      3       .       .       9.01    .       .       .5
f0      4
s
;p7=5... weighted averaging ... p8=.9 (current) p9=.1 (prev. adj.)
i1      0       .5      30000   7.05    0       5       .9      .1      0
i1      .5      .       .       8.03
i1      1       .       .       9.01
f0      2
s
;p7=5... weighted averaging ... p8=.1 (current) p9=.9 (prev. adj.)
i1      0       .5      30000   7.05    0       5       .1      .9
i1      .5      .       .       8.03
i1      1       .       .       9.01
f0      2
s
;p7=6... 1st order recursive
i1      0       .5      30000   7.05    0       6        0      0
i1      .5      .       .       8.03
i1      1       .       .       9.01
e
