; ================arpeggio.o=================
; This instrument, designed by Risset, produces an arpeggiation in the
; harmonic series.  One can hear very clearly the individual harmonics
; come into phase.  The phenomenon of beating is again the means for
; doing this.  See the relavent passage in Chapter 3 (pp. 101-102) Dodge.

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

; p4      =         freq of fundamental (Hz)
; p5      =         amp
; p6      =         initial offset of freq - .03 Hz

; INIT VALUES CORRESPOND TO FREQ. OFFSETS FOR OSCILLATORS BASED ON ORIGINAL p6

i1        =         p6
i2        =         2*p6
i3        =         3*p6
i4        =         4*p6
                    
ampenv    linen     p5,.01,p3,.02            ; A SIMPLE ENVELOPE TO PREVENT CLICKING.
                                             
a1        oscili    ampenv,p4,1              ; NINE OSCILLATORS WITH THE SAME AMPLITUDE ENV
a2        oscili    ampenv,p4+i1,1           ; AND WAVEFORM, BUT SLIGHTLY DIFFERENT
a3        oscili    ampenv,p4+i2,1           ; FREQUENCIES TO CREATE THE BEATING EFFECT
a4        oscili    ampenv,p4+i3,1
a5        oscili    ampenv,p4+i4,1
a6        oscili    ampenv,p4-i1,1
a7        oscili    ampenv,p4-i2,1
a8        oscili    ampenv,p4-i3,1
a9        oscili    ampenv,p4-i4,1

          out       a1+a2+a3+a4+a5+a6+a7+a8+a9
          endin

