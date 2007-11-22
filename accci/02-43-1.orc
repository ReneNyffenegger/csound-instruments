; ************************************************************************
; ACCCI:      02-43-1.ORC
; timbre:     tibetan chant
; synthesis:  additive same units(02)
;             basic instrument with minimal differences in frequency(43)
;             arpeggio instrument by Risset
; source:     Phase6, Lorrain(1980); risset1.orc, MIT(1993)
; coded:      jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4/9
  ifq       =  p5
  ioff1     =  p6
  ioff2     =  2*p6
  ioff3     =  3*p6
  ioff4     =  4*p6
  irise     =  p7
  idec      =  p8

  ae        linen     iamp,irise,idur,idec   

  a1        oscili    ae, ifq, 1
  a2        oscili    ae, ifq+ioff1, 1            ; nine oscillators with the same ae
  a3        oscili    ae, ifq+ioff2, 1            ; and waveform, but slightly different
  a4        oscili    ae, ifq+ioff3, 1            ; frequencies create harmonic arpeggio 
  a5        oscili    ae, ifq+ioff4, 1
  a6        oscili    ae, ifq-ioff1, 1
  a7        oscili    ae, ifq-ioff2, 1
  a8        oscili    ae, ifq-ioff3, 1
  a9        oscili    ae, ifq-ioff4, 1
            outs1     a1+a2+a3+a4+a5+a6+a7+a8+a9

endin


instr 2; *****************************************************************
  idur      =  p3
  iamp      =  p4/9
  ifq       =  p5
  ioff1     =  p6
  ioff2     =  2*p6
  ioff3     =  3*p6
  ioff4     =  4*p6
  irise     =  p7
  idec      =  p8

  ae        linen     iamp,irise,idur,idec   

  a1        oscili    ae, ifq, 1
  a2        oscili    ae, ifq+ioff1, 1            ; nine oscillators with the same ae
  a3        oscili    ae, ifq+ioff2, 1            ; and waveform, but slightly different
  a4        oscili    ae, ifq+ioff3, 1            ; frequencies create harmonic arpeggio
  a5        oscili    ae, ifq+ioff4, 1
  a6        oscili    ae, ifq-ioff1, 1
  a7        oscili    ae, ifq-ioff2, 1
  a8        oscili    ae, ifq-ioff3, 1
  a9        oscili    ae, ifq-ioff4, 1
            outs2     a1+a2+a3+a4+a5+a6+a7+a8+a9
endin
