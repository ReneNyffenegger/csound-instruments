sr	=  48000
ksmps	=  64		; must be power of two
nchnls	=  2

	instr 1

ilnth	filelen "drums.sf"		; file length
ilnth	=  ilnth + (2 * 131072 / sr)	; expand by 2 * reverb length

p3	=  ilnth

aL1, aR1	soundin "drums.sf"		; dry input
a0		soundin "mono_out.pcm", 0, 6

; convolve with reverb response

aL2, aR2	convolve a0, "reverb.cv"

; synchronize with convolve output

aL	delay aL1, 131072.25 / sr
aR	delay aR1, 131072.25 / sr

aL	=  aL + aL2
aR	=  aR + aR2

	outs aL, aR

	endin

