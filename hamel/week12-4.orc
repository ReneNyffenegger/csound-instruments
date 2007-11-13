; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0



instr 1
 ist = cpspch(p5)      		; start pitch
 iend = cpspch(p5 + 1.00)       	; end pitch
 kpitch line ist, p3, iend       	; gliss from start to end
 kenv linseg 0, p3/2, p4, p3/2, 0 	; up-down envelope 
 krand randi kpitch *.03, kr 	; a band of frequencies
 aindex1 phasor kpitch
 aindex2 phasor kpitch+2
 aindex3 phasor kpitch-2
 aindex4 phasor kpitch+5
 aindex5 phasor kpitch-5
 asig1   table aindex1 * 1024, 1;
 asig2   table aindex2 * 1024, 1;
 asig3   table aindex3 * 1024, 1;
 asig4   table aindex4 * 1024, 1;
 asig5   table aindex5 * 1024, 1;
 asig = (asig1+asig2+asig3+asig4+asig5)*.2
 out asig * kenv			; output signal
endin


