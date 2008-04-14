f01 0 513   7     0     513   1 
f02 0 513   7     1     513   0 
f03 0 513   1     "pvoctest.fun"    0     4     0   
;
;Cross synthesis with pvoc.904 and pvoc.905 (eroi.wav)
;Both use frame size 1024 and overlap 8.
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	ifmod	ifmfn
i2  0  3.646  "thewind4.pvx"   1.67   "eroi.pvx"    3.646  0      1      0      0    
i2  4  .      .      .      .      .      1      0    
i2  8  3.646  "eroi.pvx"    3.646  "thewind4.pvx"   1.67   0      1    
i2  12 .      .      .      .      .      1      0    
f0  16.0
s
;Cross synthesis with pvoc."thewind4.pvx" and pvoc.906 (wavest44.wav)
;Both use frame size 1024 and overlap 8.
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	ifmod	ifmfn
i2  0  8      "thewind4.pvx"   1.67   "wavest44.pvx"       16.81  0      1      0      0    
i2  8  8      "thewind4.pvx"   1.67   "wavest44.pvx"       16.81  .5     .5  
i2  16 .      .      .      .      .      1      0    
f0  26
s
;Same 2 pvoc files, now with freq mod control function
f04 0 513   7     0     128   1     256   -1    129   0 
;
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	ifmod	ifmfn
i2  0  8      "thewind4.pvx"   1.67   "wavest44.pvx"       16.81  .5     .5     3      4    
e
