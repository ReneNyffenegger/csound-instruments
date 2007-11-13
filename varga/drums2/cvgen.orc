sr	=  48000
ksmps	=  64		; must be power of two
nchnls	=  2

; this instrument generates convolve file for reverb
; output format should be float with no range translation, or 0dBFS = 1

	instr 1

p3	=  131072.25 / sr	; length = 131072 samples (~2.7 secs)

; create empty table (table length should be 4 * IR length)
itmp	ftgen 1, 0, 524288, -2, 0

; the following parameters must be the same as in drums.orc

idist	=  0.5		; unit circle distance
ift	=  225		; room table
imode	=  2		; spat3dt mode

iX	=  4	; coordinates
iY	=  2
iZ	=  2

	spat3dt 1, iX, iY, iZ, idist, ift, imode, 0.005

; write table to output file

aftpos	line 0, 1, sr
aftpos	=  aftpos * 4 + 0.25

a1	table aftpos + 0, 1
a2	table aftpos + 1, 1
a3	table aftpos + 2, 1
a4	table aftpos + 3, 1

; decoder (must be the same as in drums.orc, see instr 99)

; decode to 2 chnls with phase shift

a1re, a1im	hilbert a1
a2re, a2im	hilbert a2
a3re, a3im	hilbert a3

aL	=  0.7071 * (a1re - a1im) + 0.5 * (a2re + a2im + a3re - a3im)
aR	=  0.7071 * (a1re + a1im) + 0.5 * (a2re - a2im - a3re - a3im)

	outs aL, aR

	endin

