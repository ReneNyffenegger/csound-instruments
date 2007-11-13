; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0

instr 1
 arand rand 10000 		; full band noise
 kcent line 100, p3, 2000	; line from 100 Hz to 2000 Hz
 afilter reson arand, kcent, 20 ; band-pass filter sweeping upwards
 afin balance afilter, arand	; balance the audio signals 
 out afin			; output
endin
