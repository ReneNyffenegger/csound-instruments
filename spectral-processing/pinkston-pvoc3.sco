f01 0 513   7     0     513   1 
f02 0 513   7     1     513   0 
f03 0 513   1     "pvoctest.fun"    0     4     0   
;
;Interpolate between pvoc."thewind4.pvx" (thethewind) and pvoc.906 (wavest44)
;Both use frame size 1024 and overlap 8.
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	frq1	frq2
i3  0  8      "thewind4.pvx"   1.67   "wavest44.pvx"       16.81  0      1      0      1    
;	ampscl1	ampscl2	frqscl1	frqscl2	ifmod	ifmfn
                        0       0       0       0       0       0     
f0  9
a0      0       9     
s
;Eroica -> Fire (xfade both amp and freq data)
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	frq1	frq2
i3  0  12.585 "eroi.pvx"    5.804  "fire1m44.pvx"       12.585 1      0      1      0    
;	ampscl1	ampscl2	frqscl1	frqscl2	ifmod	ifmfn
                        0       0       0       0       0       0     
;Eroica -> Fire (xfade amp, but use freq data only from Eroica)
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	frq1	frq2
i3  14 12.585 "eroi.pvx"    5.804  "fire1m44.pvx"       12.585 1      0      1      1    
;	ampscl1	ampscl2	frqscl1	frqscl2	ifmod	ifmfn
                        0       0       0       0       0       0     
f0  28
s
;Cello -> PlkPnoLp (pvoc."cello44.pvx" & pvoc."plkpnolp.pvx")
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	frq1	frq2
i3  0  6      "cello44.pvx" 1.5    "plkpnolp.pvx"       6      1      0      1      0    
;	ampscl1	ampscl2	frqscl1	frqscl2	ifmod	ifmfn
                        0       0       0       0       0       0     
;PlkPnoLp -> Cello 
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	frq1	frq2
i3  7  6      "cello44.pvx" 1.5    "plkpnolp.pvx"       6      0      1      0      1    
;	ampscl1	ampscl2	frqscl1	frqscl2	ifmod	ifmfn
                        0       0       0       0       0       0     
;Correct the pitch of the plucked piano note (ca .333 semitones sharp).
;nn	st	dur	pvfn1	len1	pvfn2	len2	amp1	amp2	frq1	frq2
i3  14 6      "cello44.pvx" 1.5    "plkpnolp.pvx"       6      0      1      0      1    
;	ampscl1	ampscl2	frqscl1	frqscl2	ifmod	ifmfn
                        0       0       0       -.333   0       0     
f0  21
e
