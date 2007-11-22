f01 0 8     2     1     2     3     4     5     6     7     8   
f02 0 8     -2    1     2     3     4     5     6     7     8   
i01 0  1      1    
i01 1  1      2    
s
; try some gen07 tests
;an envlp shape		#	val	nlocs	val1	nlocs	val2	nlocs	val3...
f03 0 128   7     0     16    10    32    5     64    5     16    0  
;a linear rise
f04 0 129   7     0     129   1 
i02 0  1      3      128     
i02 1  1      4      129  
s
; try some gen05 tests
;an exponential envlp	#	val	nlocs val	nlocs	val...
f05 0 128   5     .0001 16    10    32    5     64    5     16    .0001
;an exponential rise
f06 0 129   5     .0001 129   1 
i02 0  1      5      128     
i02 1  1      6      129  


