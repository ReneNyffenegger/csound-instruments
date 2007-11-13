;====================================================================;
;       test score for DX7 alg 16 orc                                ;
;                                                                    ;
;       (imitates the PLUK16.1 voice...sort of)                      ;
;                                                                    ;
;       RFP 11:40 7-19-89                                            ;
;====================================================================;
f01     0       512     10      1
; operator output level to amp scale function (data from Chowning/Bristow)
f02     0       128     7       0       10      .003    10      .013
        10      .031    10      .079    10      .188    10      .446
        5       .690    5       1.068   5       1.639   5       2.512
        5       3.894   5       6.029   5       9.263   4       13.119
        29      13.119
; rate scaling function
f03     0       128     7       0       128     1
; eg rate rise function for lvl change between 0 and 99 (data from Opcode)
f04     0       128     -7      38      5       22.8    5       12      5
        7.5     5       4.8     5       2.7     5       1.8     5       1.3
        8       .737    3       .615    3       .505    3       .409    3       
        .321    6       .080    6       .055    2       .032    3       .024
        3       .018    3       .014    3       .011    3       .008    3       
        .008    3       .007    3       .005    3       .003    32      .003
; eg rate rise percentage function
f05     0       128     -7      .00001  31      .00001  4       .02     5
        .06     10      .14     10      .24     10      .35     10      .50
        10      .70     5       .86     4       1.0     29      1.0
; eg rate decay function for lvl change between 0 and 99
f06     0       128     -7      318     4       181     5       115     5
        63      5       39.7    5       20      5       11.2    5       7       
        8       5.66    3       3.98    6       1.99    3       1.34    3       
        .99     3       .71     5       .41     3       .15     3       .081
        3       .068    3       .047    3       .037    3       .025    3
        .02     3       .013    3       .008    36      .008
; eg rate decay percentage function
f07     0       128     -7      .00001  10      .25     10      .35     10
        .43     10      .52     10      .59     10      .70     10      .77
        10      .84     10      .92     9       1.0     29      1.0
; eg level to peak deviation mapping function (index in radians = Index / 2PI)
f08     0       128     -7      0       10      .000477 10      .002
        10      .00493  10      .01257  10      .02992  10      .07098
        5       .10981  5       .16997  5       .260855 5       .39979
        5       .61974  5       .95954  5       1.47425 4       2.08795
        29      2.08795
; velocity to amp factor mapping function (rough guess)
f09     0       129     9       .25     1       0
; velocity sensitivity scaling function
f10     0       8       -7      0       8       1
; feedback scaling function
f11     0       8       -7      0       8       7            
f12   0    32    -2    99    0   71   41   54   61   
        99   95   99   0   
        0   1   1.00   -7   
        0   
f13   0    32    -2    46    0   59   46   5   38   
        98   95   95   0   
        0   0   1.0001   -7   
        0   
f14   0    32    -2    99    0   71   41   54   61   
        99   95   99   0   
        0   1   1.202   7   
        0   
f15   0    32    -2    82    0   56   13   5   35   
        99   96   94   0   
        0   0   1.0   -2   
        0   
f16   0    32    -2    77    0   56   13   4   33   
        99   96   94   0   
        0   0   1.0   0   
        0   
f17   0    32    -2    64    0   56   13   3   33   
        99   96   94   0   
        0   0   4.0   2   
        0   

t 0 20

i01 0 15.49 6.00 87 0 33 32 38 
 12 13 14 15 16 17 2 4000
 3 8 4 6 10 9 11 6
; Algorithm = 2
; Patch name is FATSYNTH B

f0         9                             ;allow for a 4-beat final decay.
e


