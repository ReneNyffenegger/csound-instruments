
f1  0 1024  19    1     1     0     1   ;FUNCTION TABLE FOR CLOCKWISE ROTATION

f2  0 1024  19    1     1     180   1   ;FUNCTION TABLE FOR ANTI-CLOCKWISE ROTATION

f3  0 1024  9     .5    1     0         ;FUNCTION TABLE FOR DISTANCE

f4  0 1024  9     .5    1     90        ;FUNCTION TABLE FOR DOPPLER SHIFT 

f5  0 0     1     "b603a.wav" 0     4     0 ;INPUT WAV.FILE ISLOOP 4041 IELOOP 19848

f6  0 0     1     "b603o.wav" 0     4     0 ;INPUT WAV.FILE ISLOOP 4385 IELOOP 19765


;    idur  inote isloop   ieloop  inrot idrot  isrot iwavf idiam
;================================================================
i1  0  8      8.09   4041   19848  1      1      .5     5      13   
i1  4  8      9.00   4385   19765  1.5    2      .25    6      13   
i1  8  5      8.09   4041   19848  1      2      .75    5      13   
i1  14 8      8.09   4041   19848  1      1      .5     5      13   
i1  14 8      9.00   4385   19765  1      2      .5     6      13   

;    idur krvbt
;===============
i99 0  25     2.5 

e
