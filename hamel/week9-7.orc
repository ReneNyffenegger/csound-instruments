; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 ifor1 =	310		; formant 1
 iwid1 =	45		; width of formant 1
 ifor2 =	2020 		; formant 2
 iwid2 =	200		; width of formant 2
 ifor3 =	2960 		; formant 3
 iwid3 =	400		; width of formant 4
 abuzz buzz p4, cpspch(p5), 20, 1 	; buzz with 20 partials 
 afil1 reson abuzz, ifor1, iwid1	; band-pass filter formant 1
 afil1 balance afil1, abuzz ;	 balance the audio signals 
 afil2 reson abuzz, ifor2, iwid2	; band-pass filter formant 2
 afil2 balance afil2, abuzz 	; balance the audio signals 
 afil3 reson abuzz, ifor3, iwid3	; band-pass filter formant 3
 afil3 balance afil3, abuzz 	; balance the audio signals 
 out (afil1 + afil2 + afil3) / 3	; output the filtered signals
endin

