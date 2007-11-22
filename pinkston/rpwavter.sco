t00     120 
f1  0 8192  10    1  
;third partial only
f2  0 8192  10    0     0     3   
;hamming window function
f3  0 512   20    1  
;pyramid function for index control
f4  0 512   7     0     256   1     256   0 
;8th, 9th, and 10th partials only
f5  0 512   10    0     0     0     0     0	  
      0     0     1     1     1   
;6th and 7th partials only
f6  0 512   9     6     1     0     7     1     0   
;1st and 2nd partial
f7  0 512   10    1     1   
;ramp function
f8  0 513   7     0     513   1 
;4 notes with low frequency elipses, audio rate x and y linear movement
;nn	st	dur	amp	fx	fy	Fx	Fy	Ix	Iy	xfn	yfn	xifn	yifn
i01 0  5      20000  100    100    1      3      1      1      1      2      4      4    
;	Px	Py	Qx	Qy
                        0       0       0       .25   
i01 +  .      .      .      200  
i01 +  .      .      100    300
i01 +  .      .      440    220
;4 notes with low frequency x and y, audio rate elipses
i01 +  .      .      1      100    100
i01 +  .      .      .      .      100    200
i01 +  .      .      .      .      100    300
i01 +  .      .      .      .      440    220
;3 notes with audio rate x, y, xsin, but vary ysin from 1 hz to 110
i01 +  .      .      110    55     220    1  
i01 +  .      .      .      .      220    22 
i01 +  .      .      .      .      .      110  
;2 notes with very slow x, y, but 220 xsin, 110 ysin
i01 +  .      .      .25    .125	
i01 +  .      .      .      .      .      .      .      .      .      5    
s
;very slow linear x and y movement, small elipse (.5 amp max)
;nn	st	dur	amp	fx	fy	Fx	Fy	Ix	Iy	xfn	yfn	xifn	yifn
i01 0  5      20000  .1     .2     55     55     .5     .5     1      2      4      4    
;	Px	Py	Qx	Qy
                        0       0       0       .25   
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
i01 +  .      .      .25    .33    .      .      .      .      .      2    
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
i01 +  .      .      .6     .9     .      .      .      .      .      2    
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
s
;increase max elipse size to .75
;nn	st	dur	amp	fx	fy	Fx	Fy	Ix	Iy	xfn	yfn	xifn	yifn
i01 0  5      20000  .1     .2     55     55     .75    .75    1      2      4      4    
;	Px	Py	Qx	Qy
                        0       0       0       .25   
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
i01 +  .      .      .25    .33    .      .      .      .      .      2    
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
i01 +  .      .      .6     .9     .      .      .      .      .      2    
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
s
;increase max elipse size to 1
;nn	st	dur	amp	fx	fy	Fx	Fy	Ix	Iy	xfn	yfn	xifn	yifn
i01 0  5      20000  .1     .2     55     55     1      1      1      2      4      4    
;	Px	Py	Qx	Qy
                        0       0       0       .25   
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
i01 +  .      .      .25    .33    .      .      .      .      .      2    
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
i01 +  .      .      .6     .9     .      .      .      .      .      2    
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
s
;increase max elipse size to 2
;nn	st	dur	amp	fx	fy	Fx	Fy	Ix	Iy	xfn	yfn	xifn	yifn
i01 0  5      20000  .1     .2     55     55     2      2      1      2      4      4    
;	Px	Py	Qx	Qy
                        0       0       0       .25   
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
i01 +  .      .      .25    .33    .      .      .      .      .      2    
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
i01 +  .      .      .6     .9     .      .      .      .      .      2    
i01 +  .      .      .      .      .      .      .      .      .      6    
i01 +  .      .      .      .      .      .      .      .      7      6    
e
