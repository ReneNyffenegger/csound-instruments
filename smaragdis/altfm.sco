f1  0 1024  10    1  
f2  0 1024  7     -1    512   1     512   -1
f3  0 1024  20    2  
f4  0 1024  8     0     256   1     512   -1    256   0 
f5  0 1024  8     1     512   -1    512   1 
f6  0 1024  7     0     256   1     256   0     256   -1    256   0 

i1  0  4      1      100    3000        ;sine waves
i1  +  .      2      .      500         ;triangle waves
i1  +  .      3      .      .           ;hanning window??!
i1  +  .      4      .      .           ;sineish spline
i1  +  .      5      .      .           ;cosineish spline
i1  +  .      6      .      .           ;segmented sine ( 4 parts)
e
i1  0  3      1      100                ;sine waves
i1  +  .      5      .                  ;cosineish spline
i1  .  .      1      200                ;sine waves
i1  .  .      5      .                  ;cosineish spline
i1  .  .      1      300                ;sine waves
i1  .  .      5      .                  ;cosineish spline
i1  .  .      1      500                ;sine waves
i1  .  .      5      .                  ;cosineish spline
i1  .  .      1      800                ;sine waves
i1  .  .      5      .                  ;cosineish spline
i1  .  .      1      1300               ;sine waves
i1  .  .      5      .                  ;cosineish spline
i1  .  .      1      2100               ;sine waves
i1  .  .      5      .                  ;cosineish spline
e
