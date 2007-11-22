; *** there is still something not quite right about this sound: 
;if you listen very carefully to the initial attack and the first slur point, 
;you can hear a slight buzzing noise. You can remove this by lengthening the 
;attack and decay time of the main envelope. 
;however, we dont want slow attacks all the time! What is going on? 
;In fact, the problem arises from the use of a slower control rate to update 
; the envelope values. It's fine for most things, but for fast attacks it is 
; still too coarse. By changing LINSEG to update on every sample (ie 
; by makeing it an audio-rate generator) we can eliminate the problem. 

;Expression control:
; in this instrument the expression is confined to a simple swell 
; (or its inverse). It is clearly possible to define more segments in the 
; linseg generator, either receiving parameters from the score, or selected 
; en bloc by a number.
; However, a more flexible solution arises directly from the tie mechanism - 
; it is possible to define a single note as made up of several 'sub-notes' 
; at the one pitch, each given its expression level. Notes of arbitrary 
; expressive complexity can be created this way, the only precaution being 
; the need, in the instrument definition, to ensure that line segment durations 
; do not exceed the overall duration (for a given sub-note). 



;basic4.sco
; add third slurred note, and try varied amps too 

f1  0 1024  10    1  
;neg p3 for a held note, NB: MUST use abs(p3) in orc! 
i1  0  -4     20000  333    pp5         ;held note, but p3 still controls envelope
; the slurred note: amp is what the main note will have got to, 
i1  2  -2     10000  523    pp5         ; special env for this
i1  3  1      7500   415    pp5
e

