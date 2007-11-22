;MB5.SC  Produces pulsations of soundfile SOUNDIN.5
;        Balanced output
;        (c) Rajmil Fischman, 1997
;--------------------------------------------------
;Functions
;Pulsation frequency fluctuation 
f5  0 4096  7     1     4096  0
;Pulsation envelope
f6  0 4096  19    1     1     270   1 
;Filter center frequency
f7  0 4096  7     0     1024  1     1024  0.3   1024  0.8   1024  0.4
;Filter bandwidth
f8  0 4096  7     1     1024  0     1024  0.3   1024  0.4   1024  0 
;-----------------------------------------------------------------------------
;           |p4 |p5   p6  |p7  	p8 |p9   p10  p11 p12|p13  p14  p15|p16 p17 p18
;  stt dur  |scl|ENVELOPE |SFILE  	   |PULSATION        |CENTER FREQ  |BANDWIDTH
;           |fct|att  dec |cde     skp|freq          pls|min  max  fn |min max fn
;           |   |         |           |min  max  fn  fn |             |%   %
;-----------------------------------------------------------------------------
i5  0  8.547  1      .001   .005   5      0      5      5.3    5      6      200    202    7      .1     .3     8   
i5  .  .      .      .      .      .      .      5.2    5.5    .      .      250    251    .      .      .      .    
i5  .  .      .      .      .      .      .      5.4    5.7    .      .      190    192    .      .      .      .    
i5  .  .      .      .      .      .      .      5.6    5.9    .      .      750    754    .      .      .      .    
i5  .  .      .      .      .      .      .      5.8    6.1    .      .      350    353    .      .      .      .    
i5  .  .      .      .      .      .      .      6      6.4    .      .      900    906    .      .      .      .    
i5  .  .      .      .      .      .      .      6.2    6.7    .      .      450    455    .      .      .      .    
i5  .  .      .      .      .      .      .      6.4    7      .      .      144    146    .      .      .      .    
i5  .  .      .      .      .      .      .      6.8    7.2    .      .      305    307    .      .      .      .    
i5  .  .      .      .      .      .      .      7      7.4    .      .      310    312    .      .      .      .    
i5  .  .      .      .      .      .      .      7.2    7.6    .      .      190    192    .      .      .      .    
e
